# CleverLabellingSamples
This project is a set of samples intended to demonstrate to developers the various different means of extending Clever Labelling.

## NewLabelTrigger - Adding a new label trigger to your application
This example shows how to add a new label trigger for your own solution:

- SampleNewLabelTriggerType.EnumExt.al - Extend the label trigger enum.
- SampleNewLabelTriggerType.Codeunit.al - Contains a procedure that runs the trigger against a Warehouse Entry record. Any table is valid as long as there is a matching label design for that table.

## NewLabelTriggerNoDependency - Adding a new label trigger without a dependency
This example shows how to add a new label trigger for your own solution without a dependency on Clever Labelling. Note that you cannot extend the enum in this circumstance.

- SampleNoDependencyPrintLabel.Codeunit.al - Contains a procedure that runs an existing trigger against a Warehouse Entry record. Any table is valid as long as there is a matching label design for that table.

## SampleLabels - Sample label designs
Example label designs to use to create your own labels for use in Clever Labelling.

- SampleWarehouseEntryLabel.Report.al - Works on "Warehouse Entry". This design adds the Business Central Variant Code as "Routing Code" (Identifier 403). Please be aware that this is not GS1 compliant - Business Central Variant Codes are not catered to in the GS1 standard. It is recommended to use standard Item References in Business Central to add GTINs that match Item and Variant Code instead.