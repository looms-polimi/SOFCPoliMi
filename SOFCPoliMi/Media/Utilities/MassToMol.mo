within SOFCPoliMi.Media.Utilities;
model MassToMol

  extends SOFCPoliMi.Media.Utilities.FractionConverter;

  input Types.MassFraction X[nX] "";
  Types.MoleFraction Y[nX] "";

protected
  function MMmixEval "Function to evaluate mixture molar mass from mass fractions"
    input Real X[:] "Mass fractions";
    output Real MMmix "Mixture molar mass";
  algorithm
    MMmix := 1/(X*invMM);
  annotation(Inline = true);
  end MMmixEval;

equation

  MMmix = MMmixEval(X); // "Molar mass of the mixture";

  Y = X ./ MM * MMmix "Definition of molar fractions";

end MassToMol;
