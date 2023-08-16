within SOFCPoliMi.Components.FuelCell;
model VoltageMultiplier
  parameter Real Ns "Number of modules in eletric series connection";
  parameter Real Np "Number of modules in eletric parallel connection";
  Interfaces.FuelCellInterfaces.ElPin single annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent=
           {{-120,-20},{-80,20}})));
  Interfaces.FuelCellInterfaces.ElPin multiple annotation (Placement(
        transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{
            80,-20},{120,20}})));

equation

  single.v * Ns = multiple.v;
  single.i*Np + multiple.i = 0;


  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {255, 170, 85}, fillColor = {255, 170, 85}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {98, -96}}), Text(extent = {{-100, 100}, {100, -100}}, textString = "V")}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end VoltageMultiplier;
