codeunit 50100 "Sample New Trigger Print Label"
{
    procedure PrintLabel(var WarehouseEntry: Record "Warehouse Entry"; ShowError: Boolean)
    var
        LabelTriggerMgt: Codeunit "Label Trigger Mgt CLBTMN";
    begin
        if not LabelTriggerMgt.TriggerLabelOutput("Label Trigger Type CLBTMN"::SampleNewLabelTriggerType, WarehouseEntry) then
            if ShowError then
                LabelTriggerMgt.ShowNothingPrintedError("Label Trigger Type CLBTMN"::SampleNewLabelTriggerType);
    end;
}