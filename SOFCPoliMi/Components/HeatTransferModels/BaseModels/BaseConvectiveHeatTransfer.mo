within SOFCPoliMi.Components.HeatTransferModels.BaseModels;
partial model BaseConvectiveHeatTransfer
  extends BaseDistributedHeatTransfer;

  parameter Types.CoefficientOfHeatTransfer gamma_nom "Nominal value of the heat transfert coefficient";
  Types.CoefficientOfHeatTransfer gamma[n](each start=gamma_nom) "Coefficient of convective heat exchange (start = fill(gamma_approx, n))";

equation
  Q_flow = gamma.*(kc*S*(Tw-Tf)*nPipes);
end BaseConvectiveHeatTransfer;
