within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
model NoReactions

  constant Integer nX = 8 "Number of species in the mixture";

  parameter Types.Temperature T_start "";
  parameter Types.Temperature Tnom = 1200 "";

  input Types.Pressure pX[nX] "Partial pressure in the volume";
  input Types.Temperature T(start = T_start) "Mixture temperature";

  Types.AreaSpecificReactionRate rSR "Steam reforming reaction rate";
  Types.AreaSpecificReactionRate rWGS "Water Gas Shift reaction rate";

equation

  rSR=0;
  rWGS=0;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end NoReactions;
