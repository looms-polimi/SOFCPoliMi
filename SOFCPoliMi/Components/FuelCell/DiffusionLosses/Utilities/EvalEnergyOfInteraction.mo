within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
model EvalEnergyOfInteraction

  // H2O, H2, CO2, CO, CH4, C2H6, C3H8, O2, N2, Ar

  constant Integer nX = 10 "";

  Real eInteract_H2_i[nX] "";
  Real eInteract_H2O_i[nX] "";
  Real eInteract_O2_i[nX] "";

equation

  for i in 1:nX loop
    eInteract_H2_i[i] = EnergyOfInteraction(2,i);
    eInteract_H2O_i[i] = EnergyOfInteraction(1,i);
    eInteract_O2_i[i] = EnergyOfInteraction(8,i);
  end for;


end EvalEnergyOfInteraction;
