page 50701 "Book Orders Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Book Orders Table";

    

    layout
    {
        area(Content)
        {
            repeater("Orders")
            {

                field(OrderID; Rec.OrderID)
                {
                    ToolTip = 'Specifies the value of the Order ID field.';
                }
                field("Book Name"; Rec."Title")
                {
                    ToolTip = 'Specifies the value of the Book Name field.';
                }
                field("Retrun Date"; Rec."Retrun Date")
                {
                    ToolTip = 'Due to be returned before';
                }
                field(CustomerID; Rec.CustomerID)
                {
                    ToolTip = 'Specifies the value of the Customer ID field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Remove Order")
            {
                ApplicationArea = All;

                trigger OnAction();
                begin;
                
                end;
            }
        }
    }
}