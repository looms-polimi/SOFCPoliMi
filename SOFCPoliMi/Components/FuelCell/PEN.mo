within SOFCPoliMi.Components.FuelCell;
model PEN
  import SOFCPoliMi.Functions.logBound;
  import SOFCPoliMi.Functions.sqrtBound;
  // Implicit or explicit activation losses
  parameter Boolean explicit = true "";
  parameter Boolean constantDiff = false "";
  parameter Boolean nonLinConc = true;
  parameter Boolean leak = false;
  //Replaceable models
  replaceable model Resistance = Components.FuelCell.OhmicResistancePEN;
  replaceable model HOR = Components.FuelCell.ChemicalReactions.HOR;
  //Components.FuelCell.ChemicalReactions.GeneralReactionNew;
  // Constants
  constant Integer nX = 10 "Number of species in the mixture 1: H2O, 2: H2, 3: CO2, 4: CO, 5: CH4, 6: O2";
  // Universal constants
  constant Modelica.Units.SI.FaradayConstant F = Modelica.Constants.F "Faraday constant C/mol";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";
  // Structural properties
  constant Types.Area S = W*L "Channel contact surface with electrodes";
  constant Types.SpecificHeatCapacity cm = 400 "Specific heat capacity of the PEN";
  constant Types.HeatCapacity Cm = M*cm "Heat capacity of the PEN";
  constant Types.Length L = 5.1e-4 "Channel length";
  constant Types.Mass M = rho*V "PEN mass";
  constant Types.Density rho = 6600 "PEN density";
  constant Types.Area A = tauAE*W "Electrode cross section";
  constant Types.Length tauAE = 50e-6 "Anode electrode thickness";
  constant Types.Length tauCE = 50e-6 "Cathode electrode thickness";
  constant Types.Length tauSE = 150e-6 "Solid electrolyte thickness";
  constant Types.Volume V = S*(tauAE + tauCE + tauSE) "PEN volume";
  constant Types.Length W = 5.56e-3 "Channel width";
  // Other parameters
  constant Real beta = 0.5 "Transfer coefficient";
  constant Types.DiffusionCoefficient dEffAE = 3.66e-5 "Diffusivity coefficient for the anode electrode";
  constant Types.DiffusionCoefficient dEffCE = 1.37e-5 "Diffusivity coefficient for the cathode electrode";
  parameter Types.MolarEnergy Eanode = 140e3 "";
  parameter Types.MolarEnergy Ecathode = 137e3 "";
  parameter Types.SpecificConductivityArea kAnode = 6.54e11 "";
  parameter Types.SpecificConductivityArea kCathode = 2.35e11 "";
  // Initialization
  parameter Types.Temperature T_start = 920 "";
  parameter Types.MassFraction X_start_anode[nX] = ones(nX)/nX;
  final parameter Integer dominantSpecAnode = integer(Modelica.Math.Vectors.find(max(X_start_anode), X_start_anode));
  parameter Types.MassFraction X_start_cathode[nX] = ones(nX)/nX;
  final parameter Integer dominantSpecCathode = integer(Modelica.Math.Vectors.find(max(X_start_cathode), X_start_cathode));
  parameter Types.Pressure p_start = 101325;
  constant Types.MolarMass MM[nX] = DiffusionLosses.Utilities.ConstantsFluidAndSolid.MM;
  parameter Types.Pressure pX_anode_start[nX] = p_start/MM[dominantSpecAnode]*X_start_anode.*MM;
  parameter Types.Pressure pX_cathode_start[nX] = p_start/MM[dominantSpecCathode]*X_start_cathode.*MM;
  parameter Types.CurrentDensity j_start = 1.5;
  parameter Types.CurrentDensity j0Anode_start = 15000;
  parameter Types.CurrentDensity j0Cathode_start = 6000;
  //Nominal Values
  parameter Types.Temperature Tnom = 950 "Nominal value for PEN temperature";
  // Variables
  Types.SpecificMolarGibbsFreeEnergy dg0HOR "H2 oxidation reaction rate";
  Types.ElCurrent i "PEN current";
  Types.CurrentDensity j(start = j_start) "PEN current density relative to channel-PEN contact area" annotation (
    __OpenModelica_tearingSelect = TearingSelect.always);
  //0.1
  Types.CurrentDensity j0Anode(start = j0Anode_start);
  Types.CurrentDensity j0Cathode(start = j0Cathode_start);
  Types.Power elP "Power output";
  Types.ElPotential vOCP(start = 1) "PEN Open Circuit voltage (Nernst law)";
  Types.ElPotential vPEN "PEN voltage";
  Types.ElPotential vActAnode(start = 0.1) "Voltage loss due to activation phenomena in the anode";
  //0.02
  Types.ElPotential vActCathode(start = 0.2) "Voltage loss due to activation phenomena in the cathode";
  //0.02
  Types.ElPotential vConc(start = 0) "Voltage loss due to concentration effects";
  //0.01
  Types.ElPotential vOhm(start = 0) "Voltage loss due to ohmic effects";
  //0.2
  // Thermodynamic quantities
  Types.HeatFlowRate Qanode "";
  Types.HeatFlowRate Qcathode "";
  Types.Temperature T(start = T_start) "" annotation (
    __OpenModelica_tearingSelect = TearingSelect.always);
  // Pressures
  Types.Pressure pAnode "";
  Types.Pressure pCathode "";
  Types.Pressure pH2 "Partial pressure H2 in the channel";
  Types.Pressure pH2O "Partial pressure H2O in the channel";
  Types.Pressure pO2 "Partial pressure O2 in the channel";
  Types.Pressure pH2TPB "Triple phase boundary H2 partial pressure";
  Types.Pressure pH2OTPB "Triple phase boundary H2O partial pressure";
  Types.Pressure pO2TPB "Triple phase boundary O2 partial pressure";
  Types.MolarEnergy RT "Variable expressing the product R*T: in homotopy lambda0 step it is R*Tnom";
  // Ohmic resistance model
  Resistance rOhm(T = T, tauAE = tauAE, tauCE = tauCE, tauSE = tauSE, Tnom = Tnom);
  // HOR reaction
  HOR hor(T = T, T_start = T_start, Tnom = Tnom) "";
  // Heat ports
  Interfaces.HeatPort cathodeHeatPort annotation (
    Placement(visible = true, transformation(origin = {-50, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.HeatPort anodeHeatPort annotation (
    Placement(visible = true, transformation(origin = {-50, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  // Electrical ports
  Interfaces.FuelCellInterfaces.ElPin anodePin annotation (
    Placement(visible = true, transformation(origin = {0, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.FuelCellInterfaces.ElPin cathodePin annotation (
    Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  constant Modelica.Units.SI.DimensionlessRatio logVal = 1 "Homotopy parameter to simplify vOCP";
  // Signals
  Interfaces.FuelCellInterfaces.PressureInputSignal partialPressuresAnode[nX](start = pX_anode_start) annotation (
    Placement(visible = true, transformation(origin = {-100, -70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Interfaces.FuelCellInterfaces.PressureInputSignal absolutePressureAnode(start = p_start) annotation (
    Placement(visible = true, transformation(origin = {-100, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Interfaces.FuelCellInterfaces.PressureInputSignal absolutePressureCathode(start = p_start) annotation (
    Placement(visible = true, transformation(origin = {-100, 30}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Interfaces.FuelCellInterfaces.PressureInputSignal partialPressuresCathode[nX](start = pX_cathode_start) annotation (
    Placement(visible = true, transformation(origin = {-100, 70}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Interfaces.FuelCellInterfaces.RHOROutputSignal rHOR annotation (
    Placement(visible = true, transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  parameter Types.PerUnit porosity = 0.35 "Porosity coefficient for anode and cathode electrodes";
  DiffusionLosses.ConcResitanceDGM concLosses(T = T, pAnode = pAnode, pCathode = pCathode, pXa = partialPressuresAnode, pXc = partialPressuresCathode, porosity = porosity, nX = nX, Tnom = Tnom);
  Components.FuelCell.DiffusionLosses.DiffusivityCoefficients D(T = T, pAnode = pAnode, pCathode = pCathode, pXa = partialPressuresAnode, pXc = partialPressuresCathode, porosity = porosity, nX = nX, Tnom = Tnom);
  //   Real check;
  //   Real check2;
  parameter Types.ElPotential vRef1 = 1.15 annotation (
    Evaluate = true);
  parameter Types.ElPotential vRef2 = 0.8 annotation (
    Evaluate = true);
  parameter Types.ElCurrent iRef1 = 0 annotation (
    Evaluate = true);
  parameter Types.ElCurrent iRef2 = 3 annotation (
    Evaluate = true);
  Types.DiffusionCoefficient dEffH2O = if constantDiff then dEffAE else D.D_H2O_p;
  Types.DiffusionCoefficient dEffH2 = if constantDiff then dEffAE else D.D_H2_p;
  Types.DiffusionCoefficient dEffO2 = if constantDiff then dEffCE else D.D_O2_p;
  Components.HeatTransferModels.RadiativeHeatTransfer heatRadAnode(S = S, Tpen = T, Tplate = radAnode.T);
  Components.HeatTransferModels.RadiativeHeatTransfer heatRadCathode(S = S, Tpen = T, Tplate = radCathode.T);
  Interfaces.HeatPort radCathode annotation (
    Placement(transformation(extent = {{40, 50}, {60, 70}})));
  Interfaces.HeatPort radAnode annotation (
    Placement(transformation(extent = {{40, -68}, {60, -48}})));
  parameter Types.ElCurrent iPENmax;
  parameter Types.ElPotential vLeak0;
  Types.ElPotential vLeak = if leak then vLeak0*(1 - i/iPENmax) else 0;
  Real logValCheck = logBound(pH2O/pH2/sqrtBound(pO2/101325));
  Real logValCheck2 = -RT/2/F*logBound(pH2O/pH2/sqrtBound(pO2/101325));
  Real vHomotopyLinCheck = (i - iRef1)/(iRef2 - iRef1)*(vRef2 - vRef1) + vRef1;
  Real logBoundCHeck = logBound(pH2OTPB/pH2O*pH2/pH2TPB) + 0.5*logBound(pO2/pO2TPB);
  Real logBoundWorse = log(1e-9) + 0.5*log(1e-9);
  parameter Types.Pressure pH2Ofixed = 14e5;
  parameter Types.Pressure pH2fixed = 2.5e5;
  parameter Types.Pressure pO2fixed = 3.5e5;
  Types.Pressure pH2Oh;
  Types.Pressure pH2h;
  Types.Pressure pO2h;
equation
  // Boundary Conditions
  anodeHeatPort.Q_flow = Qanode;
  anodeHeatPort.T = T;
  cathodeHeatPort.Q_flow = Qcathode;
  cathodeHeatPort.T = T;
  absolutePressureAnode = pAnode;
  absolutePressureCathode = pCathode;
  pH2 = partialPressuresAnode[2];
  pH2O = partialPressuresAnode[1];
  pO2 = partialPressuresCathode[8];
  radAnode.Q_flow = heatRadAnode.Q;
  radCathode.Q_flow = heatRadCathode.Q;
  dg0HOR = hor.dg0r;
  rHOR = j/2/F;
  // El ports
  anodePin.i = i;
  cathodePin.i = -i;
  vPEN = anodePin.v - cathodePin.v;
  RT = homotopy(R*T, R*Tnom);
  pH2Oh = homotopy(pH2O, pH2Ofixed);
  pH2h = homotopy(pH2, pH2fixed);
  pO2h = homotopy(pO2, pO2fixed);
  vOCP = homotopy(-dg0HOR/2/F - RT/2/F*logBound(pH2Oh/pH2h/sqrtBound(pO2h/101325)), -dg0HOR/2/F - RT/2/F*logVal);
  j = i/S;
  // Partial pressure triple phase boundary
  pH2OTPB = homotopy(max(pH2Oh + RT*tauAE/2/F/dEffH2O*j, 10000), pH2Oh);
  pH2TPB = homotopy(max(pH2h - RT*tauAE/2/F/dEffH2*j, 10000), pH2h);
  pO2TPB = homotopy(max(pCathode - (pCathode - pO2h)*exp(RT*tauCE/4/F/dEffO2/pCathode*j), 1000), pO2h);
  // Voltage Losses
  vOhm = j*rOhm.R;
  vConc = if nonLinConc then homotopy(RT/2/F*(logBound(pH2OTPB/pH2O*pH2/pH2TPB) + 0.5*logBound(pO2/pO2TPB)), j*concLosses.Rb) else j*concLosses.Rb;
  if explicit then
    vActAnode = homotopy(2*RT/2/F*logBound(j/2/j0Anode + sqrtBound((j/2/j0Anode)^2 + 1)), RT/2/F*j/j0Anode);
    vActCathode = homotopy(2*RT/2/F*logBound(j/2/j0Cathode + sqrtBound((j/2/j0Cathode)^2 + 1)), RT/2/F*j/j0Cathode);

  else
    j = j0Anode*(exp(beta*2*F/RT*vActAnode) - exp(-(1 - beta)*2*F/RT*vActAnode));
    j = j0Cathode*(exp(beta*2*F/RT*vActCathode) - exp(-(1 - beta)*2*F/RT*vActCathode));

  end if;
  j0Anode = RT/2/F*kAnode*exp(-Eanode/RT);
  j0Cathode = RT/2/F*kCathode*exp(-Ecathode/RT);

  vPEN = homotopy(vOCP - vOhm - vConc - vActAnode - vActCathode - vLeak, (i - iRef1)/(iRef2 - iRef1)*(vRef2 - vRef1) + vRef1);

  Cm*der(T) = -elP + Qanode + Qcathode + radAnode.Q_flow + radCathode.Q_flow;
  elP = vPEN*i;
initial equation
  der(T) = 0;
  annotation (
    Icon(graphics={  Rectangle(origin = {0, -40}, lineColor = {156, 156, 156}, fillColor = {156, 156, 156}, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, -20}}), Rectangle(origin = {0, 40}, lineColor = {156, 156, 156}, fillColor = {156, 156, 156}, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, -20}}), Rectangle(lineColor = {85, 170, 255}, fillColor = {85, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 20}, {100, -20}})}));
end PEN;
