within SOFCPoliMi.Media.Utilities;
model ComputeIdealGasCoefficientsC5H12
  extends
    SOFCPoliMi.Media.Utilities.ComputeIdealGasCoefficients(ord_cp = 3,
    redeclare package Medium =
        Modelica.Media.IdealGases.SingleGases.C5H12_n_pentane);
annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
end ComputeIdealGasCoefficientsC5H12;
