within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model GeneralReaction

  // This model is ready for HOR: H2 + 0.5 O2 -> H2O
  // Cp polynomial is in the form: a + b*T + c*T^2 + d*T^3
  // If the order of the polynomial should be changed, also aTot, bTot, cTot, dTot must be modified together with the
  // equation for dg0r

  constant Integer nX = 3 "Number of species in the reaction";
  constant Integer nCpCoeff = 4 "Number of coefficient of the polynomial describing Cp";

  // Universal parameter
  constant Modelica.Units.SI.FaradayConstant F = Modelica.Constants.F "Faraday constant C/mol";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas parameter per unit mol";

  // parameters
  constant Real aTot = stoichCoeff*coeffCpmol[:,4] "Weighted sum of known term of Cp on stoichiometric coefficients (molar basis)";
  constant Real bTot = stoichCoeff*coeffCpmol[:,3] "Weighted sum of linear term of Cp on stoichiometric coefficients (molar basis)";
  constant Real cTot = stoichCoeff*coeffCpmol[:,2] "Weighted sum of quadratic term of Cp on stoichiometric coefficients (molar basis)";
  constant Real dTot = stoichCoeff*coeffCpmol[:,1] "Weighted sum of known cubic of Cp on stoichiometric coefficients (molar basis)";
  constant Real coeffCpmol[nX,nCpCoeff] = {
  {5.442443341452819e-10,6.603925833629576e-07,0.0001371548948261471,28.87619874213591},
  {8.638989225275338e-09,1.048265283474939e-05,0.002177109772686329,458.3624562522862},
  {4.863738946782951e-09,5.901719000737655e-06,0.001225709781169312,258.057426868279}} "Matrix of molar specific Cp coefficients (default = HOR)";
  constant Types.SpecificMolarGibbsFreeEnergy dg0fTref[nX] = {0, 0, -2.288e5} "Specific molar Gibbs free energy of formation (default = HOR)";
  constant Types.SpecificMolarGibbsFreeEnergy dg0rTref = stoichCoeff*dg0fTref "Molar Gibbs free energy of reaction";
  constant Types.MolarEnthalpy dh0fTref[nX] = {0, 0, -2.42e5} "Specific molar enthalpy of formation (default = HOR)";
  constant Types.MolarEnthalpy dh0rTref = stoichCoeff*dh0fTref "Molar enthalpy of reaction";
  constant Types.MolarEnthalpy dh0rconst = dh0rTref - aTot*Tref - bTot/2*Tref^2 - cTot/3*Tref^3 - dTot/4*Tref^4 "";
  constant Types.PerUnit stoichCoeff[nX] = {-1, -0.5, 1} "Stoichiometric coefficient of the reaction (default = HOR)";
  constant Types.Temperature Tref = 298.15 "Reference temperature for formation enthalpy and gibbs free energy";

  // Start values
  parameter Types.Temperature T_start "";

  // Nominal Values
  parameter Types.Temperature Tnom = 1200 "";

  // Variables
  Types.SpecificMolarGibbsFreeEnergy dg0r "Delta Gibbs Free Energy of Reaction at nominal pressure";
  Types.MolarEnthalpy dh0r "";
  Types.ElPotential E0 "Reversible electrical potential";
  input Types.Temperature T(start=T_start) "Temperature at which the reaction occurs";
  Types.Temperature Tstar "Temperature with homotopy operator";

equation

  Tstar = homotopy(T,Tnom);

  dh0r = dh0rTref + aTot*(Tstar-Tref) + bTot/2*(Tstar^2-Tref^2) + cTot/3*(Tstar^3-Tref^3) + dTot/4*(Tstar^4-Tref^4);
  dg0r = R*Tstar*(dg0rTref/R/Tref - dh0rconst/R * (1/Tref - 1/Tstar) - aTot/R*log(Tstar/Tref) - bTot/2/R*(Tstar-Tref) - cTot/6/R*(Tstar^2-Tref^2) -dTot/12/R*(Tstar^3-Tref^3));
  E0 = -dg0r/2/F;


end GeneralReaction;
