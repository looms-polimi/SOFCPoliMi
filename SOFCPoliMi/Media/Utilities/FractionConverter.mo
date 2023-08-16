within SOFCPoliMi.Media.Utilities;
partial model FractionConverter

  // 1: H2O,
  // 2: H2,
  // 3: CO2,
  // 4: CO,
  // 5: CH4,
  // 6: O2,
  // 7: N2,
  // 8: Ar

  final constant Types.PerUnit invMM[nX] = ones(nX)./MM "Elementwise inverse of the molar mass vector to evaluate MMmix";
  constant Types.MolarMass MM[nX] = {
   Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.CO.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.CH4.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.Ar.MM} "Molar masses of the species";
  constant Integer nX = 8 "number of species in the mixture";


  Types.MolarMass MMmix "Molar mass of the mixture";

equation

end FractionConverter;
