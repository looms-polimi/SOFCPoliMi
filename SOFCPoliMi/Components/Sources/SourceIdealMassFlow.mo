within SOFCPoliMi.Components.Sources;
model SourceIdealMassFlow
  // Parameters
  parameter Integer nX = 10 "Number of species in the mixture";
  // Initialization
  parameter Types.Pressure p_start = 27.5e5 "";
  parameter Types.Temperature T_start = 920 "";
  parameter Types.MassFraction X_start[nX] "";
  parameter Types.Density rho_start "";
  // Media
  replaceable model Medium = Media.MainClasses.SOS10Components;
  Medium fluid( T_start=T_start, p_start=p_start, X_start=X_start, rho_start=rho_start) "Fluid moved by the source";
  // Connectors
  Interfaces.FlangeB flange(nXi = nX, nC=0) annotation (
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 1.77636e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Modelica.Blocks.Interfaces.RealInput w annotation (
    Placement(visible = true, transformation(origin = {-80, 50}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-80, 40}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput X[nX] annotation (
    Placement(visible = true, transformation(origin = {-80, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-20, 40}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput Tset annotation (
    Placement(visible = true, transformation(origin = {-80, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, 40}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
equation

  fluid.T = Tset;
  fluid.p = flange.p;
  fluid.Xi = X "";

  flange.w = -w;
  flange.Xi = fluid.X;
  flange.h = fluid.h;


annotation (
    Icon(graphics={  Rectangle(origin = {-10, 0}, lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-90, 40}, {90, -40}}), Text(origin = {-80, 7}, lineColor = {255, 255, 255}, extent = {{-16, 45}, {16, -45}}, textString = "w"), Text(origin = {-80, 7}, lineColor = {255, 255, 255}, extent = {{-16, 45}, {16, -45}}, textString = "w"), Text(origin = {-80, 7}, lineColor = {255, 255, 255}, extent = {{-16, 45}, {16, -45}}, textString = "w"), Text(origin = {-34, 3}, lineColor = {255, 255, 255}, extent = {{-14, 19}, {44, -19}}, textString = "X"), Text(origin = {26, 3}, lineColor = {255, 255, 255}, extent = {{-14, 19}, {44, -19}}, textString = "T")}));
end SourceIdealMassFlow;
