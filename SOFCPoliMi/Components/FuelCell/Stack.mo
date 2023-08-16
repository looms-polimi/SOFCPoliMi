within SOFCPoliMi.Components.FuelCell;
model Stack

// Integers
  constant Integer N = 10 "Number of volumes of each channel";
  constant Integer Nseries = 1 "Number of modules connected in series to build a stack of SOFCs";
  constant Integer NparallelFluid = 1 "Number of modules in fluid dynamic parallel";
  constant Integer nX = 10 "Number of species in the fluid model";

// Replaceable models
  replaceable model Fluid = Media.MainClasses.SOS10ComponentsModelica;
  replaceable model ReactionRates =
      Components.FuelCell.ChemicalReactions.ChannelReactionRatesCO2;
  replaceable model PENOhmRes = Components.FuelCell.OhmicResistancePEN(preExpSE=preExp);

// Booleans for options
  parameter Boolean constantDiffusion = false "True if diffusion coefficient for concnetration losses should be considered constant";
  parameter Boolean leak = false "True if a linear loss proportional to the current should be included to introduce a fuel leakeage effect";
  parameter Boolean nonLinConc = true "True if concentration losses should be considered as non linear";

// Cell physical parameters
  constant Types.SpecificHeatCapacity cmPEN = 400 "Specific heat capacity of the PEN";
  constant Types.SpecificHeatCapacity cmPlate = 500 "Specific heat capacity of the interconnecting plate";
  parameter Types.MolarEnergy Eanode = 110e+03 "Anodic energy of activation for activation loss";
  parameter Types.MolarEnergy Ecathode = 110e+03 "Cathodic energy of activation for activation loss";
  parameter Types.SpecificConductivityArea kAnode = 1e+12 "Pre-exponential factor for anodic activation loss";
  parameter Types.SpecificConductivityArea kCathode = 1e+12 "Pre-exponential factor for cathodic activation loss";
  parameter Types.PerUnit porosity = 0.3 "Porosity coefficient for anode and cathode electrodes";
  constant Types.Density rhoPEN = 6600 "PEN density";
  constant Types.Density rhoPlate = 8000 "Interconnecting plate density";
  constant Types.SpecificConductivityLength preExp = 3.34e4 "Pre-exponential factor for the evaluation of membrane conductivity (original = 3.34e4)";

// Leakage parameters
  parameter Types.ElCurrent iPENmax[N] = zeros(N) "Max current for each volume for leakage losses";
  parameter Types.ElPotential vLeak0 = 0 "Leakage loss at zero current";

// Cell dimensions
  constant Types.Length H = 1e-3 "Channel height";
  constant Types.Length W = 0.05 "Channel width";
  constant Types.Length totLength = 0.05 "Channel total length";
  constant Types.Length tauAE = 400e-6 "Anode electrode thickness";
  constant Types.Length tauCE = 16e-6 "Cathode electrode thickness";
  constant Types.Length tauSE = 4e-6 "Solid electrolyte thickness";
  constant Types.Length tauI = 3e-3 "Interconnecting plate thickness";

// Constants
  constant Modelica.Units.SI.FaradayConstant F = Modelica.Constants.F "Faraday constant C/mol";

