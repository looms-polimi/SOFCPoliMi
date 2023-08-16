within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
package ConstantsFluidAndSolid
  extends Modelica.Icons.MaterialPropertiesPackage;
  // FLUID
  // H2O, H2, CO2, CO, CH4, C2H6, C3H8, O2, N2, Ar

  // Molar masses of the species of the Fuel Cell fluid mix
  constant Types.MolarMass MM[10] = {
   Modelica.Media.IdealGases.Common.SingleGasesData.H2O.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.H2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.CO2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.CO.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.CH4.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.C2H6.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.C3H8.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.O2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.N2.MM,
   Modelica.Media.IdealGases.Common.SingleGasesData.Ar.MM};


  // Collision diameters between H2, H2O, O2 and species i
  // CUSSLER, Edward Lansing; CUSSLER, Edward Lansing. Diffusion: mass transfer in fluid systems. Cambridge university press, 2009.
  // (pagg. 119-122)
  // Obtained through function CollisionDiameter
  constant Types.Length collDiam_H2_i[10] = {2.734,2.827,3.384,3.2585,3.2925,3.635,3.7525,3.147,3.3125,3.1845}*1e-10 "";
  constant Types.Length collDiam_H2O_i[10] = {2.641,2.734,3.291,3.1655,3.1995,3.542,3.6595,3.054,3.2195,3.0915}*1e-10 "";
  constant Types.Length collDiam_O2_i[10] = {3.054,3.147,3.704,3.5785,3.6125,3.955,4.2925,3.467,3.6325,3.5045}*1e-10;


  // Energy of interaction between H2, H2O, O2 and species i
  // CUSSLER, Edward Lansing; CUSSLER, Edward Lansing. Diffusion: mass transfer in fluid systems. Cambridge university press, 2009.
  // (pagg. 119-122)
  // Obtained through function EnergyOfInteraction
  constant Types.EnergyOfInteraction eInteract_H2_i[10] = {219.78004,59.7,107.9511,73.9898,94.18822,113.47815,118.97424,79.81222,65.28844,74.6325};
  constant Types.EnergyOfInteraction eInteract_H2O_i[10] = {809.1,219.78004,397.41202,272.38663,346.74524,417.75934,437.9927,293.82132,240.35336,274.7527};
  constant Types.EnergyOfInteraction eInteract_O2_i[10] = {293.82132,79.81222,144.31854,98.91608,125.9191,151.70758,159.05524,106.7,87.28333,99.7753};



  // SOLID

  // Electrodes' porosity and tortuosity
  // (Donazzi, A quasi 2D model for the interpretation of
  // impedance and polarization of a planar solid oxide
  // fuel cell with interconnects)
  constant Real porosity = 0.35 "Porosity coefficient for anode and cathode electrodes";
  constant Real tortuosity = 1/porosity "Tortuosity coefficient for anode and cathode electrodes";
  constant Real ratioPorTor = porosity/tortuosity "Ratio between porosity and toruosity";

  // Electrodes and membrane: thickness
  constant Types.Length tauAE = 50e-6 "Anode electrode thickness";
  constant Types.Length tauCE = 50e-6 "Cathode electrode thickness";
  constant Types.Length tauSE = 150e-6 "Solid electrolyte thickness";

  // Pore diameter of the electrodes
  constant Types.Length Dpore = 0.3e-6 "Pore diameter in the electrodes";

end ConstantsFluidAndSolid;
