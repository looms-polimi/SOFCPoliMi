within SOFCPoliMi.Media.Utilities;
model MoleToMass

  extends SOFCPoliMi.Media.Utilities.FractionConverter;

  Types.MassFraction X[nX] "";
  input Types.MoleFraction Y[nX] "";

protected
  function MMmixEval "Function to evaluate mixture molar mass from mass fractions"
    input Real Y[:] "Mass fractions";
    output Real MMmix "Mixture molar mass";
  algorithm
    MMmix := Y*MM;
  annotation(Inline = true);
  end MMmixEval;

equation

  MMmix = MMmixEval(Y); // "Molar mass of the mixture";
  X = Y .* MM / MMmix "Definition of mass fractions";

end MoleToMass;
