codeunit 123456732 "CSD Seminar Jnl.-Post Line"
{
    TableNo = "CSD Seminar Journal Line";

    trigger OnRun();
    begin
        RunWithCheck(Rec);
    end;

    var
        SemJnlLine: Record "CSD Seminar Journal Line";
        SemLedgerEntry: Record "CSD Seminar Ledger Entry";
        SemRegister: Record "CSD Seminar Register";
        SemJnlCheckLine: Codeunit "CSD Seminar Jnl.-Check Line";
        NextEntryNo: Integer;

    procedure RunWithCheck(var SeminarJnlLine2: Record "CSD Seminar Journal Line");
    begin
        with SeminarJnlLine2 do
        begin
            SemJnlLine := SeminarJnlLine2;
            Code();
            SeminarJnlLine2 := SemJnlLine;
        end;
    end;

    local procedure Code();
    begin
        with SemJnlLine do
        begin
            if EmptyLine() then
                exit;
            SemJnlCheckLine.RunCheck(SemJnlLine);

            if NextEntryNo = 0 then begin
                SemLedgerEntry.LockTable;
                if SemLedgerEntry.FindLast then
                    NextEntryNo := SemLedgerEntry."Entry No." + 1
                else
                    NextEntryNo := 1;
            end;

            if "Document Date" = 0D then
                "Document Date" := "Posting Date";

            if SemRegister."No." = 0 then begin
                SemRegister.LockTable;
                if(not SemRegister.FindLast) or(SemRegister."To Entry No." = 0) then begin
                    SemRegister.Init;
                    SemRegister."No." := SemRegister."No." + 1;
                    SemRegister."From Entry No." := NextEntryNo;
                    SemRegister."To Entry No." := NextEntryNo;
                    SemRegister."Creation Date" := Today;
                    SemRegister."Source Code" := "Source Code";
                    SemRegister."Journal Batch Name" := "Journal Batch Name";
                    SemRegister."User ID" := USERID;
                    SemRegister.Insert;
                end;

                SemRegister."To Entry No." := NextEntryNo;
                SemRegister.Modify;
            end;

            SemLedgerEntry.Init;
            SemLedgerEntry."Seminar No." := "Seminar No.";
            SemLedgerEntry."Posting Date" := "Posting Date";
            SemLedgerEntry."Document Date" := "Document Date";
            SemLedgerEntry."Entry Type" := "Entry Type";
            SemLedgerEntry."Document No." := "Document No.";
            SemLedgerEntry.Description := Description;
            SemLedgerEntry."Bill-to Customer No." := "Bill-to Customer No.";
            SemLedgerEntry."Charge Type" := "Charge Type";
            SemLedgerEntry.Type := Type;
            SemLedgerEntry.Type := Type;
            SemLedgerEntry.Quantity := Quantity;
            SemLedgerEntry."Unit Price" := "Unit Price";
            SemLedgerEntry."Total Price" := "Total Price";
            SemLedgerEntry."Participant Contact No." := "Participant Contact No.";
            SemLedgerEntry."Participant Name" := "Participant Name";
            SemLedgerEntry.Chargeable := Chargeable;
            SemLedgerEntry."Room Resource No." := "Room Resource No.";
            SemLedgerEntry."Instructor Resource No." := "Instructor Resource No.";
            SemLedgerEntry."Starting Date" := "Starting Date";
            SemLedgerEntry."Seminar Registration No." := "Seminar Registration No.";
            SemLedgerEntry."Res. Ledger Entry No." := "Res. Ledger Entry No.";
            SemLedgerEntry."Source Type" := "Source Type";
            SemLedgerEntry."Source No." := "Source No.";
            SemLedgerEntry."Journal Batch Name" := "Journal Batch Name";
            SemLedgerEntry."Source Code" := "Source Code";
            SemLedgerEntry."Reason Code" := "Reason Code";
            SemLedgerEntry."No. Series" := "Posting No. Series";
            SemLedgerEntry."User ID" := USERID;
            SemLedgerEntry."Entry No." := NextEntryNo;
            SemLedgerEntry.insert;
            NextEntryNo := NextEntryNo + 1;
        end;
    end;
}