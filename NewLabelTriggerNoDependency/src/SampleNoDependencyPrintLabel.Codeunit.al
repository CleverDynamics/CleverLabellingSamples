codeunit 50101 "Sample No Dependency Print Lbl"
{
    procedure PrintLabel(var WarehouseEntry: Record "Warehouse Entry"; ShowError: Boolean)
    var
        AdditionsIntegration: Codeunit "Additions Integration CCTMN";
        RecRef: RecordRef;
        IsHandled: Boolean;
        AnyPrinted: Boolean;
    begin
        RecRef.GetTable(WarehouseEntry);
        AdditionsIntegration.SetIntegrationData('TriggerType', 'Posted Warehouse Receipt');
        AdditionsIntegration.SetIntegrationData('RecRef', RecRef);
        AdditionsIntegration.InvokeEvent('OnTriggerLabelOutputCLBTMN', IsHandled);
        if ShowError then
            if IsHandled then begin
                AnyPrinted := AdditionsIntegration.GetIntegrationDataBoolean('AnyPrinted', 0);
                if not AnyPrinted then
                    AdditionsIntegration.InvokeEvent('OnShowNothingPrintedErrorCLBTMN', IsHandled);
            end;
    end;
}