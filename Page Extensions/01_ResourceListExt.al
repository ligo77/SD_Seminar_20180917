pageextension 123456701 "CDS ResourceLIstExt" extends "Resource List"
{
    layout
    {
        modify(Type)
        {
            Visible = Showtype;
        }
        addafter(Type)
        {
            field("CDS Resource Type";"CDS Resource Type")
            {

            }
            field("CDS Maximum Participants";"CDS Maximum Participants")
            {
                Visible = ShowMaxField;
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage();
    begin
        FilterGroup(3);
        Showtype := GetFilter(Type)='';
        ShowMaxField := GetFilter(Type)=format(Type::Machine);
        FilterGroup(0);
    end;
    var
        [InDataSet]
        ShowMaxField : Boolean;
        [InDataSet]
        Showtype : Boolean;
}