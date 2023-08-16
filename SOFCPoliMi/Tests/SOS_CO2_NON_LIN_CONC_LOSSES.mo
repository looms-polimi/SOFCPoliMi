within SOFCPoliMi.Tests;
model SOS_CO2_NON_LIN_CONC_LOSSES
  extends Modelica.Icons.Example;
  replaceable model PENOhmRes =
      Components.FuelCell.OhmicResistancePEN(preExpSE=preExp);

  parameter Real preExp = 3.34e4;//7.9e3;

  constant Integer N = 10 "Number of modules in parallel";
  constant Modelica.Units.SI.FaradayConstant F = Modelica.Constants.F "Faraday constant C/mol";

  parameter Boolean constantDiff = false "";
  parameter Boolean nonLinConc = true;

  parameter Types.ElCurrent iTot = 30*1.5; //30; //25
  parameter Real inletTemp = 930;
  //parameter Real a[4] = {140e3, 137e3, 6.54e11, 2.35e11};
  parameter Types.MolarEnergy Eanode = 110e+03 "";
  parameter Types.MolarEnergy Ecathode = 110e+03 "";
  parameter Types.SpecificConductivityArea kAnode = 1e+12 "";
  parameter Types.SpecificConductivityArea kCathode = 1e+12 "";
  constant Types.SpecificHeatCapacity cmPEN = 400 "Specific heat capacity of the PEN";
  constant Types.SpecificHeatCapacity cmPlate = 500 "Specific heat capacity of the interconnecting plate";
  constant Types.Density rhoPEN = 6600 "PEN density";
  constant Types.Density rhoPlate = 8000 "Interconnecting plate density";
  //input Real iNom;
  // Types.ElPotential vAct[N] = {a[1] + a[2]*arctan(module[i].pen.i/iNom) for i in 1:N};
  output Types.ElPotential voltage = module[1].pen.vPEN;

  parameter Types.Temperature generalT = inletTemp;

  // Mass flow evaluation from paper
