within SOFCPoliMi.Components.HeatTransferModels.BaseModels;
partial model BaseDistributedHeatTransfer

  SOFCPoliMi.Interfaces.MultiHeatPort wall(n=n);

  parameter Integer n(min = 1)= 1 "Number of finite volumes";

  parameter Real nPipes "Number of parallel pipes";
  parameter Types.Area A "Total passage section available for the mass flow";
  parameter Types.Area S "Total surface involved in the heat exchange for a single pipe";
  parameter Types.Length Lc "Characteristic Lenght for the heat transfer";
  parameter Types.PerUnit kc = 1 "Corrective factor for heat tranfer";

  parameter Types.MassFlowRate w_nom "Nominal value of the mass flow rate involved in the thermal exchange (single pipe)";
  parameter Types.Pressure p_nom "Nominal value of pressure involved in the thermal exchange";

  Types.Temperature Tw[n] "Temperature of the wall for each finite volume";
  Types.HeatFlowRate Q_flow[n] "Heat flow entering through the wall of the finite volume";

  input Types.Temperature Tf[n] "Temperature of the gas in each finite volume";
  input Types.MassFlowRate w[n] "";
  input Types.Pressure p "outlet pressure of the pipe";

equation

  Tw = wall.T;
  Q_flow = wall.Q_flow;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BaseDistributedHeatTransfer;
