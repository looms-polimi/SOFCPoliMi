within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
function CollisionDiameter
// CUSSLER, Edward Lansing; CUSSLER, Edward Lansing. Diffusion: mass transfer in fluid systems. Cambridge university press, 2009.
// (pagg. 119-122)

  input Integer species1;
  input Integer species2;
  output Real collDiam;

protected
  Real speciesCollDiam[10] = {2.641, 2.827, 3.941, 3.69, 3.758, 4.443, 5.118, 3.467, 3.798, 3.542};
  // H2O, H2, CO2, CO, CH4, C2H6, C3H8, O2, N2, Ar

algorithm

  collDiam := (speciesCollDiam[species1] + speciesCollDiam[species2])/2;

  annotation(Inline = true);
end CollisionDiameter;
