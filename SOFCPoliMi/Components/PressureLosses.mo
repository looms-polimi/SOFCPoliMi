within SOFCPoliMi.Components;

model PressureLosses
  extends Modelica.Icons.Package;

  model LinearPressureLoss
  
    parameter Integer nX;
    
    parameter Types.Pressure dpNom;
    parameter Types.MassFlowRate wNom;
  
  Interfaces.FlangeA inlet(nXi = nX, nC = 0, w(min = 0)) annotation(
      Placement(transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}})));
  Interfaces.FlangeB outlet(nXi = nX, nC = 0, w(min = 0)) annotation(
      Placement(transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-20, -20}, {20, 20}})));
  equation
    
    inlet.Xi = zeros(nX); // Dummy
    inlet.h = 0; // Dummy
    
    inlet.w + outlet.w = 0;
    outlet.Xi = inStream(inlet.Xi);
    outlet.h = inStream(inlet.h);
    
    inlet.p - outlet.p = dpNom/wNom*inlet.w;

  annotation(
      Icon(graphics = {Ellipse(origin = {0, 50}, fillColor = {145, 145, 145}, fillPattern = FillPattern.Solid, extent = {{-20, 20}, {20, -20}}), Rectangle(origin = {0, 40}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-30, 10}, {30, -10}}), Rectangle(origin = {0, 25}, fillColor = {145, 145, 145}, fillPattern = FillPattern.Solid, extent = {{-10, -25}, {10, 25}}), Polygon(fillColor = {159, 159, 223}, fillPattern = FillPattern.Solid, points = {{-100, 100}, {0, 0}, {100, 100}, {100, -100}, {0, 0}, {-100, -100}, {-100, 100}})}));
end LinearPressureLoss;
equation

end PressureLosses;
