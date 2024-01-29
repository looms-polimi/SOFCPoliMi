within SOFCPoliMi.Media.MainClasses.SOS_CO2;
model SOS10ComponentsModelica
  import SD = SOFCPoliMi.Media.Utilities.SpeciesData;
  extends SOFCPoliMi.Media.BaseClasses.IdealMixture(
    nX=10,
    posCond=1,
    posOxygen=8,
    X_default={0,0,1,0,0,0,0,0,0,0},
    MM={Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM,
        Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM,Modelica.Media.IdealGases.Common.SingleGasesData.CO.MM,
        Modelica.Media.IdealGases.Common.SingleGasesData.CH4.MM,Modelica.Media.IdealGases.Common.SingleGasesData.C2H6.MM,
        Modelica.Media.IdealGases.Common.SingleGasesData.C3H8.MM,Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM,
        Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM,Modelica.Media.IdealGases.Common.SingleGasesData.Ar.MM},

    Hf={SD.HfH2Omass,SD.HfH2mass,SD.HfCO2mass,SD.HfCOmass,SD.HfCH4mass,SD.HfC2H6mass,
        SD.HfC3H8mass,SD.HfO2mass,SD.HfN2mass,SD.HfArmass},
    cp_coeff={SD.cpH2Omass,SD.cpH2mass,SD.cpCO2mass,SD.cpCOmass,SD.cpCH4mass,SD.cpC2H6mass,
        SD.cpC3H8mass,SD.cpO2mass,SD.cpN2mass,SD.cpArmass},
    LHV={0,119956e3,0,10102.8e3,50028.8e3,47512.3e3,46333.7e3,0,0,0});
  replaceable package Medium = Media.BaseClasses.IdealModelicaMedia(data = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O, Modelica.Media.IdealGases.Common.SingleGasesData.H2, Modelica.Media.IdealGases.Common.SingleGasesData.CO2, Modelica.Media.IdealGases.Common.SingleGasesData.CO, Modelica.Media.IdealGases.Common.SingleGasesData.CH4, Modelica.Media.IdealGases.Common.SingleGasesData.C2H6, Modelica.Media.IdealGases.Common.SingleGasesData.C3H8, Modelica.Media.IdealGases.Common.SingleGasesData.O2, Modelica.Media.IdealGases.Common.SingleGasesData.N2, Modelica.Media.IdealGases.Common.SingleGasesData.Ar}, fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O, Modelica.Media.IdealGases.Common.FluidData.H2, Modelica.Media.IdealGases.Common.FluidData.CO2, Modelica.Media.IdealGases.Common.FluidData.CO, Modelica.Media.IdealGases.Common.FluidData.CH4, Modelica.Media.IdealGases.Common.FluidData.C2H6, Modelica.Media.IdealGases.Common.FluidData.C3H8, Modelica.Media.IdealGases.Common.FluidData.O2, Modelica.Media.IdealGases.Common.FluidData.N2, Modelica.Media.IdealGases.Common.FluidData.Ar}, referenceChoice = Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C, fixedX = false);
  //     reference_X = X_startNew,
  Medium.ThermodynamicState state;
  //   Medium.DynamicViscosity eta;
  //   Medium.ThermalConductivity lambda;
  constant Types.MassFraction X_startNew[nX] = ones(nX)*1/nX;
  //  Types.SpecificEnthalpy ENTALPIAMODELICA = Medium.specificEnthalpy(state);
  //  Real errore = abs(ENTALPIAMODELICA-hPROVATEMP)/ENTALPIAMODELICA;
equation
  state = Medium.setState_pTX(p, T, X);
  //  fluid.T = T;
  //  fluid.p = p;
  //  fluid.X = X;
  mu = Medium.dynamicViscosity(state);
  k = Medium.thermalConductivity(state);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end SOS10ComponentsModelica;
