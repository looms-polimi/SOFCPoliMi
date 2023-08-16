within SOFCPoliMi.Media.Utilities;
model MoleToMassExec

  // 1: H2O,
  // 2: H2,
  // 3: CO2,
  // 4: CO,
  // 5: CH4,
  // 6: O2,
  // 7: N2,
  // 8: Ar

  SOFCPoliMi.Media.Utilities.MoleToMass moleToMass(nX = 5, MM = {Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM,
          Modelica.Media.IdealGases.Common.SingleGasesData.Ar.MM})   "";

  parameter Types.MoleFraction Y[moleToMass.nX] = {0.004054714, 0.974758981, 0.002735142, 0.012795941, 0.005655088};

equation

  moleToMass.Y = Y;

end MoleToMassExec;
