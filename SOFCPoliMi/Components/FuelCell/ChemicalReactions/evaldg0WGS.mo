within SOFCPoliMi.Components.FuelCell.ChemicalReactions;
function evaldg0WGS "From exercise session #5 Fundamentals of Chemical Processes: valid for 600<T<1500 K"

  input Types.Temperature T;
  output Types.SpecificMolarGibbsFreeEnergy dg0;

algorithm

  dg0 := 4.1868*(-8514+7.71*T);
annotation(Inline = true);
end evaldg0WGS;
