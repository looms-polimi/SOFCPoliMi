within SOFCPoliMi.Media.MainClasses.SOS_CO2;
model SOS10ComponentsModelica
  extends SOFCPoliMi.Media.BaseClasses.IdealMixture(
    nX=10,
    posCond = 1,
    posOxygen = 8,
    X_default = {0,0,1,0,0,0,0,0,0,0},
    MM = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.CH4.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.C2H6.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.C3H8.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.Ar.MM},
    Hf = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.H2.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.CH4.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.C2H6.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.C3H8.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.O2.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2.Hf,
          Modelica.Media.IdealGases.Common.SingleGasesData.Ar.Hf},
    cp_coeff = {{-2.2817222567515e-07,0.00068126780231503,0.046306944938403,1792.2033608181},
                {2.6997853748501e-07,0.00032759518590539,0.06803723179264,14324.363921531},
                {2.2131327339673e-07,-0.00092151007501244,1.4416059822539,493.52730053016},
                {-1.5874856105094e-07,0.00038389958942411,-0.068128907330494,1025.7766165635},
                {-5.6776551798465e-07,0.00048562268849522,3.5809130457096,1087.3242540246},
                {3.9336581603912e-07,-0.0025939417819359,6.1606820767477,115.30876220525},
                {6.9469559921696e-07,-0.0034853852149653,6.8351551007804,-82.089844972404},
                {-6.9227589493855e-09,-0.00011005218338676,0.40567177501433,801.06933856571},
                {-1.7194266972964e-07,0.00044985407669626,-0.16123790188215,1048.8091727539},
                {7.766642892724e-14,-1.9260545664121e-10,1.3792435213858e-07,520.33090172226}},
    LHV = {0, 119956e3, 0, 10102.8e3, 50028.8e3, 47512.3e3, 46333.7e3, 0, 0, 0});


  replaceable package Medium = Media.BaseClasses.IdealModelicaMedia (
    data = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O,
            Modelica.Media.IdealGases.Common.SingleGasesData.H2,
            Modelica.Media.IdealGases.Common.SingleGasesData.CO2,
            Modelica.Media.IdealGases.Common.SingleGasesData.CO,
            Modelica.Media.IdealGases.Common.SingleGasesData.CH4,
            Modelica.Media.IdealGases.Common.SingleGasesData.C2H6,
            Modelica.Media.IdealGases.Common.SingleGasesData.C3H8,
            Modelica.Media.IdealGases.Common.SingleGasesData.O2,
            Modelica.Media.IdealGases.Common.SingleGasesData.N2,
            Modelica.Media.IdealGases.Common.SingleGasesData.Ar},
    fluidConstants = {Modelica.Media.IdealGases.Common.FluidData.H2O,
                      Modelica.Media.IdealGases.Common.FluidData.H2,
                      Modelica.Media.IdealGases.Common.FluidData.CO2,
                      Modelica.Media.IdealGases.Common.FluidData.CO,
                      Modelica.Media.IdealGases.Common.FluidData.CH4,
                      Modelica.Media.IdealGases.Common.FluidData.C2H6,
                      Modelica.Media.IdealGases.Common.FluidData.C3H8,
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

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SOS10ComponentsModelica;
