within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
function KnudsenEffDiffCoeff
  input Real poreDiam;
  input Integer species;
  input Types.Temperature T;
  input Real ratioPorTor;
  output Real DkEff;
protected
  constant Types.SpecificHeatCapacityMol R = Modelica.Constants.R "Universal gas constant per unit mol";
  constant Real pi = Modelica.Constants.pi;
  constant Types.MolarMass MM[10] = Utilities.ConstantsFluidAndSolid.MM "";
  //   constant Real ratioPorTor = Media.ConstantsFluidAndSolid.ratioPorTor "";
algorithm
  DkEff := ratioPorTor*poreDiam/3*sqrt(8*R*T/pi/MM[species]);
  annotation (
    Inline = true);
end KnudsenEffDiffCoeff;
