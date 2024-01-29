within SOFCPoliMi.Components.FuelCell;
model FlowMultiplier
  parameter Integer nX = 10;
  parameter Real multiplier;
  Interfaces.FlangeA inlet(nXi = nX, nC = 0, w(min = 0)) annotation (
    Placement(transformation(extent = {{-120, -20}, {-80, 20}}), iconTransformation(extent = {{-120, -20}, {-80, 20}})));
  Interfaces.FlangeB outlet(nXi = nX, nC = 0, w(max = 0)) annotation (
    Placement(transformation(extent = {{80, -20}, {120, 20}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
equation
  inlet.p = outlet.p;
  inlet.w*multiplier = -outlet.w;
  outlet.Xi = inStream(inlet.Xi);
  outlet.h = inStream(inlet.h);
  // Dummy
  inlet.Xi = zeros(nX);
  inlet.h = 0;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Ellipse(lineColor = {28, 108, 200}, fillColor = {170, 213, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {0, -2}, extent = {{-100, 100}, {100, -100}}, textString = "w")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end FlowMultiplier;
