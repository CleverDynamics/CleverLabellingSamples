report 50100 "Sample Warehouse Entry Label"
{
    Caption = 'Warehouse Entry Label';
    DefaultRenderingLayout = "SampleWarehouseEntryLabel.100x150.ReportLayout.docx";
    ApplicationArea = All;
    WordMergeDataItem = TempWarehouseEntryLoop;

    dataset
    {
        dataitem(WarehouseEntry; "Warehouse Entry")
        {
            RequestFilterFields = "Reference No.", "Item No.", "Entry No.";
            column(WarehouseEntryNo; "Entry No.")
            {
            }
            dataitem(ContainerLoop; Integer)
            {
                DataItemTableView = sorting(Number);
                column(ContainerLoopNumber; Number)
                {
                }

                dataitem(CopyLoop; Integer)
                {
                    DataItemTableView = sorting(Number);
                    column(CopyLoopNumber; Number)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        if NoOfCopies = 0 then
                            NoOfCopies := 1;
                        SetRange(Number, 1, NoOfCopies);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        TempWarehouseEntry.Init();
                        TempWarehouseEntry."Entry No." += 1;
                        TempWarehouseEntry.TransferFields(WarehouseEntry, false);
                        TempWarehouseEntry.Quantity := LabelQuantity;
                        TempWarehouseEntry.Weight := LabelWeight;
                        TempWarehouseEntry.Insert();
                    end;
                }

                trigger OnPreDataItem()
                begin
                    Clear(ItemUnitOfMeasure);
                    if (ItemUnitOfMeasure.Get(WarehouseEntry."Item No.", WarehouseEntry."Unit of Measure Code")) and
                        (ItemUnitOfMeasure."Qty. per Container CLBTMN" > 0) then
                        ContainerCount := Round(WarehouseEntry.Quantity / ItemUnitOfMeasure."Qty. per Container CLBTMN", 1, '>')
                    else
                        ContainerCount := 1;
                    SetRange(Number, 1, ContainerCount);
                    LblRemainingQty := WarehouseEntry.Quantity;
                end;

                trigger OnAfterGetRecord()
                begin
                    if ItemUnitOfMeasure."Qty. per Container CLBTMN" > 0 then begin
                        if LblRemainingQty = 0 then
                            LblRemainingQty := WarehouseEntry.Quantity;
                        if LblRemainingQty > ItemUnitOfMeasure."Qty. per Container CLBTMN" then
                            LabelQuantity := ItemUnitOfMeasure."Qty. per Container CLBTMN"
                        else
                            LabelQuantity := LblRemainingQty;
                        LblRemainingQty -= LabelQuantity;
                        LabelQuantity := Abs(LabelQuantity);
                        LabelWeight := ItemUnitOfMeasure.Weight * LabelQuantity;
                    end
                    else begin
                        LabelQuantity := Abs(WarehouseEntry.Quantity);
                        LabelWeight := Item."Net Weight" * Abs(WarehouseEntry."Qty. (Base)");
                    end;
                end;

            }

        }

        dataitem(TempWarehouseEntryLoop; Integer)
        {
            DataItemTableView = sorting(Number);
            column(TempWarehouseEntryNo; Number)
            {
            }
            column(ExpirationDateCaption; ExpirationDateCaption)
            {
            }
            column(WarrantyDateCaption; WarrantyDateCaption)
            {
            }
            column(QuantityCaption; QuantityCaption)
            {
            }
            column(LotNoCaption; LotNoCaption)
            {
            }
            column(SerialNoCaption; SerialNoCaption)
            {
            }
            column(PackageNoCaption; PackageNoCaption)
            {
            }
            column(ExpirationDate; Format(TempWarehouseEntry."Expiration Date"))
            {
            }
            column(Quantity; TempWarehouseEntry.Quantity)
            {
            }
            column(Description; TempWarehouseEntry.Description)
            {
                IncludeCaption = true;
            }
            column(ItemNo; TempWarehouseEntry."Item No.")
            {
                IncludeCaption = true;
            }
            column(LotNo; TempWarehouseEntry."Lot No.")
            {
            }
            column(SerialNo; TempWarehouseEntry."Serial No.")
            {
            }
            column(WarrantyDate; Format(TempWarehouseEntry."Warranty Date"))
            {
            }
            column(FormattedQuantity; FormattedQuantity)
            {
            }
            column(PackageNo; TempWarehouseEntry."Package No.")
            {
            }
            column(BarcodeCode39_1; BarcodeCode39_1)
            {
            }
            column(BarcodeCodabar_1; BarcodeCodabar_1)
            {
            }
            column(BarcodeCode128_1; BarcodeCode128_1)
            {
            }
            column(BarcodeCode93_1; BarcodeCode93_1)
            {
            }
            column(BarcodeInterleaved2of5_1; BarcodeInterleaved2of5_1)
            {
            }
            column(BarcodePostnet_1; BarcodePostnet_1)
            {
            }
            column(BarcodeMSI_1; BarcodeMSI_1)
            {
            }
            column(BarcodeUPCEAN_1; BarcodeUPCEAN_1)
            {
            }
            column(HumanReadableBarcode_1; HumanReadableBarcode_1)
            {
            }
            column(BarcodeCode39_2; BarcodeCode39_2)
            {
            }
            column(BarcodeCodabar_2; BarcodeCodabar_2)
            {
            }
            column(BarcodeCode128_2; BarcodeCode128_2)
            {
            }
            column(BarcodeCode93_2; BarcodeCode93_2)
            {
            }
            column(BarcodeInterleaved2of5_2; BarcodeInterleaved2of5_2)
            {
            }
            column(BarcodePostnet_2; BarcodePostnet_2)
            {
            }
            column(BarcodeMSI_2; BarcodeMSI_2)
            {
            }
            column(BarcodeUPCEAN_2; BarcodeUPCEAN_2)
            {
            }
            column(HumanReadableBarcode_2; HumanReadableBarcode_2)
            {
            }
            column(WeightCaption; WeightCaption)
            {
            }
            column(FormattedWeight; FormattedWeight)
            {
            }
            column(GTINCaption; GTINCaption)
            {
            }
            column(GTINCode; GTINCode)
            {
            }
            column(DocumentNo; TempWarehouseEntry."Reference No.")
            {
            }
            column(ExternalDocumentNo; ExternalDocumentNo)
            {
            }
            column(Address1; Address[1])
            {
            }
            column(Address2; Address[2])
            {
            }
            column(Address3; Address[3])
            {
            }
            column(Address4; Address[4])
            {
            }
            column(Address5; Address[5])
            {
            }
            column(Address6; Address[6])
            {
            }
            column(Address7; Address[7])
            {
            }
            column(Address8; Address[8])
            {
            }

            column(ItemAttributeName1; ItemAttributeName[1])
            {
            }
            column(ItemAttributeValue1; ItemAttributeValue[1])
            {
            }
            column(ItemAttributeName2; ItemAttributeName[2])
            {
            }
            column(ItemAttributeValue2; ItemAttributeValue[2])
            {
            }
            column(ItemAttributeName3; ItemAttributeName[3])
            {
            }
            column(ItemAttributeValue3; ItemAttributeValue[3])
            {
            }
            column(ItemAttributeName4; ItemAttributeName[4])
            {
            }
            column(ItemAttributeValue4; ItemAttributeValue[4])
            {
            }
            column(ItemAttributeName5; ItemAttributeName[5])
            {
            }
            column(ItemAttributeValue5; ItemAttributeValue[5])
            {
            }
            column(ItemAttributeName6; ItemAttributeName[6])
            {
            }
            column(ItemAttributeValue6; ItemAttributeValue[6])
            {
            }
            column(ItemAttributeName7; ItemAttributeName[7])
            {
            }
            column(ItemAttributeValue7; ItemAttributeValue[7])
            {
            }
            column(ItemAttributeName8; ItemAttributeName[8])
            {
            }
            column(ItemAttributeValue8; ItemAttributeValue[8])
            {
            }
            column(ItemAttributeName9; ItemAttributeName[9])
            {
            }
            column(ItemAttributeValue9; ItemAttributeValue[9])
            {
            }
            column(ItemAttributeName10; ItemAttributeName[10])
            {
            }
            column(ItemAttributeValue10; ItemAttributeValue[10])
            {
            }

            column(VariantCodeCaption; VariantCodeCaption)
            {
            }
            column(VariantCode; TempWarehouseEntry."Variant Code")
            {
            }

            trigger OnPreDataItem()
            begin
                SetRange(Number, 1, TempWarehouseEntry.Count);
            end;

            trigger OnAfterGetRecord()
            var
                ItemVariant: Record "Item Variant";
                ReportManagement: Codeunit "Report Management CLBTMN";
                BarcodeManagement: Codeunit "Barcode Management CLBTMN";
                BarcodeSymbology: Enum "Barcode Symbology";
            begin
                if Number = 1 then
                    TempWarehouseEntry.FindSet()
                else
                    if TempWarehouseEntry.Next() = 0 then
                        CurrReport.Break();

                Item.Get(TempWarehouseEntry."Item No.");
                TempWarehouseEntry.Description := Item.Description;
                if (TempWarehouseEntry."Variant Code" <> '') and ItemVariant.Get(TempWarehouseEntry."Item No.", TempWarehouseEntry."Variant Code") then
                    TempWarehouseEntry.Description := ItemVariant.Description;

                ExpirationDateCaption := '';
                WarrantyDateCaption := '';
                LotNoCaption := '';
                SerialNoCaption := '';
                PackageNoCaption := '';
                WeightCaption := '';
                GTINCaption := '';
                VariantCodeCaption := '';
                QuantityCaption := TempWarehouseEntry.FieldCaption("Quantity");
                if TempWarehouseEntry."Expiration Date" <> 0D then
                    ExpirationDateCaption := TempWarehouseEntry.FieldCaption("Expiration Date");
                if TempWarehouseEntry."Warranty Date" <> 0D then
                    WarrantyDateCaption := TempWarehouseEntry.FieldCaption("Warranty Date");
                if TempWarehouseEntry."Lot No." <> '' then
                    LotNoCaption := TempWarehouseEntry.FieldCaption("Lot No.");
                if TempWarehouseEntry."Package No." <> '' then
                    PackageNoCaption := TempWarehouseEntry.FieldCaption("Package No.");
                if TempWarehouseEntry.Weight <> 0 then
                    WeightCaption := TempWarehouseEntry.FieldCaption(Weight);
                if TempWarehouseEntry."Variant Code" <> '' then
                    VariantCodeCaption := TempWarehouseEntry.FieldCaption("Variant Code");

                FormattedQuantity := Format(TempWarehouseEntry.Quantity) + ' ' + TempWarehouseEntry."Unit of Measure Code";
                FormattedWeight := Format(TempWarehouseEntry.Weight);

                if TempWarehouseEntry."Serial No." <> '' then begin
                    SerialNoCaption := TempWarehouseEntry.FieldCaption("Serial No.");
                    QuantityCaption := '';
                    FormattedQuantity := '';
                end;

                GetAddressFromWarehouseEntry();

                GTINCode := ReportManagement.GetItemGTIN(TempWarehouseEntry."Item No.", TempWarehouseEntry."Variant Code", TempWarehouseEntry."Unit of Measure Code");
                if GTINCode <> '' then
                    GTINCaption := GTINCaptionLabel;

                ReportManagement.LoadItemAttributes(Item, ItemAttributeName, ItemAttributeValue);

                BarcodeManagement.SetReportID(Report::"Warehouse Entry Label CLBTMN");
                BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::"Item No.", TempWarehouseEntry."Item No.");
                BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::"Lot No.", TempWarehouseEntry."Lot No.");
                BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::"Serial No.", TempWarehouseEntry."Serial No.");
                if TempWarehouseEntry."Serial No." = '' then
                    BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::Quantity, TempWarehouseEntry.Quantity);
                BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::"Expiration Date", TempWarehouseEntry."Expiration Date");
                if TempWarehouseEntry."Source Type" = Database::"Prod. Order Line" then
                    BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::"Production Date", TempWarehouseEntry."Registering Date");
                BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::"Net Weight", TempWarehouseEntry.Weight);
                BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::GTIN, GTINCode);
                // This adds variant code as the "Routing Code" identifier. This is NOT GS1 compliant!!
                BarcodeManagement.AddBarcodeIdentifier("Barcode Identifier CLBTMN"::"Routing Code", TempWarehouseEntry."Variant Code");

                BarcodeCode39_1 := '';
                BarcodeCodabar_1 := '';
                BarcodeCode128_1 := '';
                BarcodeCode93_1 := '';
                BarcodeInterleaved2of5_1 := '';
                BarcodePostnet_1 := '';
                BarcodeMSI_1 := '';
                BarcodeUPCEAN_1 := '';
                HumanReadableBarcode_1 := '';
                BarcodeCode39_2 := '';
                BarcodeCodabar_2 := '';
                BarcodeCode128_2 := '';
                BarcodeCode93_2 := '';
                BarcodeInterleaved2of5_2 := '';
                BarcodePostnet_2 := '';
                BarcodeMSI_2 := '';
                BarcodeUPCEAN_2 := '';
                HumanReadableBarcode_2 := '';

                BarcodeManagement.EncodeBarcodeFont(1, BarcodeSymbology, EncodedBarcodeString, HumanReadableBarcode_1);
                case BarcodeSymbology of
                    BarcodeSymbology::Code39:
                        BarcodeCode39_1 := EncodedBarcodeString;
                    BarcodeSymbology::Codabar:
                        BarcodeCodabar_1 := EncodedBarcodeString;
                    BarcodeSymbology::Code128:
                        BarcodeCode128_1 := EncodedBarcodeString;
                    BarcodeSymbology::Code93:
                        BarcodeCode93_1 := EncodedBarcodeString;
                    BarcodeSymbology::Interleaved2of5:
                        BarcodeInterleaved2of5_1 := EncodedBarcodeString;
                    BarcodeSymbology::Postnet:
                        BarcodePostnet_1 := EncodedBarcodeString;
                    BarcodeSymbology::MSI:
                        BarcodeMSI_1 := EncodedBarcodeString;
                    BarcodeSymbology::"EAN-8", BarcodeSymbology::"EAN-13", BarcodeSymbology::"UPC-A", BarcodeSymbology::"UPC-E":
                        BarcodeUPCEAN_1 := EncodedBarcodeString;
                end;

                BarcodeManagement.EncodeBarcodeFont(2, BarcodeSymbology, EncodedBarcodeString, HumanReadableBarcode_2);
                case BarcodeSymbology of
                    BarcodeSymbology::Code39:
                        BarcodeCode39_2 := EncodedBarcodeString;
                    BarcodeSymbology::Codabar:
                        BarcodeCodabar_2 := EncodedBarcodeString;
                    BarcodeSymbology::Code128:
                        BarcodeCode128_2 := EncodedBarcodeString;
                    BarcodeSymbology::Code93:
                        BarcodeCode93_2 := EncodedBarcodeString;
                    BarcodeSymbology::Interleaved2of5:
                        BarcodeInterleaved2of5_1 := EncodedBarcodeString;
                    BarcodeSymbology::Postnet:
                        BarcodePostnet_2 := EncodedBarcodeString;
                    BarcodeSymbology::MSI:
                        BarcodeMSI_2 := EncodedBarcodeString;
                    BarcodeSymbology::"EAN-8", BarcodeSymbology::"EAN-13", BarcodeSymbology::"UPC-A", BarcodeSymbology::"UPC-E":
                        BarcodeUPCEAN_2 := EncodedBarcodeString;
                end;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. of Copies';
                        ToolTip = 'The number of copies to print.';
                        MinValue = 1;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if NoOfCopies = 0 then
                NoOfCopies := 1;
        end;
    }

    rendering
    {
        layout("SampleWarehouseEntryLabel.100x150.ReportLayout.docx")
        {
            Type = Word;
            LayoutFile = './SampleLabels/src/SampleWarehouseEntryLabel.100x150.ReportLayout.docx';
            Caption = 'Sample Label (100mm x 150mm)';
            Summary = 'Sample 100mm x 150mm label layout.';
        }
        layout("SampleWarehouseEntryLabel.120x70.ReportLayout.docx")
        {
            Type = Word;
            LayoutFile = './SampleLabels/src/SampleWarehouseEntryLabel.120x70.ReportLayout.docx';
            Caption = 'Sample Label (120mm x 70mm)';
            Summary = 'Sample 120mm x 70mm label layout.';
        }
    }

    var
        TempWarehouseEntry: Record "Warehouse Entry" temporary;
        Item: Record Item;
        ItemUnitOfMeasure: Record "Item Unit of Measure";
        ItemAttributeName: Array[10] of Text;
        ItemAttributeValue: Array[10] of Text;
        Address: Array[8] of Text;
        ExternalDocumentNo: Text;
        EncodedBarcodeString: Text;
        HumanReadableBarcode_1: Text;
        BarcodeCode39_1: Text;
        BarcodeCodabar_1: Text;
        BarcodeCode128_1: Text;
        BarcodeCode93_1: Text;
        BarcodeInterleaved2of5_1: Text;
        BarcodePostnet_1: Text;
        BarcodeMSI_1: Text;
        BarcodeUPCEAN_1: Text;
        HumanReadableBarcode_2: Text;
        BarcodeCode39_2: Text;
        BarcodeCodabar_2: Text;
        BarcodeCode128_2: Text;
        BarcodeCode93_2: Text;
        BarcodeInterleaved2of5_2: Text;
        BarcodePostnet_2: Text;
        BarcodeMSI_2: Text;
        BarcodeUPCEAN_2: Text;
        ExpirationDateCaption: Text;
        WarrantyDateCaption: Text;
        QuantityCaption: Text;
        LotNoCaption: Text;
        SerialNoCaption: Text;
        PackageNoCaption: Text;
        WeightCaption: Text;
        GTINCaption: Text;
        GTINCode: Text;
        LblRemainingQty: Decimal;
        LabelQuantity: Decimal;
        LabelWeight: Decimal;
        FormattedQuantity: Text;
        FormattedWeight: Text;
        NoOfCopies: Integer;
        ContainerCount: Integer;
        GTINCaptionLabel: Label 'GTIN';
        VariantCodeCaption: Text;

    local procedure GetAddressFromWarehouseEntry()
    var
        SalesHeader: Record "Sales Header";
        SalesShipmentHeader: Record "Sales Shipment Header";
        PurchaseHeader: Record "Purchase Header";
        ReturnShipmentHeader: Record "Return Shipment Header";
        TransferHeader: Record "Transfer Header";
        TransferShipmentHeader: Record "Transfer Shipment Header";
        FormatAddress: Codeunit "Format Address";
        Address2: array[8] of Text;
    begin
        case TempWarehouseEntry."Source Type" of
            Database::"Sales Line":
                begin
                    if SalesHeader.Get(TempWarehouseEntry."Source Subtype", TempWarehouseEntry."Source No.") then begin
                        FormatAddress.SalesHeaderShipTo(Address, Address2, SalesHeader);
                        ExternalDocumentNo := SalesHeader."External Document No.";
                    end
                    else begin
                        SalesShipmentHeader.SetCurrentKey("Order No.");
                        SalesShipmentHeader.SetRange("Order No.", TempWarehouseEntry."Source No.");
                        if SalesShipmentHeader.FindFirst() then begin
                            FormatAddress.SalesShptShipTo(Address, SalesShipmentHeader);
                            ExternalDocumentNo := SalesShipmentHeader."External Document No.";
                        end;
                    end;
                end;
            Database::"Purchase Line":
                begin
                    if PurchaseHeader.Get(TempWarehouseEntry."Source Subtype", TempWarehouseEntry."Source No.") then begin
                        FormatAddress.PurchHeaderShipTo(Address, PurchaseHeader);
                        ExternalDocumentNo := PurchaseHeader."Vendor Authorization No.";
                    end
                    else begin
                        ReturnShipmentHeader.SetCurrentKey("Return Order No.");
                        ReturnShipmentHeader.SetRange("Return Order No.", TempWarehouseEntry."Source No.");
                        if ReturnShipmentHeader.FindFirst() then begin
                            FormatAddress.PurchShptShipTo(Address, ReturnShipmentHeader);
                            ExternalDocumentNo := ReturnShipmentHeader."Vendor Authorization No.";
                        end;
                    end;
                end;
            Database::"Transfer Line":
                begin
                    if TransferHeader.Get(TempWarehouseEntry."Source No.") then begin
                        FormatAddress.TransferHeaderTransferTo(Address, TransferHeader);
                        ExternalDocumentNo := TransferHeader."External Document No.";
                    end
                    else begin
                        TransferShipmentHeader.SetCurrentKey("Transfer Order No.");
                        TransferShipmentHeader.SetRange("Transfer Order No.", TempWarehouseEntry."Source No.");
                        if TransferShipmentHeader.FindFirst() then begin
                            FormatAddress.TransferShptTransferTo(Address, TransferShipmentHeader);
                            ExternalDocumentNo := TransferShipmentHeader."External Document No.";
                        end;
                    end;
                end;
            else begin
                Clear(Address);
                ExternalDocumentNo := '';
            end;
        end;
    end;
}

