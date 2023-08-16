within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
function CollisionIntegral
// CUSSLER, Edward Lansing; CUSSLER, Edward Lansing. Diffusion: mass transfer in fluid systems. Cambridge university press, 2009.
// (pagg. 119-122)

  input Integer species1 "";
  input Integer species2 "";
  input Types.EnergyOfInteraction energyOfInteraction "";
  output Types.CollisionIntegral collIntegral;

protected
  Integer i;
  Integer n = 36 "Number of interpolation points";
  Real p;
  constant Real table[36,2] = [
  0.3,2.662;
  0.4,2.318;
  0.5,2.066;
  0.6,1.877;
  0.7,1.729;
  0.8,1.612;
  0.9,1.517;
  1,1.439;
  1.1,1.375;
  1.3,1.273;
  1.5,1.198;
  1.6,1.167;
  1.65,1.153;
  1.75,1.128;
  1.85,1.105;
  1.95,1.084;
  2.1,1.057;
  2.3,1.026;
  2.5,0.9996;
  2.7,0.977;
  2.9,0.9576;
  3.3,0.9256;
  3.7,0.8998;
  3.9,0.8888;
  4,0.8836;
  4.2,0.874;
  4.4,0.8652;
  4.6,0.8568;
  4.8,0.8492;
  5,0.8422;
  7,0.7896;
  9,0.7556;
  20,0.664;
  60,0.5596;
  100,0.513;
  300,0.436];


algorithm

  assert(energyOfInteraction>=table[1,1], "Independent variable must be greater than or equal to "+String(table[1,1]));
  assert(energyOfInteraction<=table[n,1], "Independent variable must be less than or equal to "+String(table[n,1]));
  i := 1;
  while energyOfInteraction>=table[i+1,1] loop
    i := i + 1;
  end while;
  p := (energyOfInteraction-table[i,1])/(table[i+1,1]-table[i,1]);
  collIntegral := p*table[i+1,2]+(1-p)*table[i,2];

end CollisionIntegral;
