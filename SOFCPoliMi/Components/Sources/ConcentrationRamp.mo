within SOFCPoliMi.Components.Sources;
model ConcentrationRamp
  extends Modelica.Blocks.Interfaces.MO(final nout = nX);
  parameter Integer nX "Number of chemical species";
  parameter Modelica.Units.SI.MassFraction Xstart[nX] "Initial concentration";
  parameter Modelica.Units.SI.MassFraction Xend[nX] "Final concentration";
  parameter Modelica.Units.SI.Time tstart "Start time for the ramp";
  parameter Modelica.Units.SI.Time tend "End time for the ramp";
equation
  y = if time < tstart then Xstart elseif time < tend then Xend*(time - tstart)/(tend - tstart) + Xstart*(tend - time)/(tend - tstart) else Xend;
  assert(abs(sum(y) - 1) < 1e-6, "Concentrations are unbalanced");
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Line(points = {{-80, -74}, {-24, -74}, {26, 74}, {80, 74}}, thickness = 1)}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end ConcentrationRamp;
