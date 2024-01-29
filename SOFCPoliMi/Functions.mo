within SOFCPoliMi;
package Functions
  extends Modelica.Icons.FunctionsPackage;

  function logBound
    extends Modelica.Icons.Function;
    input Real x;
    output Real y;
  protected
    parameter Real eps = 1e-9;
  algorithm
    y := log(max(x, eps));
    annotation (
      Inline = true);
  end logBound;

  function sqrtBound
    extends Modelica.Icons.Function;
    input Real x;
    output Real y;
  protected
    parameter Real eps = 1e-9;
  algorithm
    y := sqrt(max(x, eps));
    annotation (
      Inline = true);
  end sqrtBound;
end Functions;
