codeunit 123456731 "CSD Seminar Jnl.-Check Line"
{
    TableNo = "CSD Seminar Journal Line";

    trigger OnRun();
    begin
        RunCheck(Rec);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ClostingDateTxt: Label 'cannot be a closing date.';
        PostingDateTxt: Label 'is not within your range of allowed posting dates.';

    procedure RunCheck(var SemJnlLine: Record "CSD Seminar Journal Line");
    begin
        with SemJnlLine do
        begin
            if EmptyLine() then
                exit;
            TestField("Posting Date");
            TestField("Instructor Resource No.");
            TestField("Seminar No.");

            case "Charge Type" of
            "Charge Type"::Instructor :
                TestField("Instructor Resource No.");
            "Charge Type"::Participant :
                TestField("Participant Contact No.");
            "Charge Type"::Room :
                TestField("Room Resource No.");

            end;

            if Chargeable then
                TestField("Bill-to Customer No.");

            if "Posting Date" = ClosingDate("Posting Date") then
                FieldError("Posting Date", ClostingDateTxt);

            if(AllowPostingFrom = 0D) AND(AllowPostingTo = 0D) then begin
                if UserId <> '' then
                    if UserSetup.Get(UserId) then begin
                        AllowPostingFrom := UserSetup."Allow Posting From";
                        AllowPostingTo := UserSetup."Allow Posting To";
                    end;

                if(AllowPostingFrom = 0D) AND(AllowPostingTo = 0D) then begin
                    GLSetup.Get;
                    AllowPostingFrom := GLSetup."Allow Posting From";
                    AllowPostingTo := GLSetup."Allow Posting To";
                end;

                if AllowPostingTo = 0D then
                    AllowPostingTo := DMY2Date(31, 12, 9999);
            end;

            if("Posting Date" < AllowPostingFrom) OR("Posting Date" > AllowPostingTo) then
                FieldError("Posting Date", PostingDateTxt);

            if "Document Date" <> 0D then
                if "Document Date" = ClosingDate("Document Date") then
                    FieldError("Document Date", ClostingDateTxt);

        end;
    end;

}