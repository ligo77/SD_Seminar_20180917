tableextension 123456700 "CDSResourceExt" extends Resource
// CDS1.00 - 2018-09-17 - D. E. Veloper
{
    fields
    {
        modify("Profit %")
        {
            trigger OnAfterValidate();
            begin
                Rec.TestField("Unit Cost");
            end;
        }
        field(123456701;"CDS Resource Type";Option)
        {
            Caption = 'Resource Type';
            OptionMembers=Internal,External;
            OptionCaption='Internal,External';
        }
        field(123456702;"CDS Maximum Participants";Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(123456703;"CDS Quantity Per Day";Decimal)
        {
            Caption = 'Quantity Per Day';
        }
      
    }
    
    var
        myInt : Integer;
}