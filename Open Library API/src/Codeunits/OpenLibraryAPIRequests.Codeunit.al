codeunit 50850 "Open Library API Requests"
{


    procedure GetBooksByTitle(Query: Text): Text
    var
        OpenLibrarySetup: Record "Open Library Setup";
        AATRestHelper: Codeunit "AAT REST Helper";
        ResponseText: Text;
        APIErr: Label 'API Error.\Code: %1\Message: %2\Reason: %3', Comment = '%1=GetHttpStatusCode; %2=GetResponseContentAsText; %3=GetResponseReasonPhrase';
        FailedRequestErr: Label 'Failed to send Request. Check URL and try again.';
    begin
        // Initialize the request
        OpenLibrarySetup.GetRecordOnce();
        OpenLibrarySetup.TestField("OP-LIB No.");
        AATRestHelper.LoadAPIConfig(OpenLibrarySetup."OP-LIB No.");
        AATRestHelper.Initialize('GET', AATRestHelper.GetAPIConfigBaseEndpoint() + '?title=' + Query + '&fields=title,author_name,number_of_pages_median&limit=5');

        if not AATRESTHelper.Send() then begin
            Commit();
            if AATRESTHelper.IsTransmitIssue() then
                Error(FailedRequestErr);

            Error(
                APIErr,
                AATRESTHelper.GetHttpStatusCode(),
                AATRESTHelper.GetResponseContentAsText(),
                AATRESTHelper.GetResponseReasonPhrase()
            );
        end;

        // Get the response text
        ResponseText := AATRESTHelper.GetResponseContentAsText();
        exit(ResponseText);
    end;

    procedure ProcessJsonArray(ResponseText: Text; var TempOpenLibrary: Record "Temp Library")
    var
        AATJSONHelper: Codeunit "AAT JSON Helper";
        DocsJsonHelper: Codeunit "AAT JSON Helper";
        Title: Text;
        AuthorName: Text;
        Pages: Integer;
        JsonToken: JsonToken;
        JsonArr: JsonArray;
    begin

        AATJSONHelper.InitializeJsonObjectFromText(ResponseText);
        JsonArr := AATJSONHelper.SelectJsonToken('$.docs', true).AsArray();
        // Check if the JsonArray is not empty
        if JsonArr.Count() = 0 then begin
            Message('The JsonArray is empty.');
            exit;
        end;

        foreach JsonToken in JsonArr do begin
            DocsJsonHelper.InitializeJsonObjectFromToken(JsonToken);
            Title := DocsJsonHelper.SelectJsonValueAsText('$.title', true);
            AuthorName := GetAuthors(JsonToken);
            Pages := DocsJsonHelper.SelectJsonValueAsInteger('$.number_of_pages_median', true);

            // Add the values to the temporary table
            TempOpenLibrary.Init();
            
            TempOpenLibrary.Title := CopyStr(Title, 1, MaxStrLen(TempOpenLibrary.Title));
            TempOpenLibrary.Author := CopyStr(AuthorName, 1, MaxStrLen(TempOpenLibrary.Author));
            TempOpenLibrary.Pages := Pages;
            TempOpenLibrary.Insert(true);
            // TempOpenLibrary.Modify(true);
            
        end;
        Message('The data has been successfully added to the temporary table.');
    end;

    procedure GetAuthors(var JsonToken: JsonToken): Text
    var
        AuthorJsonHelper: Codeunit "AAT JSON Helper";
        JsonArr: JsonArray;
        AuthorName: Text;
        AuthorsText: Text;
        AuthorToken:JsonToken;
        AuthorJsonValue: JsonValue;
    begin
        AuthorJsonHelper.InitializeJsonObjectFromToken(JsonToken);
        JsonArr := AuthorJsonHelper.SelectJsonToken('$.author_name', true).AsArray();

        if JsonArr.Count() = 0 then begin
            Message('The JsonArray is empty.');
            exit;
        end;

        foreach AuthorToken in JsonArr do begin
            AuthorJsonValue := AuthorToken.AsValue();
            AuthorName := AuthorJsonValue.AsText();

            if AuthorsText <> '' then
                AuthorsText += '| ';
            AuthorsText += AuthorName;
        end;
        exit(AuthorsText);
    end;

}