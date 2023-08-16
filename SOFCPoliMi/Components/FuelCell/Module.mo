within SOFCPoliMi.Components.FuelCell;
model Module

  replaceable model ReactionRates =
      Components.FuelCell.ChemicalReactions.ChannelReactionRatesAir;

  replaceable model PENOhmRes =
      Components.FuelCell.OhmicResistancePEN;

  replaceable model Fluid =
      Media.MainClasses.SOS10ComponentsModelica;

  parameter Boolean initialEquation = true "";
  parameter Boolean constantDiff = false "";
  parameter Boolean nonLinConc = true;
  parameter Boolean leak = false;

  parameter Types.ElCurrent iPENmax;
  parameter Types.ElPotential vLeak0;

  parameter Types.MolarEnergy Eanode = 140e3 "";
  parameter Types.MolarEnergy Ecathode = 137e3 "";
  parameter Types.SpecificConductivityArea kAnode = 6.54e11 "";
  parameter Types.SpecificConductivityArea kCathode = 2.35e11 "";
  constant Types.SpecificHeatCapacity cmPEN = 400 "Specific heat capacity of the PEN";
  constant Types.SpecificHeatCapacity cmPlate = 500 "Specific heat capacity of the interconnecting plate";
  constant Types.Density rhoPEN = 6600 "PEN density";
  constant Types.Density rhoPlate = 8000 "Interconnecting plate density";

  // Constants
  constant Types.StephanBoltzmannConst sigma = Modelica.Constants.sigma "";
  constant Integer nX = 10 "Number of species in the mixture 1: H2O, 2: H2, 3: CO2, 4: CO, 5: CH4, 6: O2, 7: N2, 8: Ar";

  // Emissivity parameter
  constant Types.Emissivity epsPen = 0.8 "";
  constant Types.Emissivity epsPlate = 0.1 "";

  // Structural parameters
  constant Types.Length H = 8.67e-4 "Channel height";
  constant Types.Length L = 0.00005 "Channel length";
  constant Types.Length W = 5.56e-3 "Channel width";
  constant Types.Length tauAE = 50e-6 "Anode electrode thickness";
  constant Types.Length tauCE = 50e-6 "Cathode electrode thickness";
  constant Types.Length tauSE = 150e-6 "Solid electrolyte thickness";
  constant Types.Length tauI = 710e-6 "Interconnecting plate thickness";

  // Nominal Values
  parameter Types.CoefficientOfHeatTransfer alphaNomAnode = 510 "Convective heat transfer coefficient anode";
  parameter Types.CoefficientOfHeatTransfer alphaNomCathode = 290 "Convective heat transfer coefficient cathode";
  parameter Types.Pressure deltapNom = 1 "Nominal pressure drop";
  parameter Types.Temperature TnomChannel = 1200 "";
  parameter Types.Temperature TnomPEN = 1200 "";
  parameter Types.MassFlowRate wNom = 1e-6 "Nominal mass flow rate";

  // Initialization
  parameter Types.Pressure p_start_Anode = 101325 "Start value for pressure";
  parameter Types.Density rho_start_Anode = 0.2 "Start value for density";
  parameter Types.Temperature T_start_Anode = 900+273.15 "Start value for temperature";
  parameter Types.MassFraction X_start_Anode[nX] = {0.35460,0.01203,0.51063,0.06303,0.05971,0,0,0,0,0} "Start value for mass fractions";
  parameter Types.MassFlowRate w_start_Anode = 0.000117298e-3;

  parameter Types.Pressure p_start_Cathode = 101325 "Start value for pressure";
  parameter Types.Density rho_start_Cathode = 0.2 "Start value for density";
  parameter Types.Temperature T_start_Cathode = 900+273.15 "Start value for temperature";
  parameter Types.MassFraction X_start_Cathode[nX] = {0.001448,0,0.86408,0,0,0,0,0.134471,0,0} "Start value for mass fractions";
  parameter Types.MassFlowRate w_start_Cathode = 0.0031659e-3;

  constant Real logVal = 1;

  parameter Types.Temperature T_start_PEN = 920 "";

  parameter Types.Temperature T_start_Plate = 920 "";

  parameter Types.PerUnit porosity = 0.35 "Porosity coefficient for anode and cathode electrodes";

  // Models
  Components.FuelCell.AnodeChannel anodeChannel(
    redeclare model ReactionRates = ReactionRates,
    redeclare model Fluid = Fluid,
    W=W, L=L, H=H,
    isAnode = true,
    p_start=p_start_Anode,
    T_start=T_start_Anode,
    X_start=X_start_Anode,
    rho_start=rho_start_Anode,
    w_start=w_start_Anode,
    initialEquation=initialEquation,
    alphaNom=alphaNomAnode,
    deltapNom=deltapNom,
    Tnom=TnomChannel,
    wNom=wNom) annotation (
    Placement(visible = true, transformation(origin = {8.88178e-16, -56}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));

  Components.FuelCell.PEN pen(
  redeclare model Resistance = PENOhmRes,
  leak=leak,
  nonLinConc=nonLinConc,
  vLeak0=vLeak0,
  iPENmax=iPENmax,
  constantDiff = constantDiff,
  rho = rhoPEN,
  cm = cmPEN,
  porosity=porosity,
  Eanode=Eanode,
  Ecathode=Ecathode,
  kAnode=kAnode,
  kCathode=kCathode,
  W=W, L=L,
  tauAE=tauAE,
  tauSE=tauSE,
  tauCE=tauCE,
  T_start=T_start_PEN,
  logVal=logVal,
  Tnom=TnomPEN,
  p_start=p_start_Anode,
  X_start_anode=X_start_Anode,
  X_start_cathode=X_start_Cathode) annotation (
    Placement(visible = true, transformation(origin = {7, 1}, extent = {{-31, -31}, {31, 31}}, rotation = 0)));


  Components.FuelCell.CathodeChannel cathodeChannel(
    redeclare model Fluid = Fluid,
    W=W, L=L, H=H,
    isAnode = false,
    p_start=p_start_Cathode,
    T_start=T_start_Cathode,
    X_start=X_start_Cathode,
    rho_start = rho_start_Cathode,
    w_start=w_start_Cathode,
    initialEquation=initialEquation,
    alphaNom=alphaNomCathode,
    deltapNom=deltapNom,
    wNom=wNom) annotation (
    Placement(visible = true, transformation(origin = {1.11022e-15, 56}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));

  Components.FuelCell.InterconnectingPlate anodePlate(W=W, L=L, tauI=tauI, T_start=T_start_Plate, cm=cmPlate, rho=rhoPlate) annotation (
    Placement(visible = true, transformation(origin = {1.9984e-15, -94}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Components.FuelCell.InterconnectingPlate cathodePlate(W=W, L=L, tauI=tauI, T_start=T_start_Plate, cm=cmPlate, rho=rhoPlate) annotation (
    Placement(visible = true, transformation(origin = {1.77636e-15, 94}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

  Interfaces.FlangeA anodeIn( nXi=nX, nC=0) annotation (
    Placement(visible = true, transformation(origin = {-100, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.FlangeA cathodeIn(nXi=nX, nC=0) annotation (
    Placement(visible = true, transformation(origin = {-100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.FlangeB anodeOut( nXi=nX, nC=0) annotation (
    Placement(visible = true, transformation(origin = {100, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.FlangeB cathodeOut(nXi=nX, nC=0) annotation (
    Placement(visible = true, transformation(origin = {100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 56}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Modelica.Electrical.Analog.Interfaces.Pin anodeElPin annotation (
    Placement(visible = true, transformation(origin = {-56, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Interfaces.Pin cathodeElPin annotation (
    Placement(visible = true, transformation(origin = {-56, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

  Types.Power enBalance = anodeChannel.entFlowIn + cathodeChannel.entFlowIn - (anodeChannel.entFlowOut + cathodeChannel.entFlowOut) - pen.elP;

equation

  connect(anodeIn, anodeChannel.inlet) annotation (
    Line(points={{-100,-56},{-21.6,-56}},    color = {159, 159, 223}));
  connect(anodeChannel.outlet, anodeOut) annotation (
    Line(points={{21.6,-56},{100,-56}},    color = {159, 159, 223}));
  connect(cathodeIn, cathodeChannel.inlet) annotation (
    Line(points={{-100,56},{-21.6,56}},    color = {159, 159, 223}));
  connect(cathodeChannel.outlet, cathodeOut) annotation (
    Line(points={{21.6,56},{100, 56}},    color = {159, 159, 223}));
  connect(pen.anodeHeatPort, anodeChannel.wallPEN) annotation (
    Line(points={{7,-16.98},{7,-36},{7,-56},{7.2,-56}},
                                        color = {255, 0, 0}));
  connect(pen.cathodeHeatPort, cathodeChannel.wallPEN) annotation (
    Line(points={{7,19.6},{7,38},{7,56},{7.2,56}},
                                      color = {255, 0, 0}));
  connect(pen.anodePin, anodeElPin) annotation (
    Line(points={{7,-5.2},{-56,-5.2},{-56,-16}},    color = {0, 0, 255}));
  connect(pen.cathodePin, cathodeElPin) annotation (
    Line(points={{7,7.2},{-56,7.2},{-56,16}},    color = {0, 0, 255}));
  connect(anodeChannel.absolutePressure, pen.absolutePressureAnode) annotation (
    Line(points={{-16.2,-45.2},{-16.2,-32},{-20.9,-32},{-20.9,-14.5}},
                                                                    color = {0, 0, 127}));
  connect(anodeChannel.partialPressures, pen.partialPressuresAnode) annotation (
    Line(points={{16.2,-45.2},{16.2,-32},{-8.5,-32},{-8.5,-14.5}},
                                                                color = {0, 0, 127}, thickness = 0.5));
  connect(cathodeChannel.absolutePressure, pen.absolutePressureCathode) annotation (
    Line(points={{-16.2,66.8},{-16.2,74},{-34,74},{-34,30},{-20.9,30},{-20.9,16.5}},  color = {0, 0, 127}));
  connect(cathodeChannel.partialPressures, pen.partialPressuresCathode) annotation (
    Line(points={{16.2,66.8},{16.2,72},{36,72},{36,28},{-8.5,28},{-8.5,16.5}},  color = {0, 0, 127}, thickness = 0.5));
  connect(pen.rHOR, anodeChannel.rHOR) annotation (
    Line(points={{34.9,1},{54,1},{54,-72},{0,-72},{0,-66.08}},       color = {0, 255, 0}));
  connect(pen.rHOR, cathodeChannel.rHOR) annotation (
    Line(points={{34.9,1},{54,1},{54,38},{0,38},{0,45.92}},       color = {0, 255, 0}));

  connect(anodeChannel.wallPlate, anodePlate.convectiveHeatChannel) annotation (
     Line(points={{-7.2,-56},{-8,-56},{-8,-82},{-6,-82},{-6,-94}}, color={255,0,
          0}));
  connect(cathodePlate.convectiveHeatChannel, cathodeChannel.wallPlate)
    annotation (Line(points={{-6,94},{-6,78},{-7.2,78},{-7.2,56}}, color={255,0,
          0}));
  connect(pen.radCathode, cathodePlate.radiativeHeatChannel) annotation (Line(
        points={{22.5,19.6},{22.5,34},{44,34},{44,80},{6,80},{6,94}}, color={
          255,0,0}));
  connect(pen.radAnode, anodePlate.radiativeHeatChannel) annotation (Line(
        points={{22.5,-16.98},{22.5,-36},{38,-36},{38,-84},{6,-84},{6,-94}},
        color={255,0,0}));
annotation (
    Icon(graphics={  Rectangle(fillColor = {140, 140, 140}, fillPattern = FillPattern.Solid, extent = {{-100, 30}, {100, -30}}), Rectangle(origin = {0, 55}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 25}, {100, -25}}), Rectangle(origin = {0, -55}, fillColor = {170, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, -25}, {100, 25}}), Rectangle(origin = {0, 90}, fillColor = {140, 140, 140}, fillPattern = FillPattern.Solid, extent = {{-100, 10}, {100, -10}}), Rectangle(origin = {0, -90}, fillColor = {140, 140, 140}, fillPattern = FillPattern.Solid, extent = {{-100, 10}, {100, -10}}), Text(origin = {-1, 58}, extent = {{-15, 12}, {15, -12}}, textString = "C"), Text(origin = {-1, -56}, extent = {{-15, 12}, {15, -12}}, textString = "A")}),
    Diagram(coordinateSystem(extent = {{-120, 120}, {120, -120}})));
end Module;
