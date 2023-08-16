within SOFCPoliMi.Components.FuelCell;
model CathodeChannel
  extends Components.FuelCell.BaseChannel(isAnode=false, alphaNom=290, Nu=5);
equation

  // Overall Mass balance
//   M = V * fluidOut.rho;
//   dM_dt = -V*rhoOut^2*(fluidOut.dv_dT*der(Tout)+fluidOut.dv_dp*der(pOut)+ fluidOut.dv_dX*der(Xout));
  dM_dt = wIn - wOut - wO2 "Overall mass balance";

  // Components Mass Balance
  M*der(Xout) = wIn*(Xin-Xout) + Xout*wO2 - {0,0,0,0,0,0,0,wO2,0,0};

  // Energy Balance
  dU_dt = wIn*hIn - wOut*hOut + wallPEN.Q_flow + wallPlate.Q_flow;

  wallPEN.Q_flow = htPEN.Q - wO2*hO2 "";
  wallPlate.Q_flow = htPlate.Q "";

end CathodeChannel;
