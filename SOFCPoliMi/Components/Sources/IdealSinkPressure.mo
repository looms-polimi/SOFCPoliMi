within SOFCPoliMi.Components.Sources;
model IdealSinkPressure
  parameter Integer nX = 10 "Number of species in the mixture";
  Interfaces.FlangeB flange(nXi = nX, nC = 0, w(min = 0)) annotation (
    Placement(visible = true, transformation(origin = {0, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Types.Pressure p;
equation
  flange.p = p;
  flange.Xi = zeros(nX);
  flange.h = 0;
  annotation (
    Icon(graphics={  Ellipse(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-60, 60}, {60, -60}})}));
end IdealSinkPressure;