//   parameter Real anodicFlowRateNLmin = 0.6/2.5;
//   parameter Real cathodicFlowRateNLmin = 1.2;
//   parameter Real anodicFlowrateNLsec = anodicFlowRateNLmin/60;
//   parameter Real cathodicFlowrateNLsec = cathodicFlowRateNLmin/60;
//   parameter Types.MolarMass MMfuel = 0.06*18e-3 + 0.94*2e-3 "Fuel molar mass";
//   parameter Types.MolarMass MMcathode = 0.79*28e-3 + 0.21*32e-3 "Fuel molar mass";
//   parameter Real NLfuel = 1e-3*1e5*MMfuel/(Modelica.Constants.R*273.15) "1 NL of fuel in kg";
//   parameter Real NLcathode = 1e-3*1e5*MMcathode/(Modelica.Constants.R*273.15) "1 NL of air in kg";
//   parameter Real anodicFlowRate = anodicFlowrateNLsec * NLfuel "mass flow rate";
//   parameter Real cathodicFlowRate = anodicFlowrateNLsec * NLcathode;

  parameter Real anodicFlowRate = 1e-5*1.5 "mass flow rate";
  parameter Real cathodicFlowRate = anodicFlowRate * 2.33;

  parameter Types.Temperature T_start_Anode[N] = {generalT for i in 1:N};
  parameter Types.Temperature T_start_Cathode[N] = {773.15 for i in 1:N};
  parameter Types.Temperature T_start_PEN[N] = {generalT for i in 1:N};
  parameter Types.Temperature T_start_Plate[N] = {generalT for i in 1:N};
  parameter Types.PerUnit X_start_Anode[N,10] = {{0.36323032,0.63676965,0,0,0,0,0,0,0,0} for i in 1:N}; //{0.493, 0.171, 0.044, 0.029, 0.263, 0, 0, 0}     {0.36323, 0.63676, 0, 0, 0, 0, 0, 0.00001}
  parameter Types.PerUnit X_start_Cathode[N,10] = {{0.0014, 0, 0.8641, 0, 0,0,0, 0.1345, 0, 0} for i in 1:N};
  parameter Types.Pressure p_start_Anode = 27.5e5;
  parameter Types.Pressure p_start_Cathode = 27.5e5;
  parameter Types.Density rho_start_Anode = 0.17;
  parameter Types.Density rho_start_Cathode = 0.29;
  parameter Types.MassFlowRate w_start_Anode = anodicFlowRate;
  parameter Types.MassFlowRate w_start_Cathode = cathodicFlowRate;

  // Cell dimensions
  constant Types.Length H = 1e-3 "Channel height";
  constant Types.Length W = 0.04 "Channel width";
  constant Types.Length totLength = 0.04   "Channel to length";
  constant Types.Length tauAE = 400e-6 "Anode electrode thickness";
  constant Types.Length tauCE = 16e-6 "Cathode electrode thickness";
  constant Types.Length tauSE = 4e-6 "Solid electrolyte thickness";
  constant Types.Length tauI = 3e-3 "Interconnecting plate thickness";

  parameter Real porosity = 0.25;//0.078;//7.795362730728746e-02 "Porosity coefficient for anode and cathode electrodes";

  parameter Types.ElCurrent iPENmax[N] = {1.3792214,1.2731493,1.1541725,1.0373313,0.9256242,0.8208353,0.72434956,0.6369583,0.55880994,0.4895481};
  parameter Types.ElPotential vLeak0 = 0.035;
  parameter Boolean leak = false;

  Components.FuelCell.Module module[N](
    redeclare model ReactionRates =
        Components.FuelCell.ChemicalReactions.ChannelReactionRatesCO2,
    redeclare model PENOhmRes = PENOhmRes,
    each nonLinConc=nonLinConc,
    each leak=leak,
    each vLeak0=vLeak0,
    iPENmax=iPENmax,
    each constantDiff=constantDiff,
    each porosity=porosity,
    each cmPEN=cmPEN,
    each cmPlate=cmPlate,
    each rhoPEN=rhoPEN,
    each rhoPlate=rhoPlate,
    each Eanode=Eanode,
    each Ecathode=Ecathode,
    each kAnode=kAnode,
    each kCathode=kCathode,
    T_start_Anode = T_start_Anode,
    T_start_Cathode = T_start_Cathode,
    T_start_PEN = T_start_PEN,
    T_start_Plate = T_start_Plate,
    X_start_Anode = X_start_Anode,
    X_start_Cathode = X_start_Cathode,
    each p_start_Anode = p_start_Anode,
    each p_start_Cathode = p_start_Cathode,
    each rho_start_Anode = rho_start_Anode,
    each rho_start_Cathode = rho_start_Cathode,
    each w_start_Anode = w_start_Anode,
    each w_start_Cathode = w_start_Cathode,
    each H=H,
    each W=W,
    each tauAE=tauAE,
    each tauCE=tauCE,
    each tauSE=tauSE,
    each tauI=tauI,
    initialEquation = cat(1, fill(true, N - 1), {false}),
    L = ones(N)*totLength/N,
    logVal = linspace(0.68, 3.75, N)); //ones(N)*totLength/N

  Components.Sources.SourceIdealMassFlow anodeSource(T_start = generalT, X_start = X_start_Anode[1], nX = 10, p_start = 101325, rho_start = 0.2);
  Components.Sources.SourceIdealMassFlow cathodeSource(T_start = generalT, X_start = X_start_Cathode[1], nX = 10, p_start = 101325, rho_start = 0.2);
  Components.Sources.IdealSinkPressure anodeSink(p = 27.5e5);
  Components.Sources.IdealSinkPressure cathodeSink(p = 27.5e5);
  Components.Sources.ConcentrationRamp anodeCompSignal(Xend = {0.3785, 0.0128, 0.5450, 0, 0.0637, 0,0,0, 0, 0}, Xstart = {0.36323032,0.63676965,1e-8,1e-8,1e-8,1e-8,1e-8,1e-8,1e-8,1e-8}, nX = 10, tend = 1e7, tstart = 1);
  //Modelica.Blocks.Sources.Constant anodeCompSignal[8](k = X_start_Anode[1]);
