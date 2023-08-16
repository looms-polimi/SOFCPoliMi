within SOFCPoliMi.Media.Utilities;
model ComputeIdealGasCoefficientsCO2
  extends
    SOFCPoliMi.Media.Utilities.ComputeIdealGasCoefficients(ord_cp = 3,
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2);
annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
end ComputeIdealGasCoefficientsCO2;
