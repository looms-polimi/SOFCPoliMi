within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
function EnergyOfInteraction
// CUSSLER, Edward Lansing; CUSSLER, Edward Lansing. Diffusion: mass transfer in fluid systems. Cambridge university press, 2009.
// (pagg. 119-122)

  input Integer species1;
  input Integer species2;
  output Types.EnergyOfInteraction epsilon;

protected
  Types.EnergyOfInteraction speciesEpsilon[10] = {809.1, 59.7, 195.2, 91.7, 148.6, 215.7, 237.1, 106.7, 71.4, 93.3};
  // H2O, H2, CO2, CO, CH4, C2H6, C3H8, O2, N2, Ar

algorithm

  epsilon := sqrt(speciesEpsilon[species1]*speciesEpsilon[species2]);

  annotation(Inline = true);
end EnergyOfInteraction;
