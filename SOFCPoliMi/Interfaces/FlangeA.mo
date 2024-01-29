within SOFCPoliMi.Interfaces;
connector FlangeA "A-type flange connector for gas flows"
  extends Flange;
  annotation (
    Icon(graphics={  Ellipse(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(graphics={  Ellipse(lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}})}));
end FlangeA;
