within SOFCPoliMi.Tests;
model SOS_CO2_ComparisonNonLinVSLinConcLosses
  extends Modelica.Icons.Example;
  parameter Real porosity = 0.35;
  parameter Real iTot = 45;

  SOFCPoliMi.Tests.SOS_CO2_NON_LIN_CONC_LOSSES testNONLIN(porosity=porosity,
      iTot=iTot);
  SOFCPoliMi.Tests.SOS_CO2_LIN_CONC_LOSSES testLIN(porosity=porosity, iTot=(
        iTot + 1));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=40000000, __Dymola_Algorithm="Dassl"));
end SOS_CO2_ComparisonNonLinVSLinConcLosses;
