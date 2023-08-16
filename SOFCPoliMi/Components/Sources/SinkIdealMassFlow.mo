within SOFCPoliMi.Components.Sources;
model SinkIdealMassFlow
  parameter Integer nX = 10 "Number of species in the mixture";
  SOFCPoliMi.Interfaces.FlangeB flange(nXi = nX, nC=0) annotation (
    Placement(visible = true, transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput wOut annotation (
    Placement(visible = true, transformation(origin = {-30, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={0,60},    extent = {{-20, -20}, {20, 20}}, rotation = -90)));
equation

  wOut = flange.w;
  flange.Xi = zeros(nX);
  flange.h = 0;

annotation (
    Icon(graphics={  Rectangle(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-100, 60}, {100, -60}}), Polygon(points = {{-40, 40}, {-40, -40}, {40, 0}, {-40, 40}}), Text(origin = {0, -84}, extent = {{-100, 20}, {100, -20}}, textString = "%name")}));
end SinkIdealMassFlow;
