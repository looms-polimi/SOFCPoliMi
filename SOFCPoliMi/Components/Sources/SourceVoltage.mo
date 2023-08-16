within SOFCPoliMi.Components.Sources;
model SourceVoltage
  parameter Types.ElPotential V0;
  Interfaces.FuelCellInterfaces.ElPin elPin annotation (Placement(
        transformation(extent={{-8,-10},{12,10}}), iconTransformation(extent={{-8,
            -10},{12,10}})));

equation

  elPin.v = V0;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={244,125,35},
          fillColor={244,125,35},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-18,20},{22,-20}},
          lineColor={0,0,0},
          fillColor={244,125,35},
          fillPattern=FillPattern.None)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end SourceVoltage;
