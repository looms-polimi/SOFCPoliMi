within SOFCPoliMi.Components.Sources;
model sinkCurrent
  parameter Types.ElCurrent i0;
  Interfaces.FuelCellInterfaces.ElPin elPin annotation (Placement(
        transformation(extent={{-8,-10},{12,10}}), iconTransformation(extent={{-8,
            -10},{12,10}})));
equation
  elPin.i = i0;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-18,20},{22,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.None)}), Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end sinkCurrent;