// Initialization
  parameter Types.Temperature T_start "General start temperature";
  parameter Types.Temperature T_start_Anode[N] = {T_start for i in 1:N};
  parameter Types.Temperature T_start_Cathode[N] = {T_start for i in 1:N};
  parameter Types.Temperature T_start_PEN[N] = {T_start for i in 1:N};
  parameter Types.Temperature T_start_Plate[N] = {T_start for i in 1:N};
  parameter Types.PerUnit X_start_Anode[nX] = {0.36323032, 0.63676965, 0, 0, 0, 0, 0, 0, 0, 0};
  parameter Types.PerUnit X_start_Cathode[nX] = {0.0014, 0, 0.8641, 0, 0, 0, 0, 0.1345, 0, 0};
  parameter Types.Pressure p_start_Anode = 27.5e5;
  parameter Types.Pressure p_start_Cathode = 27.5e5;
  parameter Types.Density rho_start_Anode = 0.17;
  parameter Types.Density rho_start_Cathode = 0.29;
  parameter Types.MassFlowRate w_start_Anode;
  parameter Types.MassFlowRate w_start_Cathode;

  parameter Types.Pressure p_start_homotopy_cathode_in = p_start_Cathode;
  parameter Types.Pressure p_start_homotopy_anode_in = p_start_Anode;
  parameter Types.Pressure p_start_homotopy_cathode_out = p_start_Cathode;
  parameter Types.Pressure p_start_homotopy_anode_out = p_start_Anode;
  parameter Types.Temperature T_start_homotopy_cathode_in = T_start;
  parameter Types.Temperature T_start_homotopy_anode_in = T_start;
  parameter Types.Temperature T_start_homotopy_cathode_out = T_start;
  parameter Types.Temperature T_start_homotopy_anode_out = T_start;
  parameter Types.MassFraction X_start_homotopy_cathode_in[nX] = X_start_Cathode;
  parameter Types.MassFraction X_start_homotopy_anode_in[nX] = X_start_Anode;
  parameter Types.MassFraction X_start_homotopy_cathode_out[nX] = X_start_Cathode;
  parameter Types.MassFraction X_start_homotopy_anode_out[nX] = X_start_Anode;

  SOFCPoliMi.Components.FuelCell.Module module[N](
    redeclare model Fluid = Fluid,
    redeclare model ReactionRates = ReactionRates,
    redeclare model PENOhmRes = PENOhmRes,
    each nonLinConc = nonLinConc,
    each leak = leak,
    each vLeak0 = vLeak0,
    iPENmax = iPENmax,
    each constantDiff = constantDiffusion,
    each porosity = porosity,
    each cmPEN = cmPEN,
    each cmPlate = cmPlate,
    each rhoPEN = rhoPEN,
    each rhoPlate = rhoPlate,
    each Eanode = Eanode,
    each Ecathode = Ecathode,
    each kAnode = kAnode,
    each kCathode = kCathode,
    T_start_Anode = T_start_Anode,
    T_start_Cathode = T_start_Cathode,
    T_start_PEN = T_start_PEN,
    T_start_Plate = T_start_Plate,
    each X_start_Anode = X_start_Anode,
    each X_start_Cathode = X_start_Cathode,
    each p_start_Anode = p_start_Anode,
    each p_start_Cathode = p_start_Cathode,
    each rho_start_Anode = rho_start_Anode,
    each rho_start_Cathode = rho_start_Cathode,
    each w_start_Anode = w_start_Anode,
    each w_start_Cathode = w_start_Cathode,
    each H = H,
    each W = W,
    each tauAE = tauAE,
    each tauCE = tauCE,
    each tauSE = tauSE,
    each tauI = tauI,
    initialEquation = cat(1, fill(true, N - 1), {false}),
    L = ones(N)*totLength/N,
    logVal = linspace(0.68, 3.75, N)) annotation (
    Placement(visible = true, transformation(origin = {2, 0}, extent = {{-44, -32}, {40, 52}}, rotation = 0)));

  SOFCPoliMi.Interfaces.FlangeA anodeIn(nXi = nX, nC = 0) annotation (
    Placement(visible = true, transformation(origin = {10, 20}, extent = {{-190, -80}, {-150, -40}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-120, -80}, {-80, -40}}, rotation = 0)));
  SOFCPoliMi.Interfaces.FlangeB anodeOut(nXi = nX, nC = 0) annotation (
    Placement(visible = true, transformation(origin = {-18, 18}, extent = {{158, -78}, {198, -38}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{80, -80}, {120, -40}}, rotation = 0)));
  SOFCPoliMi.Interfaces.FlangeA cathodeIn(nXi = nX, nC = 0) annotation (
    Placement(visible = true, transformation(origin = {12, -2}, extent = {{-192, 42}, {-152, 82}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-120, 40}, {-80, 80}}, rotation = 0)));
  SOFCPoliMi.Interfaces.FlangeB cathodeOut(nXi = nX, nC = 0) annotation (
    Placement(visible = true, transformation(origin = {-22, 0}, extent = {{162, 40}, {202, 80}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{80, 40}, {120, 80}}, rotation = 0)));
  SOFCPoliMi.Components.FuelCell.FlowMultiplier anodeInletMultiplier(nX = nX, multiplier = 1/NparallelFluid) annotation (
    Placement(visible = true, transformation(origin={34,20},   extent = {{-130, -70}, {-110, -50}}, rotation = 0)));
  SOFCPoliMi.Components.FuelCell.FlowMultiplier anodeOutletMultiplier(nX = nX, multiplier = NparallelFluid) annotation (
    Placement(visible = true, transformation(origin = {-44, 18}, extent = {{118, -68}, {138, -48}}, rotation = 0)));
  SOFCPoliMi.Components.FuelCell.FlowMultiplier cathodeInletMultiplier(nX = nX, multiplier = 1/NparallelFluid) annotation (
    Placement(visible = true, transformation(origin={36,-2},   extent = {{-132, 52}, {-112, 72}}, rotation = 0)));
  SOFCPoliMi.Components.FuelCell.FlowMultiplier cathodeOutletMultiplier(nX = nX, multiplier = NparallelFluid) annotation (
    Placement(visible = true, transformation(origin={-48,0},    extent = {{122, 50}, {142, 70}}, rotation = 0)));
  SOFCPoliMi.Interfaces.FuelCellInterfaces.ElPin cathodePin annotation (
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, 80}, {10, 100}}, rotation = 0), iconTransformation(origin = {0, 0}, extent = {{-10, 80}, {10, 100}}, rotation = 0)));
  Interfaces.FuelCellInterfaces.ElPin anodePin annotation (
    Placement(transformation(extent = {{-10, -100}, {10, -80}}), iconTransformation(extent = {{-10, -100}, {10, -80}})));
  SOFCPoliMi.Components.FuelCell.VoltageMultiplier voltageMultiplier(Ns = Nseries, Np = NparallelFluid/Nseries) annotation (
    Placement(visible = true, transformation(origin = {6, 0}, extent = {{-16, -68}, {4, -48}}, rotation = 0)));

