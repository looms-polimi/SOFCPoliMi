within SOFCPoliMi.Components.FuelCell;
model OhmicResistancePEN
  // Parameters
  constant Types.Length tauAE "Anode electrode thickness";
  constant Types.Length tauCE "Cathode electrode thickness";
  constant Types.Length tauSE "Solid electrolyte thickness";
  // Nominal Values
  parameter Types.Temperature Tnom = 1200 "Nominal temperature PEN for resistance evaluation";
  // Variables
  Types.ResistanceArea R "PEN ohmic resistance";
  Types.SpecificConductivityLength sigmaAE "Anode ionic conductivity";
  Types.SpecificConductivityLength sigmaCE "Cathode ionic conductivity";
  Types.SpecificConductivityLength sigmaSE "Solid electrolyte electronic conductivity";
  input Types.Temperature T "PEN Temperature";
  parameter Types.SpecificConductivityLength preExpSE = 3.34e4;
equation
  R = tauAE/sigmaAE + tauCE/sigmaCE + tauSE/sigmaSE;
  sigmaAE = homotopy(95e6/T*exp(-1150/T), 95e6/Tnom*exp(-1150/Tnom));
  sigmaCE = homotopy(42e6/T*exp(-1200/T), 42e6/Tnom*exp(-1200/Tnom));
  sigmaSE = homotopy(preExpSE*exp(-10300/T), preExpSE*exp(-10300/Tnom));
end OhmicResistancePEN;
