within SOFCPoliMi.Components.FuelCell;
partial model BaseChannel
  //Type of Channel
  parameter Boolean isAnode "";
  // Initialization
  type InitType = enumeration(steadyState "Steady state initialization", fixedValues "Fixed values initialization");
  parameter InitType initType = InitType.steadyState;
  parameter Boolean initialEquation = true;
  // Replaceable models
  replaceable model Fluid =
      Media.MainClasses.SOS_CO2.SOS10ComponentsModelica;
  replaceable model HeatTransfer =
      Components.HeatTransferModels.FuelCellConvectiveHeatTransfer;
  // Number of Species
  constant Integer nX = 10 "Number of species in the mixture 1: H2O, 2: H2, 3: CO2, 4: CO, 5: CH4, 6: O2, 7: N2, 8: Ar";
  // Channel geometry parameters
  constant Types.Area A = H*W "Channel cross-section";
  constant Types.Length Di = 2*H*W/(H + W) "Channel hydraulic diameter";
  constant Types.Length H = 8.67e-4 "Channel height";
  constant Types.Length L = 0.0005054568 "Channel length";
  constant Types.Area S = W*L "Channel contact surface with electrode";
  constant Types.Area Sside = L*H "Channel side surface (interconnecting plate)";
  constant Types.Area Sintercon = S + 2*Sside "Total interconnecting plate heat exchange area";
  constant Types.Volume V = A*L "Channel Volume";
  constant Types.Length W = 5.56e-3 "Channel width";
  constant Types.Length wp = 2*H + 2*W "Channel wet perimeter";
  // Nominal values
  parameter Types.Pressure deltapNom = 1e3 "Nominal pressure drop";
  parameter Types.MassFlowRate wNom = 1e-6 "Nominal mass flow rate";
  parameter Types.CoefficientOfHeatTransfer alphaNom "Nominal convective heat transfer coefficient";
  // Initialization
  parameter Types.Pressure p_start = 27e5 "Start value for pressure";
  parameter Types.Pressure pXin_startWithZeros[nX] = p_start*X_start_in.*fluidIn.MM/fluidIn.MM[fluidIn.dominantSpecies];
  parameter Types.Pressure pXin_start[nX] = {max(pXin_startWithZeros[i], ModelicaServices.Machine.eps) for i in 1:nX};
  parameter Types.Pressure pXout_startWithZeros[nX] = p_start*X_start_out.*fluidIn.MM/fluidIn.MM[fluidIn.dominantSpecies];
  parameter Types.Pressure pXout_start[nX] = {max(pXout_startWithZeros[i], ModelicaServices.Machine.eps) for i in 1:nX};
  parameter Types.Density rho_start_in = 8 "Start value for density";
  parameter Types.Density rho_start_out = 8 "Start value for density";
  parameter Types.Temperature T_start_in = 900 "Start value for temperature";
  parameter Types.Temperature T_start_out = 900 "Start value for temperature";
  parameter Types.Temperature Tpen_start = 900 "Start value for temperature";
  parameter Types.Temperature Tplate_start = 900 "Start value for temperature";
  parameter Types.MassFraction X_start_in[nX] = ones(nX)/nX "Start value for composition";
  parameter Types.MassFraction X_start_out[nX] = ones(nX)/nX "Start value for composition";
  parameter Types.MassFlowRate w_start_in = 0.000117298e-3 "Start value for mass flow rate";
  parameter Types.MassFlowRate w_start_out = 0.000117298e-3 "Start value for mass flow rate";
  parameter Types.MassFlowRate wO2_start = 0 "Start value for mass flow rate";
  // Nusselt number
  constant Types.NusseltNumber Nu "Nusselt number of the flow in the channel";
  // Oxygen Molar Mass
  constant Types.MolarMass MMO2 = Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM "Oxygen molar mass";
  // Variables
  Types.MassFlowRate dM_dt;
  Types.Power dU_dt;
  Types.Pressure deltap "Friction loss in the channel";
  Types.SpecificEnthalpy hIn "mixture inlet enthalpy";
  Types.SpecificEnthalpy hOut "mixture outlet enthalpy";
  Types.SpecificEnthalpy hO2 "O2 enthalpy";
  Types.Mass M(nominal = 1e-11) "Mixture mass in the volume";
  Types.MolarFlowRate nIn = wIn/fluidIn.MMmix "";
  Types.MolarFlowRate nIn_i[nX] = nIn*fluidIn.Y "";
  Types.MolarFlowRate nOut = wOut/fluidOut.MMmix "";
  Types.MolarFlowRate nOut_i[nX] = nOut*fluidOut.Y "";
  Types.Pressure pIn(start = p_start, nominal = 101325) "Mixture inlet pressure";
  Types.Pressure pOut(start = p_start, nominal = 101325) "Mixture outlet pressure" annotation (
    tearingSelect = always);
  Types.Pressure pX[nX](start = pXout_start) "Partial pressures in the channel";
  Types.Density rhoIn(start = rho_start_in) "Mixture inlet density";
  Types.Density rhoOut(start = rho_start_out) "Mixture outlet density";
  Types.Temperature Tin(start = T_start_in, nominal = 1e3) "Mixture inlet temperature" annotation (tearingSelect = always);
  // , nominal=1000
  Types.Temperature Tout(start = T_start_out, nominal = 1e3) "Mixture outlet temperature" annotation (tearingSelect = always);
  // , nominal=1000
  Types.Temperature TwPEN(start = Tpen_start, nominal = 1e3) "Temperature of the PEN (wall)" annotation (
    tearingSelect = always);
  // , nominal=1000
  Types.Temperature TwPlate(start = Tplate_start, nominal = 1e3) "Temperature of the interconnection plate (wall)" annotation (
    tearingSelect = always);
  // , nominal=1000
  Types.MassFlowRate wIn(start = w_start_in, nominal = 1e-6) "Channel inlet mass flow rate";
  Types.MassFlowRate wIn_i[nX] = wIn*Xin "";
  Types.MassFlowRate wOut(start = w_start_out, nominal = 1e-6) "Channel outlet mass flow rate";
  Types.MassFlowRate wOut_i[nX] = wOut*Xout "";
  Types.MassFlowRate wO2(start = wO2_start, nominal = 1e-12) "Oxygen flow from cathode channel to anode channel";
  Types.MassFraction Xin[nX](start = X_start_in) "Mixture inlet mass fractions";
  Types.MassFraction Xout[nX](start = X_start_out) "Mixture outlet mass fractions" annotation (
    tearingSelect = always);
  Real sumXout = sum(Xout) "";
  Types.MoleFraction Yin[nX] = fluidIn.Y "Molar fraction at inlet";
  Types.MoleFraction Yout[nX] = fluidOut.Y "Molar fraction at outlet";
  // Media variables
  Fluid fluidOxyRef(nX = nX, anodicFlow = isAnode, cathodicFlow = not isAnode, T_start = T_start_in, p_start = p_start, X_start = X_start_in, rho_start = rho_start_in) "Fluid reference for Oxygen properties";
  Fluid fluidIn(nX = nX, anodicFlow = isAnode, cathodicFlow = not isAnode, T_start = T_start_in, p_start = p_start, X_start = X_start_in, rho_start = rho_start_in) "Fluid at channel inlet";
  Fluid fluidOut(nX = nX, anodicFlow = isAnode, cathodicFlow = not isAnode, T_start = T_start_out, p_start = p_start, X_start = X_start_out, rho_start = rho_start_out) "Fluid at channel outlet";
  // Fluid and Heat ports
  Interfaces.FlangeA inlet(nXi = nX, nC = 0, w(min = 0)) "Inlet connector" annotation (
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-120, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Interfaces.FlangeB outlet(nXi = nX, nC = 0, w(max = 0)) "Outlet connector" annotation (
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {120, 3.55271e-15}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Interfaces.HeatPort wallPEN annotation (
    Placement(visible = true, transformation(origin = {40, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {40, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  Interfaces.HeatPort wallPlate annotation (
    Placement(visible = true, transformation(origin = {-40, 3.9968e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-40, 0}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
  // Heat transfer models
  HeatTransfer htPEN(Nu = Nu, Lc = Di, A = A, S = S, Tw = TwPEN, Tflow = Tout, k = fluidIn.k, T_start = T_start_out, alphaNom = alphaNom) "";
  //(Tout+Tin)/2
  HeatTransfer htPlate(Nu = Nu, Lc = Di, A = A, S = Sintercon, Tw = TwPlate, Tflow = Tout, k = fluidIn.k, T_start = T_start_out, alphaNom = alphaNom) "";
  // (Tout+Tin)/2
  // Signals
  Interfaces.FuelCellInterfaces.PressureOutputSignal partialPressures[nX] annotation (
    Placement(visible = true, transformation(origin = {90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Interfaces.FuelCellInterfaces.PressureOutputSignal absolutePressure annotation (
    Placement(visible = true, transformation(origin = {88, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-90, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Interfaces.FuelCellInterfaces.RHORInputSignal rHOR annotation (
    Placement(visible = true, transformation(origin = {-70, 62}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {0, -56}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Real velocity "";
  Real tau "";
  Types.Power entFlowIn = wIn*hIn;
  Types.Power entFlowOut = wOut*hOut;
equation
  velocity = wOut/rhoOut/A;
  tau = L/velocity;
  // FluidOxyRef properties
  fluidOxyRef.p = pOut;
  fluidOxyRef.X = Xout;
  fluidOxyRef.T = if isAnode then TwPEN else Tout;
  // Inlet mixture properties linking
  fluidIn.h = hIn;
  fluidIn.p = pIn;
  fluidIn.rho = rhoIn;
  fluidIn.T = Tin;
  fluidIn.X = Xin;
  // Outlet mixture properties linking
  fluidOut.h = hOut;
  fluidOut.p = pOut;
  fluidOut.rho = rhoOut;
  fluidOut.T = Tout;
  fluidOut.X = Xout;
  // Boundary conditions
  hIn = inStream(inlet.h);
  pIn = inlet.p;
  wIn = inlet.w;
  fluidIn.X = inStream(inlet.Xi);
  hOut = outlet.h;
  pOut = outlet.p;
  wOut = -outlet.w;
  fluidOut.X = outlet.Xi;
  // Temperature for Heat ports
  TwPEN = wallPEN.T;
  TwPlate = wallPlate.T;
  // Signals for PEN
  pX = pOut*fluidOut.Y;
  absolutePressure = pOut;
  partialPressures = pX;
  inlet.h = 0 "Dummy never used: no flow reversal";
  inlet.Xi = X_start_in "Dummy never used: no flow reversal";
  // O2 ion transport
  wO2 = 0.5*rHOR*MMO2*S;
  hO2 = fluidOxyRef.h_species[fluidIn.posOxygen];
  // Momentum balance
  deltap = deltapNom/wNom*wIn "Really simplified version";
  pIn = pOut + deltap;
  // Mass Balance
  M = V*fluidOut.rho;
  dM_dt = -V*rhoOut^2*(fluidOut.dv_dT*der(Tout) + fluidOut.dv_dp*der(pOut) + fluidOut.dv_dX*der(Xout));

  // Energy balance
  dU_dt = M*(fluidOut.du_dT*der(Tout) + fluidOut.du_dX*der(Xout)) + dM_dt*fluidOut.u;
  assert(sumXout > 0.99, "Sum of mass fraction lower than 0.99", AssertionLevel.warning);
  assert(sumXout < 1.01, "Sum of mass fraction higher than 1.01", AssertionLevel.warning);
initial equation
  if initType == InitType.steadyState then
    if initialEquation then
      der(pOut) = 0;
    end if;
    der(Tout) = 0;
    der(Xout) = zeros(nX);
  elseif initType == InitType.fixedValues then
    pOut = p_start;
    Tout = T_start_out;
    Xout = X_start_out;
  end if;
  annotation (
    Icon(graphics={  Rectangle(fillColor = {159, 159, 223}, fillPattern = FillPattern.HorizontalCylinder, lineThickness = 0.01, extent = {{-120, 60}, {120, -60}})}));
end BaseChannel;
