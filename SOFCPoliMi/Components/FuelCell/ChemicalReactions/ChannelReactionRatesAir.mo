within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model ChannelReactionRatesAir
  // 1: H2O,
  // 2: H2,
  // 3: CO2,
  // 4: CO,
  // 5: CH4,
  // 6: O2,
  // 7: N2,
  // 8: Ar
  constant Types.MolarEnergy EaSR = 82e3 "Steam Reforming activation energy";
  constant Types.PreExponFactor k0SR = 4.274e-2 "Steam Reforming pre-exponential factor";
  constant Types.PreExponFactor k0WGS = 1e-2 "Water Gas Shift pre-exponential factor (high Enough to consider the reaction at equilibrium";
  constant Integer nX = 10 "Number of species in the mixture";
  constant Types.Pressure pRef = 101325 "Reference pressure";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";
  // Start values
  parameter Types.Temperature T_start "";
  // Nomnial Values
  parameter Types.Temperature Tnom = 1100 "";
  // Variables
  Types.SpecificMolarGibbsFreeEnergy dg0WGS "Water Gas Shift Gibbs free energy of reaction";
  Types.PerUnit kEqWGS "Water Gas Shift equilibrium constant f(T)";
  input Types.Pressure pX[nX] "Partial pressure in the volume";
  Types.Pressure pH2O = pX[1] "Partial pressure H2O";
  Types.Pressure pH2 = pX[2] "Partial pressure H2";
  Types.Pressure pCO2 = pX[3] "Partial pressure CO2";
  Types.Pressure pCO = pX[4] "Partial pressure CO";
  Types.Pressure pCH4 = pX[5] "Partial pressure CH4";
  Types.Pressure pC2H6 = pX[6] "Partial pressure C2H6";
  Types.Pressure pC3H8 = pX[7] "Partial pressure C3H8";
  Types.AreaSpecificReactionRate rSRCH4 "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rSRC2H6 "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rSRC3H8 "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rWGS "Water Gas Shift reaction rate";
  input Types.Temperature T(start = T_start) "Mixture temperature";
  Types.MolarEnergy RT "";
  SOFCPoliMi.Components.FuelCell.ChemicalReactions.WGS wgs(T=T, Tnom=Tnom);
  //   OxyCombustionCyclesLibrary.Components.FuelCell.ChemicalReactions.SRch4 srCH4(T=T,Tnom=Tnom);
  //   OxyCombustionCyclesLibrary.Components.FuelCell.ChemicalReactions.SRc2h6 srC2H6(T=T,Tnom=Tnom);
  //   OxyCombustionCyclesLibrary.Components.FuelCell.ChemicalReactions.SRc3h8 srC3H8(T=T,Tnom=Tnom);
equation
  rSRC2H6 = 0;
  rSRC3H8 = 0;
  RT = homotopy(R*T, R*Tnom);
  dg0WGS = wgs.dg0r;
  kEqWGS = exp(-dg0WGS/RT);
  rSRCH4 = k0SR*pX[5]*exp(-EaSR/RT) "From paper Piero Colonna & minus in the exponential correction";
  rWGS = k0WGS*pX[4] - k0WGS*(pX[3]*pX[2])/(pX[1]*kEqWGS) "From paper Piero Colonna";
end ChannelReactionRatesAir;
