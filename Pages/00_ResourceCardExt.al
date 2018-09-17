pageextension 123456700 "CDS ResourceCardExt" extends "Resource Card"
// CDS1.00 - 2018-09-17 - D. E. Veloper
{
    layout
    {
        addlast(General)
        {
            field("CDS Resource Type";"CDS Resource Type")
            {

            }
            field("CDS Quantity Per Day";"CDS Quantity Per Day")
            {

            }
        }
        addafter("Personal Data")
        {
            group("CDS Room")
            {
                 Visible = showMaxField;
                field("CDS Maximum Participants";"CDS Maximum Participants")
                {
                   
                }
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetRecord();
    begin
        showMaxField := Type = Type::Machine;
        CurrPage.Update(false);        
    end;
    var
        [InDataSet]
        showMaxField : Boolean;
}