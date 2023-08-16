within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model ChannelReactionRatesAir
  // 1: H2O,
  // 2: H2,
  // 3: CO2,
  // 4: CO,
  // 5: CH4,
  // X: C2H6
  // Y: C3H8,
  // 6: O2,
  // 7: N2,
  // 8: Ar

  constant Types.MolarEnergy EaSR = 82e3 "Steam Reforming activation energy";
  constant Types.PreExponFactor k0SR = 4.274e-2 "Steam Reforming pre-exponential factor";
  constant Types.PreExponFactor k0WGS = 1e-2 "Water Gas Shift pre-exponential factor (high Enough to consider the reaction at equilibrium";
  constant Integer nX = 10 "Number of species in the mixture";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";

  // Start values
  parameter Types.Temperature T_start "";

  // Nomnial Values
  parameter Types.Temperature Tnom = 1200 "";

  // Variables
  Types.SpecificMolarGibbsFreeEnergy dg0WGS "Water Gas Shift Gibbs free energy of reaction";
  Types.PerUnit kEqWGS "Water Gas Shift equilibrium constant";
  input Types.Pressure pX[nX] "Partial pressure in the volume";
  Types.AreaSpecificReactionRate rSR "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rWGS "Water Gas Shift reaction rate";
  input Types.Temperature T(start = T_start) "Mixture temperature";
  Types.MolarEnergy RT "";
//   Types.PerUnit checkEQUI = (pX[3] * pX[2]) / (pX[1] * kEqWGS * pX[4]);

equation

  RT = homotopy(R * T, R * Tnom);
  dg0WGS = evaldg0WGS(RT / R);
  kEqWGS = exp(-dg0WGS / RT);
  rSR = k0SR * pX[5] * exp(-EaSR / RT) "From paper Piero Colonna & minus in the exponential correction";
  rWGS = k0WGS * pX[4] - k0WGS * (pX[3] * pX[2]) / (pX[1] * kEqWGS) "From paper Piero Colonna";

end ChannelReactionRatesAir;
