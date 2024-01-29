within SOFCPoliMi.Components.HeatTransferModels;
model RadiativeHeatTransfer
  // Emissivity parameter
  parameter Types.Area S "";
  constant Types.Emissivity epsPen = 0.8 "";
  constant Types.Emissivity epsPlate = 0.1 "";
  constant Types.StephanBoltzmannConst sigma = Modelica.Constants.sigma "";
  Types.Power Q "";
  input Types.Temperature Tpen;
  input Types.Temperature Tplate;
equation
  Q = sigma*epsPen*epsPlate*S*(Tplate^4 - Tpen^4)/(epsPen + epsPlate - epsPen*epsPlate);
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end RadiativeHeatTransfer;