// Variables for inspection
  Types.ElPotential vStack = anodePin.v - cathodePin.v;
  Types.ElPotential vChannel = module[1].anodeElPin.v - module[1].cathodeElPin.v;
  Types.Power pElStack = vStack*anodePin.i;
  Types.Power pElChannel = -vChannel*voltageMultiplier.single.i;
  Types.Power enBalance = module[1].anodeChannel.entFlowIn + module[1].cathodeChannel.entFlowIn - (module[N].anodeChannel.entFlowOut + module[N].cathodeChannel.entFlowOut) - pElChannel;
  Types.CurrentDensity currentDensity = actualCurrent/(totLength*W);

  Types.ElCurrent actualCurrent = abs(voltageMultiplier.single.i) "Single channel current";
  Types.MoleFraction XinAnode[module[1].anodeChannel.nX] = module[1].anodeChannel.Xin;
  constant Types.MolarMass MM[10] = DiffusionLosses.Utilities.ConstantsFluidAndSolid.MM;
  Types.ElCurrent wholeConsCurrent = 2*F*module[1].anodeChannel.wIn*(XinAnode[2]/MM[2]+XinAnode[4]/MM[4]+4*XinAnode[5]/MM[5]+7*XinAnode[6]/MM[6]+10*XinAnode[7]/MM[7]);
  Types.PerUnit Uf = actualCurrent/wholeConsCurrent;
  Types.MassFlowRate totalWO2 = sum(module[i].anodeChannel.wO2 for i in 1:N)*NparallelFluid;


  SOFCPoliMi.Components.Initializers.HomotopyInitializer
    homotopyInitializerCathodeIn(
    redeclare model Medium = Media.MainClasses.SOS10ComponentsModelica,
    p_start=p_start_homotopy_cathode_in,
    X_start=X_start_homotopy_cathode_in,
    T_start=T_start_homotopy_cathode_in) annotation (Placement(visible=true,
        transformation(
        origin={-120,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  SOFCPoliMi.Components.Initializers.HomotopyInitializer
    homotopyInitializerAnodeIn(
    redeclare model Medium = Media.MainClasses.SOS10ComponentsModelica,
    p_start=p_start_homotopy_anode_in,
    X_start=X_start_homotopy_anode_in,
    T_start=T_start_homotopy_anode_in) annotation (Placement(visible=true,
        transformation(
        origin={-120,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  SOFCPoliMi.Components.Initializers.HomotopyInitializer
    homotopyInitializerAnodeOut(
    redeclare model Medium = Media.MainClasses.SOS10ComponentsModelica,
    p_start=p_start_homotopy_anode_out,
    X_start=X_start_homotopy_anode_out,
    T_start=T_start_homotopy_anode_out) annotation (Placement(visible=true,
        transformation(
        origin={120,-40},
        extent={{-10,-10},{10,10}},
        rotation=0)));

  SOFCPoliMi.Components.Initializers.HomotopyInitializer
    homotopyInitializerCathodeOut(
    redeclare model Medium = Media.MainClasses.SOS10ComponentsModelica,
    p_start=p_start_homotopy_cathode_out,
    X_start=X_start_homotopy_cathode_out,
    T_start=T_start_homotopy_cathode_out) annotation (Placement(visible=true,
        transformation(
        origin={120,60},
        extent={{-10,-10},{10,10}},
        rotation=0)));

equation

  for ind in 1:N - 1 loop
    connect(module[ind].anodeElPin, module[ind + 1].anodeElPin);
    connect(module[ind].cathodeElPin, module[ind + 1].cathodeElPin);
  end for;

  connect(voltageMultiplier.multiple, anodePin) annotation (
    Line(points = {{10, -58}, {18, -58}, {18, -74}, {0, -74}, {0, -90}}, color = {0, 0, 255}));
  connect(module[2:end].cathodeIn, module[1:end - 1].cathodeOut) annotation (
    Line(points = {{-42, 33.52}, {-42, 32}, {-62, 32}, {-62, 62}, {60, 62}, {60, 33.52}, {42, 33.52}}, color = {255, 0, 0}));
  connect(module[2:end].anodeIn, module[1:end - 1].anodeOut) annotation (
    Line(points = {{-42, -13.52}, {-42, -14}, {-62, -14}, {-62, -38}, {60, -38}, {60, -13.52}, {42, -13.52}}, color = {255, 0, 0}));
  connect(module[1].cathodeElPin, cathodePin) annotation (
    Line(points={{0,22.6},{0,90}},    color = {0, 0, 255}));
  connect(module[1].anodeElPin, voltageMultiplier.single) annotation (
    Line(points={{0,-2.6},{0,-42},{-22,-42},{-22,-58},{-10,-58}},          color = {0, 0, 255}));
  connect(module[1].cathodeIn, cathodeInletMultiplier.outlet) annotation (
    Line(points={{-42,33.52},{-42, 32}, {-70, 32}, {-70, 60},{-76,60}},         color = {159, 159, 223}));
  connect(module[end].cathodeOut, cathodeOutletMultiplier.inlet) annotation (
    Line(points={{42,33.52},{56,33.52},{56,34},{68,34},{68,60},{74,60}},
                                                             color = {159, 159, 223}));
  connect(module[end].anodeOut, anodeOutletMultiplier.inlet) annotation (
    Line(points={{42,-13.52},{56,-13.52},{56,-14},{68,-14},{68,-40},{74,-40}},
                                                                 color = {159, 159, 223}));
  connect(anodeInletMultiplier.outlet, module[1].anodeIn) annotation (
    Line(points={{-76,-40},{-70, -40},{-70,-13.52},{-42,
          -13.52}},                                                  color = {159, 159, 223}));
  connect(homotopyInitializerCathodeIn.outlet, cathodeInletMultiplier.inlet) annotation (
    Line(points = {{-110, 60}, {-96, 60}}, color = {159, 159, 223}));
  connect(homotopyInitializerCathodeIn.inlet, cathodeIn) annotation (
    Line(points = {{-130, 60}, {-160, 60}}, color = {159, 159, 223}));
  connect(homotopyInitializerAnodeIn.outlet, anodeInletMultiplier.inlet) annotation (
    Line(points = {{-110, -40}, {-96, -40}}, color = {159, 159, 223}));
  connect(homotopyInitializerAnodeIn.inlet, anodeIn) annotation (
    Line(points = {{-130, -40}, {-160, -40}}, color = {159, 159, 223}));
  connect(homotopyInitializerAnodeOut.outlet, anodeOut) annotation (
    Line(points = {{130, -40}, {160, -40}}, color = {159, 159, 223}));
  connect(homotopyInitializerAnodeOut.inlet, anodeOutletMultiplier.outlet) annotation (
    Line(points = {{110, -40}, {94, -40}}, color = {159, 159, 223}));
  connect(cathodeOutletMultiplier.outlet, homotopyInitializerCathodeOut.inlet) annotation (
    Line(points = {{94, 60}, {110, 60}}, color = {159, 159, 223}));
  connect(homotopyInitializerCathodeOut.outlet, cathodeOut) annotation (
    Line(points = {{130, 60}, {160, 60}}, color = {159, 159, 223}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics={  Rectangle(lineColor = {28, 108, 200}, fillColor = {110, 110, 110}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, 34}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {199, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 34}, {100, 28}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {110, 110, 110}, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, 16}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {110, 110, 110}, fillPattern = FillPattern.Solid, extent = {{-100, -34}, {100, -100}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {191, 191, 191}, fillPattern = FillPattern.Solid, extent = {{-100, 28}, {100, 26}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {0, 0, 158}, fillPattern = FillPattern.Solid, extent = {{-100, 26}, {100, 20}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {199, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, 16}, {100, 10}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {191, 191, 191}, fillPattern = FillPattern.Solid, extent = {{-100, 10}, {100, 8}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {0, 0, 158}, fillPattern = FillPattern.Solid, extent = {{-100, 8}, {100, 2}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {110, 110, 110}, fillPattern = FillPattern.Solid, extent = {{-100, 2}, {100, -2}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {199, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, -2}, {100, -8}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {191, 191, 191}, fillPattern = FillPattern.Solid, extent = {{-100, -8}, {100, -10}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {0, 0, 152}, fillPattern = FillPattern.Solid, extent = {{-100, -10}, {100, -16}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {110, 110, 110}, fillPattern = FillPattern.Solid, extent = {{-100, -16}, {100, -20}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {199, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-100, -20}, {100, -26}}), Rectangle(lineColor = {28, 108, 200}, fillColor = {191, 191, 191}, fillPattern = FillPattern.Solid, extent = {{-100, -26}, {100, -28}}), Rectangle(lineColor = {135, 135, 135}, fillColor = {0, 0, 152}, fillPattern = FillPattern.Solid, extent = {{-100, -28}, {100, -34}})}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-180, -100}, {180, 100}})));
end Stack;
