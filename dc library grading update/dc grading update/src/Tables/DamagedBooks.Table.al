//Table that contains all the books with a D rating
table 50750 DamagedBooks
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(10;DamagedBookID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(20; BookID; Integer)
        {
            TableRelation = "Library Table".BookID;
        }
        field(30; "Book Title"; Text[100])
        {
            TableRelation = "Library Table".Title;
        }
        field(40; "Book Grading"; Enum BookQualityRating)
        {
            TableRelation = "Library Table"."Quality Rating";
        }
        field(50; "Book Status"; Enum "Book Status")
        {
            TableRelation = "Library Table".Rented;
        }
    }
    
    keys
    {
        key(PK; DamagedBookID)
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}