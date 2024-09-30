within SOFCPoliMi.Components.FuelCell;
model AnodeChannel
  extends Components.FuelCell.BaseChannel(isAnode = true, alphaNom = 510, Nu = 2.7);
  replaceable model HOR = ChemicalReactions.HOR;
  replaceable model ReactionRates = Components.FuelCell.ChemicalReactions.ChannelReactionRatesCO2
    constrainedby Components.ChemicalReactions.BaseClasses.ChannelReactionRates;
  // Substances and Reaction Coefficients
  constant Real massStoichHOR[nX] = stoichHOR.*fluidIn.MM "";
  constant Real massStoichSR[nX] = stoichSR.*fluidIn.MM "";
  constant Real massStoichSRC2H6[nX] = stoichSRC2H6.*fluidIn.MM "";
  constant Real massStoichSRC3H8[nX] = stoichSRC3H8.*fluidIn.MM "";
  constant Real massStoichWGS[nX] = stoichWGS.*fluidIn.MM "";
  constant Types.PerUnit stoichHOR[nX] = {1, -1, 0, 0, 0, 0, 0, -0.5, 0, 0} "Stoichiometry Hidrogen Oxidation Reaction";
  constant Types.PerUnit stoichSR[nX] = {-1, 3, 0, 1, -1, 0, 0, 0, 0, 0} "Stoichiometry Steam reforming CH4";
  constant Types.PerUnit stoichSRC2H6[nX] = {-2, 5, 0, 2, 0, -1, 0, 0, 0, 0} "Stoichiometry Steam reforming C2H6";
  constant Types.PerUnit stoichSRC3H8[nX] = {-3, 7, 0, 3, 0, 0, -1, 0, 0, 0} "Stoichiometry Steam reforming C3H8";
  constant Types.PerUnit stoichWGS[nX] = {-1, 1, 1, -1, 0, 0, 0, 0, 0, 0} "Stoichiometry Water Gas Shift";
  Real checkmassStoichHOR[nX] = stoichHOR.*fluidIn.MM "";
  Real checkmassStoichSR[nX] = stoichSR.*fluidIn.MM "";
  Real checkmassStoichWGS[nX] = stoichWGS.*fluidIn.MM "";
  // Nominal values
  parameter Types.Temperature Tnom = 950;
  // rRates model
  HOR hor(T = htPEN.Tw, T_start = Tpen_start, Tnom = Tnom);
  ReactionRates rRates(T = Tout, pX = pX, T_start = T_start_out, Tnom = Tnom, nX = nX);
  // rRates channel reactions
  Types.AreaSpecificReactionRate rSRCH4 "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rSRC2H6 "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rSRC3H8 "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rWGS "Water gas shift reaction rate";
  Real consSRC1[nX];
  Real consSRC2[nX];

equation
  // Reaction Rates assignment
  rSRCH4 = rRates.rSRCH4;
  rSRC2H6 = rRates.rSRC2H6;
  rSRC3H8 = rRates.rSRC3H8;
  rWGS = rRates.rWGS;
  // Overall Mass balance
  dM_dt = wIn - wOut + wO2 "Overall mass balance";
  // Components Mass Balance
  M*der(Xout) = wIn*(Xin - Xout) + S*(rHOR*massStoichHOR + rSRCH4*massStoichSR + rSRC2H6*massStoichSRC2H6 + rSRC3H8*massStoichSRC3H8 + rWGS*massStoichWGS) - Xout*wO2 + {0, 0, 0, 0, 0, 0, 0, wO2, 0, 0};

  consSRC1 = S*rSRCH4*massStoichSR;
  consSRC2 = S*rSRC2H6*massStoichSRC2H6;
  // Energy Balance
  dU_dt = wIn*hIn - wOut*hOut + wallPEN.Q_flow + wallPlate.Q_flow;
  wallPEN.Q_flow = htPEN.Q + wO2*hO2 + hor.dh0r*rHOR*S "";
  //
  wallPlate.Q_flow = htPlate.Q;
end AnodeChannel;
