within SOFCPoliMi.Media.BaseClasses;
partial model PartialMixture "Interface for real mixture gas models"
  extends Modelica.Icons.MaterialProperty;
  import SOFCPoliMi.Types;
  parameter Boolean computeEnthalpyCondensation = false "Used to decide if it is necessary to calculate enthalpy condensation";
  parameter Boolean computeTransport = true "Used to decide if it is necessary to calculate the transport properties";
  parameter Boolean computeEntropy = true "Used to decide if it is necessary to calculate the entropy of the fluid";
  final parameter Integer dominantSpecies = integer(Modelica.Math.Vectors.find(max(X_start), X_start));
  constant Integer nX = 5 "Number of elements in the mass fraction array that influence fluid properties";
  parameter Integer nXi "Number of independent elements in the mass fraction array that influence fluid properties";
  parameter Integer nC "Number of mass fractions of components that are not used to compute the fluid properties";
  parameter Types.MassFraction Xi_start[nXi] "Start value of the indepentend elements of fluid mass composition";
  parameter Types.Pressure p_start "Start value of the fluid pressure";
  parameter Types.Temperature T_start "Start value of the fluid temperature";
  parameter Types.MassFraction X_start[nX] = X_default "Start value of the fluid mass composition";
  constant Types.MassFraction X_default[nX] = ones(nX)/nX "Default composition";
  constant Types.LowerHeatingValue LHV[nX] = ones(nX)*1e6;
  //Variables
  connector InputPressure = input Types.Pressure "Pseudo-input to check model balancedness";
  connector InputTemperature = input Types.Temperature "Pseudo-input to check model balancedness";
  connector InputMassFraction = input Types.MassFraction "The fluid properties are defined by a temperature value";
  InputPressure p(start = p_start) "Absolute pressure";
  InputTemperature T(start = T_start) "Temperature" annotation (
    tearingSelect = always);
  InputMassFraction Xi[nXi](start = Xi_start) "Mass fraction vector";
  Types.MassFraction X[nX](start = X_start) "Mass fraction vector";
  Types.MassFraction C[nC] "Mass fraction vector for tracking components";
  Types.SpecificEnergy u "Specific Internal Energy of the fluid";
  Types.SpecificEnthalpy h "Specific Enthalpy of the fluid";
  Types.SpecificEntropy s "Specific Entropy" annotation (
    HideResult = not ComputeEntropy);
  Types.DerSpecEnergyByPressure du_dp "Pressure derivative of the Specific Internal Energy";
  Types.DerSpecEnergyByTemperature du_dT "Temperature derivative of the Specific Internal Energy";
  Types.SpecificEnergy du_dX[nX] "Mass fraction derivative of Specific Internal Energy at constant pressure, per each component";
  Types.SpecificHeatCapacity cp "Specific heat capacity of the fluid";
  Types.SpecificHeatCapacity cv "Specific heat capacity of the fluid";
  Types.DerSpecificVolumeByPressure dv_dp "Pressure derivative of specific volume at constant Temperature" annotation (
    HideResult = not CompressibilityEffect);
  Types.DerSpecificVolumeByTemperature dv_dT "Temperature derivative of specific volume at constant pressure";
  Types.DerSpecificVolumeByComposition dv_dX[nX] "Mass fraction derivative of specific volumen, per each component";
  Types.DynamicViscosity mu "Dynamic viscosity" annotation (
    HideResult = not ComputeTransport);
  Types.ThermalConductivity k "Thermal Conductivity" annotation (
    HideResult = not ComputeTransport);
  Types.Density rho "Density of the fluid, needed in the pipe";
  Types.LowerHeatingValue LHVmix;
  annotation (
    Documentation(info = "<html>
  <p><b><span style=\"font-size: 13pt;\">Interface for real mixture gas models</span></b></p>
  <p>The objetive of this model is to have an interface and use it as a base model for any real mixture model. For the Allam Cycle application, Peng-Robinson EoS is the one to be considered, however, it is possible to develop different real fluid models using other EoS.</p>
  <p>The <u><span style=\"color: #0000ff;\">PartialMixture</span></u> model includes three input variables for pressure, temperature and mass fraction, in order to define the full properties of the fluid. The other variables are going to be used when it comes to develop the real mixture fluid model.</p>
  </html>"),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
end PartialMixture;
