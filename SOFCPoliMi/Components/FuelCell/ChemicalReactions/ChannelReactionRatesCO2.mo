within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model ChannelReactionRatesCO2
  // 1: H2O,
  // 2: H2,
  // 3: CO2,
  // 4: CO,
  // 5: CH4,
  // 6: O2,
  // 7: N2,
  // 8: Ar

  constant Types.MolarEnergy EaSR = 100e3 "Steam Reforming activation energy";
  constant Types.MolarEnergy EaWGS = 60e3 "Water Gas Shift activation energy";
  constant Types.PreExponFactor k0SR = 0.000001 "Steam Reforming pre-exponential factor";
  constant Types.PreExponFactor k0WGS = 0.000001 "Water Gas Shift pre-exponential factor (high Enough to consider the reaction at equilibrium";
  constant Integer nX = 10 "Number of species in the mixture";
  constant Types.Pressure pRef = 101325 "Reference pressure";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";

  // Start values
  parameter Types.Temperature T_start "";

  // Nomnial Values
  parameter Types.Temperature Tnom = 1100 "";

  // Variables
  Types.SpecificMolarGibbsFreeEnergy dg0SR "Steam Reforming Gibbs free energy of reaction";
  Types.SpecificMolarGibbsFreeEnergy dg0WGS "Water Gas Shift Gibbs free energy of reaction";
  Types.PerUnit kEqSR "Steam Reforming equilibrium constant f(T)";
  Types.PerUnit kEqWGS "Water Gas Shift equilibrium constant f(T)";
  Types.PerUnit kPSR "Steam Reforming equilibrium constant f(pX)";
  Types.PerUnit kPWGS "Water Gas Shift equilibrium constant f(pX)";
  input Types.Pressure pX[nX] "Partial pressure in the volume";
  Types.Pressure pH2O = pX[1] "Partial pressure H2O";
  Types.Pressure pH2 = pX[2] "Partial pressure H2";
  Types.Pressure pCO2 = pX[3] "Partial pressure CO2";
  Types.Pressure pCO = pX[4] "Partial pressure CO";
  Types.Pressure pCH4 = pX[5] "Partial pressure CH4";
  Types.AreaSpecificReactionRate rSR "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rWGS "Water Gas Shift reaction rate";
  input Types.Temperature T(start = T_start) "Mixture temperature";
  Types.MolarEnergy RT "";

equation

  RT = homotopy(R*T, R*Tnom);

  dg0WGS = evaldg0WGS(RT/R);
  kEqWGS = exp(-dg0WGS/RT);
  kPWGS = (pH2*pCO2)/(pCO*pH2O);
  rWGS = k0WGS*exp(-EaWGS/RT)*pCO*pH2*(1-kPWGS/kEqWGS);


  dg0SR = evaldg0SR(RT/R);
  kEqSR = exp(-dg0SR/RT);
  kPSR = (pH2^3*pCO)/(pCH4*pH2O)/pRef^2;
  rSR = k0SR*exp(-EaSR/RT)*pCH4*pH2O*(1-kPSR/kEqSR);

end ChannelReactionRatesCO2;
