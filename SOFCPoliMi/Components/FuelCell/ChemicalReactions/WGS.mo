within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model WGS
  // Cp polynomial is in the form: a + b*T + c*T^2 + d*T^3
  // If the order of the polynomial should be changed, also aTot, bTot, cTot, dTot must be modified together with the
  // equation for dg0r
  import SD = SOFCPoliMi.Media.Utilities.SpeciesData;
  constant Integer nX = 4 "Number of species in the reaction";
  constant Integer nCpCoeff = 4 "Number of coefficient of the polynomial describing Cp";
  // Universal parameter
  constant Modelica.Units.SI.FaradayConstant F = Modelica.Constants.F "Faraday constant C/mol";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas parameter per unit mol";
  // parameters
  constant Types.CpCoeff1 aTot = stoichCoeff*a_i "Weighted sum of known term of Cp on stoichiometric coefficients (molar basis)";
  constant Types.CpCoeff2 bTot = stoichCoeff*b_i "Weighted sum of linear term of Cp on stoichiometric coefficients (molar basis)";
  constant Types.CpCoeff3 cTot = stoichCoeff*c_i "Weighted sum of quadratic term of Cp on stoichiometric coefficients (molar basis)";
  constant Types.CpCoeff4 dTot = stoichCoeff*d_i "Weighted sum of known cubic of Cp on stoichiometric coefficients (molar basis)";
  constant Types.CpCoeff1 a_i[nX] = {SD.cpCOmol[4], SD.cpH2Omol[4], SD.cpCO2mol[4], SD.cpH2mol[4]} "a coefficient for cp for CO, H2O, CO2, H2";
  constant Types.CpCoeff2 b_i[nX] = {SD.cpCOmol[3], SD.cpH2Omol[3], SD.cpCO2mol[3], SD.cpH2mol[3]} "b coefficient for cp for CO, H2O, CO2, H2";
  constant Types.CpCoeff3 c_i[nX] = {SD.cpCOmol[2], SD.cpH2Omol[2], SD.cpCO2mol[2], SD.cpH2mol[2]} "c coefficient for cp for CO, H2O, CO2, H2";
  constant Types.CpCoeff4 d_i[nX] = {SD.cpCOmol[1], SD.cpH2Omol[1], SD.cpCO2mol[1], SD.cpH2mol[1]} "d coefficient for cp for CO, H2O, CO2, H2";
  constant Types.SpecificMolarGibbsFreeEnergy dg0fTref[nX] = {SD.GfCOmol, SD.GfH2Omol, SD.GfCO2mol, SD.GfH2mol} "Specific molar Gibbs free energy of formation";
  constant Types.SpecificMolarGibbsFreeEnergy dg0rTref = stoichCoeff*dg0fTref "Molar Gibbs free energy of reaction";
  constant Types.MolarEnthalpy dh0fTref[nX] = {SD.HfCOmol, SD.HfH2Omol, SD.HfCO2mol, SD.HfH2mol};
  constant Types.MolarEnthalpy dh0rTref = stoichCoeff*dh0fTref "Molar enthalpy of reaction";
  constant Types.MolarEnthalpy dh0rconst = dh0rTref - aTot*Tref - bTot/2*Tref^2 - cTot/3*Tref^3 - dTot/4*Tref^4 "";
  constant Types.PerUnit stoichCoeff[nX] = {-1, -1, 1, 1} "Stoichiometric coefficient of the reaction";
  constant Types.Temperature Tref = 298.15 "Reference temperature for formation enthalpy and gibbs free energy";
  // Start values
  parameter Types.Temperature T_start = 1100 "";
  // Nominal Values
  parameter Types.Temperature Tnom = 1100 "";
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
end WGS;
