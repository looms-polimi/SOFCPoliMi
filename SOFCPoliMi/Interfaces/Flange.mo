within SOFCPoliMi.Interfaces;
connector Flange "Generic flange connector for gas flows"
  parameter Integer nXi "Number of chemical species";
  parameter Integer nC "Number of tracking species";
  Types.Pressure p "Pressure";
  flow Types.MassFlowRate w "Mass flowrate";
  stream Types.SpecificEnthalpy h "Specific Enthalpy of the fluid close to the connection point if w < 0";
  stream Types.MassFraction Xi[nXi](each min = 0) "Independent mixture mass fractions m_i/m close to the connection point if w < 0";
  stream Types.MassFraction C[nC](each min = 0, each max = 1) "Properties c_i/m close to the connection point if w < 0";
end Flange;
