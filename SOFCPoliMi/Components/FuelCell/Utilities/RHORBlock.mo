within SOFCPoliMi.Components.FuelCell.Utilities;
model RHORBlock
  parameter Types.AreaSpecificReactionRate rate;
  Interfaces.FuelCellInterfaces.RHOROutputSignal rHOR annotation (
    Placement(visible = true, transformation(origin = {74, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {81, 1}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
equation
  rate = rHOR;
annotation (
    Icon(graphics={  Rectangle(extent = {{-100, 100}, {100, -100}})}));
end RHORBlock;
