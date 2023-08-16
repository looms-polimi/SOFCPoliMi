within SOFCPoliMi.Media.Utilities;
partial model ComputeIdealGasCoefficients

  import Modelica.Units.SI;
  import Poly = Modelica.Math.Polynomials;
  import Modelica.Utilities.Streams.*;
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium;

  parameter Integer N = 50 "Number of intervals for the temperature discretization array from T_min to T_max";
  parameter Integer ord_cp = 3 "Order of the fitting polynomial";
  parameter SI.Pressure p = 1e5 "Pressure at which cp is evaluated";
  parameter SI.Temperature T_min = 280 "Lower bound of the temperature evaluation interval";
  parameter SI.Temperature T_max = 1500 "Upper bound of the temperature evaluation interval";
  constant SI.Time t0 = 1;

  // Computation
  parameter SI.Temperature T_data[:] = linspace(T_min, T_max, N) "Array with temperature entries for cp evaluation";
  parameter SI.SpecificHeatCapacity cp_data[:] = {Medium.specificHeatCapacityCp(Medium.setState_pTX(p,T_data[i])) for i in 1:N} "Array with the values of cp at every temperature contained in T_data";
  parameter Real coeff_cp[:] = Poly.fitting(T_data, cp_data, ord_cp) "Evaluation of the coefficients";

  SI.SpecificHeatCapacity cp "Specific heat capacity at constant pressure";
  SI.SpecificHeatCapacity cp_approx "Specific heat capacity at constant pressure evaluated through polynomial";
  SI.Temperature T "Temperature";

  String s;

equation

  T = T_min + (T_max - T_min)*time/t0 "Temperature to compute cp curve and compare cp with cp_approx";
  cp = Medium.specificHeatCapacityCp(Medium.setState_pTX(p,T)) "Actual cp";
  cp_approx = Poly.evaluate(coeff_cp,T) "Approximated cp";

algorithm
  // initial is true during initialization, false otherwise
  when (initial()) then
    s := "coeffs = {";
    for i in 1:ord_cp+1 loop
      s := s + String(coeff_cp[i], significantDigits = 14);
      if i < ord_cp+1 then
        s := s + ",";
      end if;
    end for;
    s := s + "},";
    print(s);
  end when;

  annotation (
    Documentation(info = "<html><head></head><body>Partial model to compute c_p coefficients for an ideal gas in the defined temperature range (T_min, T_max) and with the specified order of the polynomia ord_cp.</body></html>"));
end ComputeIdealGasCoefficients;
