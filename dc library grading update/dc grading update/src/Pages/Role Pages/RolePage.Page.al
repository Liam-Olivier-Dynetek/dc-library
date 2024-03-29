page 50756 "Role Page"
{
    PageType = RoleCenter;
    Caption = 'Library Role Center';

    layout
    {
        area(RoleCenter)
        {

            part(Part1; "Headline Librarian")
            {
                Caption = 'Library Overview';
                ApplicationArea = All;
            }
            part(Part2; "New Releases Cue")
            {
                Caption = 'Total Books';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections) //Next to the CRONUS logo
        {
            
        }

        area(Embedding) //Below the CRONUS logo
        {
            action("Damaged Books")
            {
                Caption = 'Damaged Books';
                RunObject = Page "Damaged Books";
                ApplicationArea = All;
                ToolTip = 'Opens the Damaged Books.';
            }

            action(Library)
            {
                Caption = 'Library';
                RunObject = Page "Library List";
                ApplicationArea = All;
                ToolTip = 'Opens the Library.';
            }
            action(Dashboard)
            {
                Caption = 'Dashboard';
                RunObject = Page "Dash Board";
                ApplicationArea = All;
                ToolTip = 'Opens the Dashboard.';
            }

        }

        area(Processing)
        {
            action("View Transactions")
            {
                Caption = 'View Transactions';
                RunObject = Page "Book Orders Page";
                ApplicationArea = All;
                ToolTip = 'Executes the View Transactions action.';
            }
        }

        area(Creation)
        {
            action("Add New Book")
            {
                Caption = 'Add New Book';
                Image = NewInvoice;
                RunObject = Page "Library List";
                RunPageMode = Create;
                ApplicationArea = All;
                ToolTip = 'Executes the Add New Book action.';
            }
        }

        area(Reporting)
        {
            action("OverDue Books")
            {
                Caption = 'Overdue Books Report';
                Image = "Report";
                RunObject = Report "Overdue Books Report";
                ApplicationArea = All;
                ToolTip = 'Executes the Overdue Books Report';
            }
        }
    }
}
