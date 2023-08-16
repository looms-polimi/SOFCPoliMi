within SOFCPoliMi.Media.MainClasses;
model SOS5ComponentsModelica
  extends BaseClasses.IdealMixture(
    nX=5,
    posCond = 1,
    posOxygen = 3,
    X_default = {0,1,0,0,0},
    MM = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.Ar.MM},
    Hf = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.O2.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.Ar.Hf},
    cp_coeff = {{-2.2817222567515e-07,0.00068126780231503,0.046306944938403,1792.2033608181},
                {2.2131327339673e-07,-0.00092151007501244,1.4416059822539,493.52730053016},
                {-6.9227589493855e-09,-0.00011005218338676,0.40567177501433,801.06933856571},
                {-1.7194266972964e-07,0.00044985407669626,-0.16123790188215,1048.8091727539},
                {7.766642892724e-14,-1.9260545664121e-10,1.3792435213858e-07,520.33090172226}},
    LHV = {0, 0, 0, 0, 0});

  replaceable package Medium = Media.BaseClasses.IdealModelicaMedia (
    data = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
            Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
            Modelica.Media.IdealGases.Common.SingleGasesData.O2,
            Modelica.Media.IdealGases.Common.SingleGasesData.N2,
            Modelica.Media.IdealGases.Common.SingleGasesData.Ar},
    fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,
                      Modelica.Media.IdealGases.Common.FluidData.CO2,
                      Modelica.Media.IdealGases.Common.FluidData.O2,
                      Modelica.Media.IdealGases.Common.FluidData.N2,
                      Modelica.Media.IdealGases.Common.FluidData.Ar},
    reference_X = X_startNew,
    referenceChoice = Modelica.Media.Interfaces.Choices.ReferenceEnthalpy.ZeroAt25C,
    fixedX = false);
  Medium.BaseProperties fluid;
//   Medium.DynamicViscosity eta;
//   Medium.ThermalConductivity lambda;

  constant Types.MassFraction X_startNew[nX] = ones(nX)*1/nX;
equation
  fluid.T = T;
  fluid.p = p;
  fluid.X = X;
  mu = Medium.dynamicViscosity(fluid.state);
  k = Medium.thermalConductivity(fluid.state);
end SOS5ComponentsModelica;