//   Modelica.Blocks.Sources.Constant anodeFlowSignal(k = anodicFlowRate);
  Modelica.Blocks.Sources.TimeTable anodeFlowSignal(table = [0, anodicFlowRate; 3e7, anodicFlowRate; 4e7, anodicFlowRate; 4e7+1, anodicFlowRate]);
  Modelica.Blocks.Sources.RealExpression anodeTempSignal(y = inletTemp);
  Modelica.Blocks.Sources.Constant cathodeFlowSignal(k = cathodicFlowRate);
  Modelica.Blocks.Sources.Constant cathodeCompSignal[10](k = X_start_Cathode[1]);
  Modelica.Blocks.Sources.RealExpression cathodeTempSignal(y = 510+273.15);
  Modelica.Electrical.Analog.Basic.Ground ground;
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent;
  Modelica.Blocks.Sources.TimeTable timeTable(table = [0, 0.001; 1e7, 0.001; 2e7, 0.001; 3e7, iTot; 4e7, iTot]);

  Types.Power totPower = sum(module[i].pen.elP for i in 1:N);
  Types.Power enBalance = module[1].anodeChannel.entFlowIn + module[1].cathodeChannel.entFlowIn - (module[N].anodeChannel.entFlowOut + module[N].cathodeChannel.entFlowOut) - totPower;
  Types.MassFlowRate massBalance = module[1].anodeChannel.wIn + module[1].cathodeChannel.wIn - module[N].anodeChannel.wOut - module[N].cathodeChannel.wOut;

  Real sumI = sum(module[i].pen.i for i in 1:N);
  Real currentBal = sumI - timeTable.y;

  Real Uf = signalCurrent.i/currentWholeCons;
  Real currentWholeCons = (2*F*anodeFlowSignal.y*(anodeCompSignal.y[2]/2e-3 + anodeCompSignal.y[4]/28e-3 + 4*anodeCompSignal.y[5]/16e-3));

  Real ratio = anodeFlowSignal.y/anodicFlowRate;

  Real currentDensity = signalCurrent.i/(W*totLength);

//   parameter Modelica.Units.SI.Time maxTime = 10 "Timeout value in seconds";
//   SimulationClock simulationClock = SimulationClock() "External object instance";
//   Modelica.Units.SI.Time t_elaps;

equation

//   t_elaps = elapsedTime(simulationClock, time);
//   if noEvent(elapsedTime(simulationClock, time) >= maxTime) then
//     terminate("Simulation timeout after "+String(maxTime)+" seconds.");
//   end if;

//   module.Eanode = a[1];
//   module.Ecathode=a[2];
//   module.kAnode=a[3];
//   module.kCathode=a[4];

// Connections between modules (fluid + electr)
  for ind in 1:N - 1 loop
    connect(module[ind].anodeOut, module[ind + 1].anodeIn);
    connect(module[ind].cathodeOut, module[ind + 1].cathodeIn);
    connect(module[ind].anodeElPin, module[ind + 1].anodeElPin);
    connect(module[ind].cathodeElPin, module[ind + 1].cathodeElPin);
  end for;
// Boundary connections
  connect(module[1].anodeIn, anodeSource.flange);
  connect(module[1].cathodeIn, cathodeSource.flange);
  connect(module[N].anodeOut, anodeSink.flange);
  connect(module[N].cathodeOut, cathodeSink.flange);
// Electrical connections
  connect(module[1].cathodeElPin, ground.p);
  connect(module[N].cathodeElPin, signalCurrent.p);
  connect(module[N].anodeElPin, signalCurrent.n);
// Signal connections
  connect(anodeSource.w, anodeFlowSignal.y);
//   anodeSource.w = anodicFlowRate;
  connect(anodeSource.Tset, anodeTempSignal.y);
  connect(anodeSource.X, anodeCompSignal.y);
  connect(cathodeSource.w, cathodeFlowSignal.y);
  connect(cathodeSource.Tset, cathodeTempSignal.y);
  connect(cathodeSource.X, cathodeCompSignal.y);
  //iTot = signalCurrent.i;
//   homotopy(iTot,iTot/30) = signalCurrent.i;
  timeTable.y = signalCurrent.i;
  annotation (
    experiment(
      StopTime=40000000,
      Interval=100000,
      __Dymola_Algorithm="Dassl"), __Dymola_experimentSetupOutput);
end SOS_CO2_NON_LIN_CONC_LOSSES;
