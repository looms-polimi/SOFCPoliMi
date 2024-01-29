within SOFCPoliMi.Interfaces;
package FuelCellInterfaces
  extends Modelica.Icons.Package;

  connector ElPin
    Types.ElPotential v "Potential at the pin";
    flow Types.ElCurrent i "Current flowing in the pin";
  equation

    annotation (
      Icon(graphics={  Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
      Diagram(graphics={  Rectangle(lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  end ElPin;

  connector PressureInputSignal = input Types.Pressure "'input Pressure' as connector" annotation (
    defaultComponentName = "u",
    Icon(graphics={  Polygon(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
    Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(lineColor = {0, 0, 127}, extent = {{-10, 60}, {-10, 85}}, textString = "%name")}),
    Documentation(info = "<html>
<p>
Connector with one input signal of type Pressure.
</p>
</html>"));
  connector PressureOutputSignal = output Types.Pressure "'output Pressure' as connector" annotation (
    defaultComponentName = "y",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {0, 0, 127}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(lineColor = {0, 0, 127}, extent = {{30, 60}, {30, 110}}, textString = "%name")}),
    Documentation(info = "<html>
<p>
Connector with one output signal of type Pressure.
</p>
</html>"));
  connector RHORInputSignal = input Types.AreaSpecificReactionRate "'input rHOR' as connector" annotation (
    defaultComponentName = "u",
    Icon(graphics={  Polygon(fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
    Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {0, 255, 0}, fillColor = {0, 255, 0}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(lineColor = {0, 0, 127}, extent = {{-10, 60}, {-10, 85}}, textString = "%name")}),
    Documentation(info = "<html>
<p>
Connector with one input signal of type AreaSpecificReactionRate.
</p>
</html>"));
  connector RHOROutputSignal = output Types.AreaSpecificReactionRate "'output rHOR' as connector" annotation (
    defaultComponentName = "y",
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {0, 255, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
    Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {0, 255, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(lineColor = {0, 0, 127}, extent = {{30, 60}, {30, 110}}, textString = "%name")}),
    Documentation(info = "<html>
<p>
Connector with one output signal of type AreaSpecificReactionRate.
</p>
</html>"));
end FuelCellInterfaces;
