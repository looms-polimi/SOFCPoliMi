within SOFCPoliMi.Components.Sources;

model IdealMassFlowRateSink
  
  parameter Integer nX = 10 "Number of species in the mixture";
  
  Interfaces.FlangeA flange(nXi = nX, nC = 0, w(min = 0)) annotation(
    Placement(transformation(origin = {-82, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
  parameter Types.MassFlowRate w;
equation
  
  flange.w = w;
  flange.Xi = zeros(nX);
  flange.h = 0;

annotation(
    Icon(graphics = {Rectangle(origin = {10, 0}, lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-90, 40}, {90, -40}}), Text(origin = {0, 7}, textColor = {255, 255, 255}, extent = {{-16, 45}, {16, -45}}, textString = "w")}));
end IdealMassFlowRateSink;
