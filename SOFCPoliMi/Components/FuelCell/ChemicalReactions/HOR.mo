within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model HOR

  extends FuelCell.ChemicalReactions.GeneralReaction(coeffCpmol = {coeffCpH2mol, coeffCpO2mol, coeffCpH2Omol}, nX = 3, nCpCoeff = 4, dg0fTref = {0, 0, -2.288e5}, dh0fTref = {0, 0, -2.42e5}, stoichCoeff = {-1, -0.5, 1});
  constant Real coeffCpmol2[nX,nCpCoeff] = {coeffCpH2mol, coeffCpO2mol, coeffCpH2Omol} "Matrix of molar specific Cp coefficients HOR";
  constant Real coeffCpH2[4] = {2.6997853748501e-07,0.00032759518590539,0.06803723179264,14324.363921531} "Mass coefficient for Cp H2";
  constant Real coeffCpH2mol[4] = coeffCpH2.*MMH2 "Molar coefficient for Cp H2";
  constant Real coeffCpO2[4] = {-6.9227589493855e-09,-0.00011005218338676,0.40567177501433,801.06933856571} "Mass coefficient for Cp O2";
  constant Real coeffCpO2mol[4] = coeffCpO2.*MMO2 "Molar coefficient for Cp O2";
  constant Real coeffCpH2O[4] = {-2.2817222567515e-07,0.00068126780231503,0.046306944938403,1792.2033608181} "Mass coefficient for Cp H2O";
  constant Real coeffCpH2Omol[4] = coeffCpH2O.*MMH2O "Molar coefficient for Cp H2O";
  constant Types.MolarMass MMH2 = Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM "Hydrogen molar mass";
  constant Types.MolarMass MMH2O = Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM "Water molar mass";
  constant Types.MolarMass MMO2 = Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM "Oxygen molar mass";

equation

end HOR;
