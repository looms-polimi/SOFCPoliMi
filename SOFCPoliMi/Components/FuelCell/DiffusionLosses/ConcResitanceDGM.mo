within SOFCPoliMi.Components.FuelCell.DiffusionLosses;
model ConcResitanceDGM
  // Dusty Gas Model equivalent diffusion resistance
  // Fu, Y. et al. (2015) ‘Multicomponent Gas Diffusion in Porous Electrodes’, Journal of The Electrochemical Society, 162(6), p. F613.

  // Considered Species: H2O, H2, CO2, CO, CH4, O2, N2, Ar

  // Constants
  constant Types.Length collDiam_H2_i[nX] = Utilities.ConstantsFluidAndSolid.collDiam_H2_i "Collision diameter between H2 and species i";
  constant Types.Length collDiam_H2O_i[nX] = Utilities.ConstantsFluidAndSolid.collDiam_H2O_i "Collision diameter between H2O and species i";
  constant Types.Length collDiam_O2_i[nX] = Utilities.ConstantsFluidAndSolid.collDiam_O2_i "Collision diameter between O2 and species i";
  constant Types.EnergyOfInteraction eInteract_H2_i[nX] = Utilities.ConstantsFluidAndSolid.eInteract_H2_i "Energy of interaction between H2 and species i";
  constant Types.EnergyOfInteraction eInteract_H2O_i[nX] = Utilities.ConstantsFluidAndSolid.eInteract_H2O_i "Energy of interaction between H2O and species i";
  constant Types.EnergyOfInteraction eInteract_O2_i[nX] = Utilities.ConstantsFluidAndSolid.eInteract_O2_i "Energy of interaction between O2 and species i";
  constant Modelica.Units.SI.FaradayConstant F = Modelica.Constants.F "Faraday constant C/mol";
  constant Integer nX = 10 "Number of species considered in the fluid mixture";
  constant Types.MolarMass MM[nX] = Utilities.ConstantsFluidAndSolid.MM "Molar masses vector";
  constant Types.Length Dpore = Utilities.ConstantsFluidAndSolid.Dpore "Pore diameter of the electrodes";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";
  constant Types.Length tauAE = Utilities.ConstantsFluidAndSolid.tauAE "Thickness of the anode electrode";
  constant Types.Length tauCE = Utilities.ConstantsFluidAndSolid.tauCE "Thickness of the cathode electrode";
  parameter Types.Temperature Tnom = 1100 "Nominal temperature for homotopy";


  // Electrodes' porosity and tortuosity
  // (Donazzi, A quasi 2D model for the interpretation of
  // impedance and polarization of a planar solid oxide
  // fuel cell with interconnects)
  parameter Real porosity = 0.35 "Porosity coefficient for anode and cathode electrodes";
  parameter Real tortuosity = 1/porosity "Tortuosity coefficient for anode and cathode electrodes";
  parameter Real ratioPorTor = porosity/tortuosity "Ratio between porosity and toruosity";


  // Variables
  Types.DiffusionResistance Rb "Diffusion equivalent resistance";
  Types.DiffusionResistance RbAnode "Diffusion equivalent resistance anode side";
  Types.DiffusionResistance RbCathode "Diffusion equivalent resistance cathode side";
  Types.DiffusionCoefficient D_H2_i[nX-2] "Effective diffusivity coefficient of H2 with respect to species CO2, CO, CH4, C2H6, C3H8, O2, N2 and Ar";
  Types.DiffusionCoefficient D_H2O_i[nX-2] "Effective diffusivity coefficient of H2O with respect to species CO2, CO, CH4, C2H6, C3H8, O2, N2 and Ar";
  Types.DiffusionCoefficient D_O2_i[nX-1] "Effective diffusivity coefficient of O2 with respect to species H2O, H2, CO2, CO, CH4, C2H6, C3H8, N2 and Ar";
  Types.DiffusionCoefficient D_H2_H2O "Effective diffusivity coefficient of H2 with respect to H2O";
  Types.DiffusionCoefficient D_H2_Rest "Effective diffusivity coefficient of H2 with respect to equivalent third component (CO2, CO, CH4, O2, N2 and Ar)";
  Types.DiffusionCoefficient D_H2O_Rest "Effective diffusivity coefficient of H2O with respect to equivalent third component (CO2, CO, CH4, O2, N2 and Ar)";
  Types.DiffusionCoefficient D_O2_Rest "Effective diffusivity coefficient of O2 with respect to equivalent third component (H2O, H2, CO2, CO, CH4, N2 and Ar";
  Types.DiffusionCoefficient Dk_H2 "Effective Knudsen diffusivity coefficient of H2";
  Types.DiffusionCoefficient Dk_H2O "Effective Knudsen diffusivity coefficient of H2O";
  Types.DiffusionCoefficient Dk_O2 "Effective Knudsen diffusivity coefficient of O2";
  input Types.Pressure pAnode "Absolute pressure anode channel side";
  input Types.Pressure pCathode "Absolute pressure cathode channel side";
  input Types.Pressure pXa[nX] "Partial pressures anode channel side";
  input Types.Pressure pXc[nX] "Partial pressures cathode channel side";
  input Types.Temperature T "Temperature PEN";
  Types.Temperature Temp "Temperature PEN";
