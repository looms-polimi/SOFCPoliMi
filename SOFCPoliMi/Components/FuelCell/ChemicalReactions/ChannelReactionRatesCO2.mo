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
  constant Types.PreExponFactor k0SR = 0.0001 "Steam Reforming pre-exponential factor";
  constant Types.PreExponFactor k0WGS = 0.0001 "Water Gas Shift pre-exponential factor (high Enough to consider the reaction at equilibrium";
  constant Integer nX = 10 "Number of species in the mixture";
  constant Types.Pressure pRef = 101325 "Reference pressure";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";
  // Start values
  parameter Types.Temperature T_start "";
  // Nomnial Values
  parameter Types.Temperature Tnom = 1100 "";
  // Variables
  Types.SpecificMolarGibbsFreeEnergy dg0SRCH4 "Steam Reforming Gibbs free energy of reaction";
  Types.SpecificMolarGibbsFreeEnergy dg0SRC2H6 "Steam Reforming Gibbs free energy of reaction";
  Types.SpecificMolarGibbsFreeEnergy dg0SRC3H8 "Steam Reforming Gibbs free energy of reaction";
  Types.SpecificMolarGibbsFreeEnergy dg0WGS "Water Gas Shift Gibbs free energy of reaction";
  Types.PerUnit kEqSRCH4 "Steam Reforming equilibrium constant f(T)";
  Types.PerUnit kEqSRC2H6 "Steam Reforming equilibrium constant f(T)";
  Types.PerUnit kEqSRC3H8 "Steam Reforming equilibrium constant f(T)";
  Types.PerUnit kEqWGS "Water Gas Shift equilibrium constant f(T)";
  Types.PerUnit kPSRCH4 "Steam Reforming equilibrium constant f(pX)";
  Types.PerUnit kPSRC2H6 "Steam Reforming equilibrium constant f(pX)";
  Types.PerUnit kPSRC3H8 "Steam Reforming equilibrium constant f(pX)";
  Types.PerUnit kPWGS "Water Gas Shift equilibrium constant f(pX)";
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
  SOFCPoliMi.Components.FuelCell.ChemicalReactions.SRch4 srCH4(T=T, Tnom=Tnom);
  SOFCPoliMi.Components.FuelCell.ChemicalReactions.SRc2h6 srC2H6(T=T, Tnom=Tnom);
  SOFCPoliMi.Components.FuelCell.ChemicalReactions.SRc3h8 srC3H8(T=T, Tnom=Tnom);
  Real etaSRCH4 = kPSRCH4/kEqSRCH4;
  Real etaSRC2H6 = kPSRC2H6/kEqSRC2H6;
  Real etaSRC3H8 = kPSRC3H8/kEqSRC3H8;
  Real etaWGS = kPWGS/kEqWGS;
equation
  RT = homotopy(R*T, R*Tnom);
  dg0WGS = wgs.dg0r;
  //evaldg0WGS(RT/R); //
  kEqWGS = exp(-dg0WGS/RT);
  kPWGS = (pH2*pCO2)/(pCO*pH2O);
  rWGS = k0WGS*exp(-EaWGS/RT)*pCO*pH2O*(1 - kPWGS/kEqWGS);
  dg0SRCH4 = srCH4.dg0r;
  //evaldg0SR(RT/R); //
  kEqSRCH4 = exp(-dg0SRCH4/RT);
  kPSRCH4 = (pH2^3*pCO)/(pCH4*pH2O)/pRef^2;
  rSRCH4 = k0SR*exp(-EaSR/RT)*pCH4*pH2O*(1 - kPSRCH4/kEqSRCH4);
  dg0SRC2H6 = srC2H6.dg0r;
  //evaldg0SR(RT/R);
  kEqSRC2H6 = exp(-dg0SRC2H6/RT);
  kPSRC2H6 = (pH2^5*pCO^2)/(pC2H6*pH2O^2)/pRef^4;
  rSRC2H6 = k0SR*exp(-EaSR/RT)*pC2H6*pH2O*(1 - kPSRC2H6/kEqSRC2H6);
  dg0SRC3H8 = srC3H8.dg0r;
  //evaldg0SR(RT/R);
  kEqSRC3H8 = exp(-dg0SRC3H8/RT);
  kPSRC3H8 = (pH2^7*pCO^3)/(pC3H8*pH2O^3)/pRef^6;
  rSRC3H8 = k0SR*exp(-EaSR/RT)*pC3H8*pH2O*(1 - kPSRC3H8/kEqSRC3H8);
end ChannelReactionRatesCO2;
