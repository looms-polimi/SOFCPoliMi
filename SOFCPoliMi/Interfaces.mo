within SOFCPoliMi;
package Interfaces
  extends Modelica.Icons.InterfacesPackage;

  connector Flange "Generic flange connector for gas flows"
    parameter Integer nXi
      "Number of chemical species";
    parameter Integer nC
      "Number of tracking species";
    Types.Pressure p
      "Pressure";
    flow Types.MassFlowRate w
      "Mass flowrate";
    stream Types.SpecificEnthalpy h
      "Specific Enthalpy of the fluid close to the connection point if w < 0";
    stream Types.MassFraction Xi[nXi](each min = 0)
      "Independent mixture mass fractions m_i/m close to the connection point if w < 0";
    stream Types.MassFraction C[nC](each min = 0, each max = 1)
      "Properties c_i/m close to the connection point if w < 0";
  end Flange;

  connector FlangeA "A-type flange connector for gas flows"
    extends Flange;
    annotation (
      Icon(graphics={Ellipse(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
  Diagram(graphics={  Ellipse(lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
  end FlangeA;

  connector FlangeB "B-type flange connector for gas flows"
    extends Flange;
    annotation (
      Icon(graphics={  Ellipse( fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Ellipse( fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-42, 44}, {44, -40}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
  Diagram(graphics={  Ellipse(lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Ellipse(lineColor = {159, 159, 223}, fillColor = {255, 255, 255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-42, 44}, {44, -40}})}));
  end FlangeB;

  connector HeatPort "Thermal port for 1-dim. heat transfer (filled rectangular icon)"
    Types.Temperature T "Port temperature";
    flow Types.HeatFlowRate Q_flow "Heat flow rate (positive if flowing from outside into the component)";
    annotation (
      defaultComponentName = "port",
      Documentation(info = "<HTML>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>   
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <b>positive</b> heat flow
rate <b>Q_flow</b> is considered to flow <b>into</b> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <b>HeatPort_a</b> and
<b>HeatPort_b</b> are identical with the only exception of the different
<b>icon layout</b>.</p></HTML>
        "),
      Icon(graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0},
              fillPattern =                                                                                                           FillPattern.Solid)}),
      Diagram(graphics={  Rectangle(extent = {{-50, 50}, {50, -50}}, lineColor = {191, 0, 0}, fillColor = {191, 0, 0},
              fillPattern =                                                                                                          FillPattern.Solid), Text(extent = {{-120, 120}, {100, 60}}, lineColor = {191, 0, 0}, textString = "%name")}));
  end HeatPort;

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
      Icon(graphics={  Polygon( fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
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
    connector CurrentDensityInputSignal = input Types.CurrentDensity "'input Current Density' as connector" annotation (
      defaultComponentName = "u",
      Icon(graphics={  Polygon( fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.2)),
      Diagram(coordinateSystem(preserveAspectRatio = true, initialScale = 0.2, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {255, 255, 0}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid, points = {{0, 50}, {100, 0}, {0, -50}, {0, 50}}), Text(lineColor = {0, 0, 127}, extent = {{-10, 60}, {-10, 85}}, textString = "%name")}),
      Documentation(info = "<html>
<p>
Connector with one input signal of type Current Density.
</p>
</html>"));
    connector CurrentDensityOutputSignal = output Types.CurrentDensity "'output Current Density' as connector" annotation (
      defaultComponentName = "y",
      Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {255, 255, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {100, 0}, {-100, -100}, {-100, 100}})}),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics={  Polygon(lineColor = {255, 255, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-100, 50}, {0, 0}, {-100, -50}, {-100, 50}}), Text(lineColor = {0, 0, 127}, extent = {{30, 60}, {30, 110}}, textString = "%name")}),
      Documentation(info = "<html>
<p>
Connector with one output signal of type Current Density.
</p>
</html>"));
  end FuelCellInterfaces;
end Interfaces;
