within SOFCPoliMi.Media.BaseClasses;
partial model IdealMixture
  extends PartialMixture(nX = 8, nC = 0, Xi_start = X_start[1:nXi], nXi = if reducedX then nX - 1 else nX, rho(start = rho_start), computeEnthalpyCondensation = false, computeTransport = false, computeEntropy = false, du_dT(nominal = 1000), du_dX(each nominal = 1e6), dv_dp(nominal = 1e-8), dv_dT(nominal = 1e-4), dv_dX(each nominal = 0.1));
  // Water
  replaceable package MediumH2O = Modelica.Media.Water.StandardWater;
  import Modelica.Fluid.Utilities.regStep;
  //Options
  parameter Boolean anodicFlow = false "";
  parameter Boolean cathodicFlow = false "";
  parameter Boolean reducedX = false;
  parameter Integer posCond = 1 "Position of H2O in the array";
  parameter Integer posOxygen = 3 "Position of O2 in the array";
  // Constants
  constant Integer ord_cp = 3 "Order of cp polynomials";
  constant Integer ord_cp_cond = 3 "order of the polynomial ideal cp(T)";
  constant Real cp_coeff[nX, ord_cp + 1] "Coefficients for ideal cp evaluation of each species of the mixture";
  parameter Types.TemperatureDifference dT_smooth = 1 "Smoothing temperature interval for cp_cond calculation";
  constant Types.SpecificEnthalpy Hf[nX] "Specific enthalpies of formation of the species";
  constant Types.MolarMass MM[nX] "Molar masses of the species";
  final constant Types.InvMolarMass invMM[nX] = ones(nX)./MM "Elementwise inverse of the molar mass vector to evaluate MMmix";
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";
  constant Types.Pressure p0 = 1e5 "Reference pressure";
  constant Types.Temperature T0 = 298.15 "Reference temperature for enthalpy calculation";
  constant Types.MoleFraction eps = 1e-9 "small constant to avoid 'log(0)' when a gas component molar mass is zero";
  // Parameters
  //   parameter Types.PerUnit X_start[nX] "";
  //   final parameter Integer dominantSpecies = integer(Modelica.Math.Vectors.find(max(X_start), X_start));
  //   parameter Types.Pressure p_start "";
  parameter Types.Density rho_start = MM[dominantSpecies]*p_start/(R*T_start) "";
  //   parameter Types.Temperature T_start "";
  parameter Types.SpecificVolume v_start = 1/rho_start "";
  parameter Types.MolarMass MMmix_start = MM[dominantSpecies];
  //Variables
  Types.SpecificHeatCapacity cp_cond "Equivalent cp to evaluate condensation enthalpy";
  Real cp_cond_coeff[ord_cp_cond + 1] "Coefficients for the evaluation of cp_cond";
  Types.SpecificHeatCapacity cp_species[nX] "Cp of each species of the mixture";
  Types.SpecificEnthalpy h_cond "Water enthalpy of condensation";
  Types.SpecificEnthalpy h_species[nX] "Enthalpy of each component of the mixture referred to standard conditions";
  Types.MolarMass MMmix(start = MMmix_start) "Molar mass of the mixture";
  Types.SpecificEntropy s_species[nX] "";
  Types.SpecificVolume v(start = v_start) "Specific volume of rhe mixture" annotation (
    __OpenModelica_tearingSelect = TearingSelect.always);
  Types.MoleFraction Y[nX] "Molar fractions of the components of the mixture";
  Types.SpecificEnthalpy hTemperature[nX];
  Types.SpecificEnthalpy hPROVATEMP;
protected
  function MMmixEval "Function to evaluate mixture molar mass from mass fractions"
    input Types.MassFraction X[:] "Mass fractions";
    output Types.MolarMass MMmix "Mixture molar mass";
  algorithm
    MMmix := 1/(X*invMM);
    annotation (
      Inline = true);
  end MMmixEval;

  function cp_T "Function to evaluate cp given cp coefficients and T"
    input Types.Temperature T "Temperature";
    input Real coeff[ord_cp + 1] "cp coefficients";
    output Types.SpecificHeatCapacity cp "Specific heat capacity at constant pressure";
  algorithm
    cp := coeff[4] + T*(coeff[3] + T*(coeff[2] + T*coeff[1]));
    annotation (
      Inline = true);
  end cp_T;

  function h_T "Function to evaluate mixture enthalpy from cp coefficients and T"
    input Types.Temperature T "Temperature";
    input Real coeff[ord_cp + 1] "cp coefficients";
    output Types.SpecificEnthalpy h "Enthalpy";
  algorithm
    h := T*(coeff[4] + T*(coeff[3]/2 + T*(coeff[2]/3 + T*coeff[1]/4)));
    annotation (
      Inline = true);
  end h_T;

  function s_T
    input Types.Temperature T;
    input Real coeff[4];
    output Types.SpecificEntropy s;
  algorithm
    s := coeff[4]*log(T) + T*(coeff[3] + T*(coeff[2]/2 + T*coeff[1]/3));
    annotation (
      Inline = true);
  end s_T;
