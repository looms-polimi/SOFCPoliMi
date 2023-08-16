within SOFCPoliMi;
package Utilities
  extends Modelica.Icons.UtilitiesPackage;

  function smoothSat "Smooth saturation function"
    // This function imposes limits (xmin and xmax) to a quantity and modify its
    // values in the range xmin + dxmin and xmax-dxmax to smooth its derivative
    // when approaching the new limits
    input Real x;
    input Real xmin "Lower bound of range where y = x";
    input Real xmax "Upper bound of range where y = x";
    input Real dxmin "Width of lower smoothing range";
    input Real dxmax=dxmin "Width of upper smoothing range";
    output Real y;
  algorithm
    y := if x < xmin + dxmin then
           xmin + dxmin - dxmin*(xmin + dxmin - x)/(dxmin^4 + (xmin + dxmin - x)^4)^0.25
         else if x > xmax - dxmax then
           xmax - dxmax + dxmax*(x - xmax + dxmax)/(dxmax^4 + (x - xmax + dxmax)^4)^0.25
         else x;
    annotation (smoothOrder=4, InLine=true,
                normallyConstant = xmin, normallyConstant = xmax,
                normallyConstant = dxmin, normallyConstant = dxmax);
  end smoothSat;

  annotation (
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})),
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));

end Utilities;
