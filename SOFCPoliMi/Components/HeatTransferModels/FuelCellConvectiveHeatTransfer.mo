within SOFCPoliMi.Components.HeatTransferModels;
model FuelCellConvectiveHeatTransfer

  constant Types.Length Lc = 1 "Characteristic length for heat tranfer";
  constant Types.Area A = 1 "Channel section";
  constant Types.Area S = 1 "Heat transfer surface";

  // Start values
  parameter Types.Temperature T_start "";

  // Nominal Values
  parameter Types.CoefficientOfHeatTransfer alphaNom "";

  Types.CoefficientOfHeatTransfer alpha "";
  input Types.ThermalConductivity k "";
  input Types.NusseltNumber Nu "";
  Types.Power Q "";
  input Types.Temperature Tflow(start=T_start) "";
  input Types.Temperature Tw(start=T_start) "";

equation

  Q = S*alpha*(Tw-Tflow);  // Positive entering convention
  alpha = homotopy(Nu*k/Lc, alphaNom);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FuelCellConvectiveHeatTransfer;