equation
  Xi = X[1:nXi];
  if nX > 1 then
    if reducedX then
      X[nX] = 1 - sum(Xi);
    end if;
  end if;
  MMmix = MMmixEval(X);
  // "Molar mass of the mixture"; 0.0197049
  Y = X./MM*MMmix "Definition of molar fractions";
  p/rho = R/MMmix*T "Ideal gas equation";
  v = 1/rho "Specific volume definition";
  for i in 1:nX loop
    cp_species[i] = cp_T(T, cp_coeff[i]) "Cp of every species";
    hTemperature[i] = h_T(T, cp_coeff[i]) - h_T(T0, cp_coeff[i]);
    //
    h_species[i] = Hf[i] + h_T(T, cp_coeff[i]) - h_T(T0, cp_coeff[i]) "Enthalpy of every species";
    s_species[i] = s_T(T, cp_coeff[i]) - s_T(T0, cp_coeff[i]) - (R*log(p/p0))/MM[i] "Ideal specific entropy of each component in unit mass";
  end for;
  if computeEnthalpyCondensation then
    h_cond = regStep(T - MediumH2O.saturationTemperature(p*Y[posCond]), 0, h_T(T, cp_cond_coeff) - h_T(MediumH2O.saturationTemperature(p*Y[posCond]), cp_cond_coeff), dT_smooth);
    cp_cond = regStep(T - MediumH2O.saturationTemperature(p*Y[posCond]), 0, cp_T(T, cp_cond_coeff), dT_smooth);
    cp = cp_species*X + cp_cond "Mixture cp";
    h = h_species*X + h_cond "Mixture enthalpy";
    hPROVATEMP = hTemperature*X;
  else
    cp_cond = 0;
    h_cond = 0;
    cp = cp_species*X "Mixture cp";
    h = h_species*X "Mixture enthalpy";
    hPROVATEMP = hTemperature*X;
  end if;
  s = X*s_species + (R*sum(Y[i]*log(Y[i] + eps) for i in 1:nX))/MMmix;
  u = h - p*v "Specific energy definition";
  LHVmix = X*LHV;
  du_dT = cp - R/MMmix "Partial derivative definition";
  du_dp = 0 "Partial derivative definition";
  du_dX = h_species + R*T*MM/MMmix^2 "Partial derivative definition";
  dv_dT = R/MMmix/p "Partial derivative definition";
  dv_dp = -v/p;
  //-R/MMmix*T/p^2 "Partial derivative definition";
  dv_dX = -R*T/p*MM/MMmix^2 "Partial derivative definition";
  cp_cond_coeff[1] = 0.0053829910 + (p/1e5)*(-0.0002456170 + 0.0000035939*(p/1e5));
  cp_cond_coeff[2] = -4.6150453224 + (p/1e5)*(0.2105769035 - 0.0030812248*(p/1e5));
  cp_cond_coeff[3] = 1331.1529357756 + (p/1e5)*(-60.7383121266 + 0.8887413046*(p/1e5));
  cp_cond_coeff[4] = -129029.8397929920 + (p/1e5)*(5887.4186972587 - 86.1464863001*(p/1e5)) + 40;
  //   if anodicFlow then
  //     k =(Y[5]*(-1.869e-3+8.727e-5*T+1.179e-7*T^2-3.614e-11*T^3) + Y[4]*(5.067e-4+9.125e-5*T-3.524e-8*T^2+8.199e-12*T^3) + Y[3]*(-7.215e-3+8.015e-5*T+5.477e-9*T^2-1.053e-11*T^3) + Y[2]*(8.099e-3+6.689e-4*T-4.158e-7*T^2+1.562e-10*T^3) + Y[1]*(7.341e-3-1.013e-5*T+1.801e-7*T^2-9.100e-11*T^3)) / (Y[5]+Y[4]+Y[3]+Y[2]+Y[1]); // Fuel side thermal conductivity if in Fuel Cell
  //   elseif cathodicFlow then
  //     k = -2.3795e-8*T^2.+1.0615385714e-4*T-4.9564142857e-3; // Oxygen side thermal conductivity if in Fuel Cell
  //   else
  //     k = 80e-6;
  //   end if;
  // cv and mu are not evaluated
  cv = 0;
  //   mu=0;
end IdealMixture;
