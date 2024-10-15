# CleverLabellingSamples
This project is a set of samples intended to demonstrate to developers the various different means of extending Clever Labelling.

## NewLabelTrigger - Adding a new label trigger to your application
This example shows how to add a new label trigger for your own solution:

- SampleNewLabelTriggerType.EnumExt.al - Extend the label trigger enum.
- SampleNewLabelTriggerType.Codeunit.al - Contains a procedure that runs the trigger against a Warehouse Entry record. Any table is valid as long as there is a matching label design for that table.

## NewLabelTriggerNoDependency - Adding a new label trigger without a dependency
This example shows how to add a new label trigger for your own solution without a dependency on Clever Labelling. Note that you cannot extend the enum in this circumstance.

- SampleNoDependencyPrintLabel.Codeunit.al - Contains a procedure that runs an existing trigger against a Warehouse Entry record. Any table is valid as long as there is a matching label design for that table.