//  Types.Pressure pAnode = 101325 "Absolute pressure anode channel side";
//  Types.Pressure pCathode = 101325 "Absolute pressure cathode channel side";
//  Types.Pressure pXa[nX] = {0.391244592,0.417575464,0.074964221,0.090470877,0.025744845,0,0,0} * pAnode "Partial pressures anode channel side";
//  Types.Pressure pXc[nX] = {0,0,0,0,0,0.204403479,0.795596521,0} * pCathode "Partial pressures cathode channel side";
//  Types.Temperature T = 900+273.15 "Temperature PEN";
  Types.MoleFraction Xa[nX] = pXa/pAnode "Bulk mole fraction species anode chaneel side";
  Types.MoleFraction Xc[nX] = pXc/pCathode "Bulk mole fraction species cathode chaneel side";
  Types.MoleFraction Xa_in_Rest[nX-2] = Xa[3:end]/Xa_Rest "Mole fractions with respect to anodic mix without H2 and H2O";
  Types.MoleFraction Xa_Rest = sum(Xa[3:end]) "Overall mole fraction of species other than H2 and H2O";
  Types.MoleFraction Xc_in_Rest[nX-1] = cat(1,Xc[1:7],Xc[9:10])/Xc_Rest "Mole fractions with respect to carhodic mix without O2";
  Types.MoleFraction Xc_Rest = 1-Xc[8] "Overall mole fraction of species other than O2";

  Types.CollisionIntegral collIntegral_H2_i[nX] "Collision integral between H2 and species i at temperature T";
  Types.CollisionIntegral collIntegral_H2O_i[nX] "Collision integral between H2O and species i at temperature T";
  Types.CollisionIntegral collIntegral_O2_i[nX] "Collision integral between O2 and species i at temperature T";

equation

  Temp = homotopy(T,Tnom);

  collIntegral_H2_i = {Utilities.CollisionIntegral(2,i,Temp/eInteract_H2_i[i]) for i in 1:nX};
  collIntegral_H2O_i = {Utilities.CollisionIntegral(1,i,Temp/eInteract_H2O_i[i]) for i in 1:nX};
  collIntegral_O2_i = {Utilities.CollisionIntegral(8,i,Temp/eInteract_O2_i[i]) for i in 1:nX};

  D_H2_H2O = Utilities.DiffusivityEffCoeff(Temp,pAnode,1,2,collDiam_H2_i[1],collIntegral_H2_i[1],ratioPorTor);

  D_H2_i = {Utilities.DiffusivityEffCoeff(Temp,pAnode,2,i,collDiam_H2_i[i],collIntegral_H2_i[i],ratioPorTor) for i in 3:nX};
  D_H2O_i = {Utilities.DiffusivityEffCoeff(Temp,pAnode,1,i,collDiam_H2O_i[i],collIntegral_H2O_i[i],ratioPorTor) for i in 3:nX};

  D_O2_i = {Utilities.DiffusivityEffCoeff(Temp,pCathode,8,i,collDiam_O2_i[i],collIntegral_O2_i[i],ratioPorTor) for i in {1,2,3,4,5,6,7,9,10}};

  //Blanc's law to obtain equivalent third component diffusivity coefficients for anodic and cathodic mixtures
  D_H2_Rest = sum(Xa_in_Rest[i]/D_H2_i[i] for i in 1:nX-2)^(-1);
  D_H2O_Rest = sum(Xa_in_Rest[i]/D_H2O_i[i] for i in 1:nX-2)^(-1);
  D_O2_Rest = sum(Xc_in_Rest[i]/D_O2_i[i] for i in 1:nX-1)^(-1);

  Dk_H2 = Utilities.KnudsenEffDiffCoeff(Dpore,2,Temp,ratioPorTor);
  Dk_H2O = Utilities.KnudsenEffDiffCoeff(Dpore,1,Temp,ratioPorTor);
  Dk_O2 = Utilities.KnudsenEffDiffCoeff(Dpore,8,Temp,ratioPorTor);

  RbAnode = (R*Temp/2/F)^2*tauAE*(1/pXa[1]*(1/Dk_H2O + 1/D_H2_H2O) +
    1/pXa[2]*(1/Dk_H2 + 1/D_H2_H2O) +
    Xa_Rest*(1/D_H2_Rest - 1/D_H2O_Rest) *
    (((D_H2_H2O - D_H2O_Rest)*D_H2_Rest)/((D_H2O_Rest - D_H2_Rest)*D_H2_H2O*pXa[1]) +
    ((D_H2_H2O - D_H2_Rest)*D_H2O_Rest)/((D_H2O_Rest - D_H2_Rest)*D_H2_H2O*pXa[2])));

  RbCathode=(R*Temp/4/F)^2*tauCE/pXc[8]*(1/Dk_O2+Xc_Rest/D_O2_Rest);

  Rb = RbAnode+RbCathode;

end ConcResitanceDGM;
