within SOFCPoliMi.Media.Utilities;
model ComputeIdealGasCoefficientsC4H10
  extends
    SOFCPoliMi.Media.Utilities.ComputeIdealGasCoefficients(ord_cp = 3,
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.C4H10_n_butane);
annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
end ComputeIdealGasCoefficientsC4H10;
