within SOFCPoliMi.Components.FuelCell.DiffusionLosses.Utilities;
model EvalCollDiameters

  // H2O, H2, CO2, CO, CH4, C2H6, C3H8, O2, N2, Ar

  constant Integer nX = 10 "";

  Real collDiam_H2_i[nX] "";
  Real collDiam_H2O_i[nX] "";
  Real collDiam_O2_i[nX] "";

equation

  for i in 1:nX loop
    collDiam_H2_i[i] = CollisionDiameter(2,i);
    collDiam_H2O_i[i] = CollisionDiameter(1,i);
    collDiam_O2_i[i] = CollisionDiameter(8,i);
  end for;

end EvalCollDiameters;
