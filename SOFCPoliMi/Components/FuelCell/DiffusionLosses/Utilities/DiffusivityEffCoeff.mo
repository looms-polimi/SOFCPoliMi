within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
function DiffusivityEffCoeff
  input Types.Temperature T "";
  input Types.Pressure p "";
  input Integer species1 "";
  input Integer species2 "";
  input Types.Length collDiam "";
  input Types.CollisionIntegral collIntegral "";
  input Real ratioPorTor "";
  output Types.DiffusionCoefficient Deff_1_2 "";
protected
  constant Real coeff = 1.86e-3*101325*1e-4*10^(-3/2)*1e-20;
  // unit: "Pa.m4.kg^(1/2)/K^(3/2)/s/mol^(1/2)"
  constant Types.MolarMass MM[10] = Utilities.ConstantsFluidAndSolid.MM "";
  //   constant Real ratioPorTor = Media.ConstantsFluidAndSolid.ratioPorTor "";
algorithm
  Deff_1_2 := ratioPorTor*coeff*T^(3/2)*sqrt(1/MM[species1] + 1/MM[species2])/p/collDiam^2/collIntegral;
  annotation (
    Inline = true);
end DiffusivityEffCoeff;
