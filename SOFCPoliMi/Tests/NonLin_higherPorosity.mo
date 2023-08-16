within SOFCPoliMi.Tests;
model NonLin_higherPorosity
  extends SOS_CO2_NON_LIN_CONC_LOSSES(
    porosity = 0.25);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end NonLin_higherPorosity;
