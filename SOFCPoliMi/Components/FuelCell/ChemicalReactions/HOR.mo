within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model HOR
  // Cp polynomial is in the form: a + b*T + c*T^2 + d*T^3
  // If the order of the polynomial should be changed, also aTot, bTot, cTot, dTot must be modified together with the
  // equation for dg0r
  import SD = SOFCPoliMi.Media.Utilities.SpeciesData;
  constant Integer nX = 3 "Number of species in the reaction";
  constant Integer nCpCoeff = 4 "Number of coefficient of the polynomial describing Cp";
  // Universal parameter
  constant Modelica.Units.SI.FaradayConstant F = Modelica.Constants.F "Faraday constant C/mol";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas parameter per unit mol";
  // parameters
  constant Types.CpCoeff1 aTot = stoichCoeff*a_i "Weighted sum of known term of Cp on stoichiometric coefficients (molar basis)";
  constant Types.CpCoeff2 bTot = stoichCoeff*b_i "Weighted sum of linear term of Cp on stoichiometric coefficients (molar basis)";
  constant Types.CpCoeff3 cTot = stoichCoeff*c_i "Weighted sum of quadratic term of Cp on stoichiometric coefficients (molar basis)";
  constant Types.CpCoeff4 dTot = stoichCoeff*d_i "Weighted sum of known cubic of Cp on stoichiometric coefficients (molar basis)";
  //   constant Types.CpCoeff1 a_i[nX] = {28.87619874213591, 458.3624562522862, 258.057426868279} "a coefficient for cp for H2, O2, H2O";
  //   constant Types.CpCoeff2 b_i[nX] = {0.0001371548948261471, 0.002177109772686329, 0.001225709781169312} "b coefficient for cp for H2, O2, H2O";
  //   constant Types.CpCoeff3 c_i[nX] = {6.603925833629576e-07, 1.048265283474939e-05, 5.901719000737655e-06} "c coefficient for cp for H2, O2, H2O";
  //   constant Types.CpCoeff4 d_i[nX] = {5.442443341452819e-10, 8.638989225275338e-09, 4.863738946782951e-09} "d coefficient for cp for H2, O2, H2O";
  constant Types.CpCoeff1 a_i[nX] = {SD.cpH2mol[4], SD.cpO2mol[4], SD.cpH2Omol[4]} "a coefficient for cp for H2, O2, H2O";
  constant Types.CpCoeff2 b_i[nX] = {SD.cpH2mol[3], SD.cpO2mol[3], SD.cpH2Omol[3]} "b coefficient for cp for H2, O2, H2O";
  constant Types.CpCoeff3 c_i[nX] = {SD.cpH2mol[2], SD.cpO2mol[2], SD.cpH2Omol[2]} "c coefficient for cp for H2, O2, H2O";
  constant Types.CpCoeff4 d_i[nX] = {SD.cpH2mol[1], SD.cpO2mol[1], SD.cpH2Omol[1]} "d coefficient for cp for H2, O2, H2O";
  constant Types.SpecificMolarGibbsFreeEnergy dg0fTref[nX] = {SD.GfH2mol, SD.GfO2mol, SD.GfH2Omol} "Specific molar Gibbs free energy of formation";
  constant Types.SpecificMolarGibbsFreeEnergy dg0rTref = stoichCoeff*dg0fTref "Molar Gibbs free energy of reaction";
  constant Types.MolarEnthalpy dh0fTref[nX] = {SD.HfH2mol, SD.HfO2mol, SD.HfH2Omol} "Specific molar enthalpy of formation";
  constant Types.MolarEnthalpy dh0rTref = stoichCoeff*dh0fTref "Molar enthalpy of reaction";
  constant Types.MolarEnthalpy dh0rconst = dh0rTref - aTot*Tref - bTot/2*Tref^2 - cTot/3*Tref^3 - dTot/4*Tref^4 "";
  constant Types.PerUnit stoichCoeff[nX] = {-1, -0.5, 1} "Stoichiometric coefficient of the reaction";
  constant Types.Temperature Tref = 298.15 "Reference temperature for formation enthalpy and gibbs free energy";
  // Start values
  parameter Types.Temperature T_start = 1100 "";
  // Nominal Values
  parameter Types.Temperature Tnom = 1200 "";
  // Variables
  Types.SpecificMolarGibbsFreeEnergy dg0r "Delta Gibbs Free Energy of Reaction at nominal pressure";
  Types.MolarEnthalpy dh0r "";
  Types.ElPotential E0 "Reversible electrical potential";
  input Types.Temperature T(start = T_start) "Temperature at which the reaction occurs";
  Types.Temperature Tstar "Temperature with homotopy operator";
equation
  Tstar = homotopy(T, Tnom);
  dh0r = dh0rTref + aTot*(Tstar - Tref) + bTot/2*(Tstar^2 - Tref^2) + cTot/3*(Tstar^3 - Tref^3) + dTot/4*(Tstar^4 - Tref^4);
  dg0r = R*Tstar*(dg0rTref/R/Tref - dh0rconst/R*(1/Tref - 1/Tstar) - aTot/R*log(Tstar/Tref) - bTot/2/R*(Tstar - Tref) - cTot/6/R*(Tstar^2 - Tref^2) - dTot/12/R*(Tstar^3 - Tref^3));
  E0 = -dg0r/2/F;
end HOR;
