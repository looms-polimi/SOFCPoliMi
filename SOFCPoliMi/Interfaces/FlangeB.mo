within SOFCPoliMi.Interfaces;
connector FlangeB "B-type flange connector for gas flows"
  extends Flange;
  annotation (
    Icon(graphics={  Ellipse(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Ellipse(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-42, 44}, {44, -40}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
    Diagram(graphics={  Ellipse(lineColor = {159, 159, 223}, fillColor = {159, 159, 223}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Ellipse(lineColor = {159, 159, 223}, fillColor = {255, 255, 255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-42, 44}, {44, -40}})}));
end FlangeB;
