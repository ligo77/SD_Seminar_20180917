pageextension 123456702 "CSD SourceCodeSetupExt" extends "Source Code Setup"
{
    layout
    {
        addafter("Cost Accounting")
        {
            group(SeminarGroup)
            {
                Caption = 'Seminar';
            }
        }
        addfirst(SeminarGroup)
        {
            field(Seminar; "CSD Seminar")
            { }
        }
    }
}