within SOFCPoliMi;
package Choices
  extends Modelica.Icons.TypesPackage;

  package Init "Options for initialisation"
    type Options = enumeration(noInit "No initial equations", fixedState "Fixed initial state variables", steadyState "Steady-state initialization") "Type, constants and menu choices to select the initialisation options";
  end Init;
end Choices;
