within SOFCPoliMi.Components.FuelCell;
model InterconnectingPlate

  // Structural properties
  constant Types.Area A = W*L "Interconnecting plate contact surface with channel";
  constant Types.SpecificHeatCapacity cm = 500 "Specific heat capacity of the interconnecting plate";
  constant Types.HeatCapacity Cm = M*cm "Heat capacity of the interconnecting plate";
  constant Types.Length L = 5.1e-4 "Interconnecting plate length";
  constant Types.Mass M = rho*V "Interconnecting plate mass";
  constant Types.Density rho = 8000 "Interconnecting plate density";
  constant Types.Length tauI = 710e-6 "Interconnecting plate thickness";
  constant Types.Volume V = A*tauI "Interconnecting plate volume";
  constant Types.Length W = 5.56e-3 "Interconnecting plate width";

  // Initialization
  parameter Types.Temperature T_start = 920 "";

  Types.HeatFlowRate Qconv "";
  Types.HeatFlowRate Qrad "";
  Types.Temperature T(start = T_start) "";

  // Connectors
  Interfaces.HeatPort convectiveHeatChannel annotation (
    Placement(visible = true, transformation(origin={-30,0},  extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin={-30,0},  extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.HeatPort radiativeHeatChannel annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation

  // Boundary Conditions
  convectiveHeatChannel.T = T;
  convectiveHeatChannel.Q_flow = Qconv;
  radiativeHeatChannel.T = T;
  radiativeHeatChannel.Q_flow = Qrad;

  // Energy Balance
  Cm*der(T) = Qconv + Qrad;

initial equation
  der(T) = 0;

annotation (
    Icon(graphics={  Rectangle(fillColor = {143, 143, 143}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, -20}})}));
end InterconnectingPlate;
