within SOFCPoliMi.Components.FuelCell;
model CathodeChannel
  extends Components.FuelCell.BaseChannel(isAnode = false, alphaNom = 290, Nu = 1.2);
equation
  // Overall Mass balance
  dM_dt = wIn - wOut - wO2 "Overall mass balance";
  // Components Mass Balance
  M*der(Xout) = wIn*(Xin - Xout) + Xout*wO2 - {0, 0, 0, 0, 0, 0, 0, wO2, 0, 0};
  // Energy Balance
  dU_dt = wIn*hIn - wOut*hOut + wallPEN.Q_flow + wallPlate.Q_flow;
  wallPEN.Q_flow = htPEN.Q - wO2*hO2 "";
  wallPlate.Q_flow = htPlate.Q "";
end CathodeChannel;
