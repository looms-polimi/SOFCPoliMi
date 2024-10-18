within SOFCPoliMi.Components.Sources;

model IdealPressureSource

  parameter Integer nX = 10 "Number of species in the mixture";
  
  parameter Types.Pressure p_start "";
  parameter Types.Temperature T_start "";
  parameter Types.MassFraction X_start[nX] "";
  parameter Types.Density rho_start "";
  
  replaceable model Medium = Media.MainClasses.SOS_CO2.SOS10ComponentsModelica;
  Medium fluid(T_start = T_start, p_start = p_start, X_start = X_start, rho_start = rho_start) "Fluid moved by the source";

  Interfaces.FlangeB flange(nXi = nX, nC = 0, w(max = 0)) annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}}), iconTransformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput p annotation(
    Placement(transformation(origin = {-80, 70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-60, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput X[nX] annotation(
    Placement(transformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {0, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
  Modelica.Blocks.Interfaces.RealInput T annotation(
    Placement(transformation(origin = {-80, -70}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {60, 100}, extent = {{-20, -20}, {20, 20}}, rotation = -90)));
equation

  fluid.T = T;
  fluid.p = p;
  fluid.Xi = X;
  flange.Xi = fluid.X;
  flange.h = fluid.h;
  flange.p = fluid.p;

annotation(
    Icon(graphics = {Ellipse(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-61, 60}, extent = {{-13, 16}, {13, -16}}, textString = "p"), Text(origin = {-1, 60}, extent = {{-13, 16}, {13, -16}}, textString = "X"), Text(origin = {61, 60}, extent = {{-13, 16}, {13, -16}}, textString = "T")}));
end IdealPressureSource;
