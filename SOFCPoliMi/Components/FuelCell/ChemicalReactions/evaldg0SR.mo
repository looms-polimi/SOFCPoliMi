within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
function evaldg0SR "From exercise session #5 Fundamentals of Chemical Processes: valid for 600<T<1500 K"

  input Types.Temperature T;
  output Types.SpecificMolarGibbsFreeEnergy dg0;

algorithm

  dg0 := 4.1868*(53717-60.25*T);
annotation(Inline = true);
end evaldg0SR;
