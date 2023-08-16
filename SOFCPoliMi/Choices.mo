within SOFCPoliMi;
package Choices
  extends Modelica.Icons.TypesPackage;

  package Init "Options for initialisation"
    type Options = enumeration(
        noInit "No initial equations",
        fixedState "Fixed initial state variables",
        steadyState "Steady-state initialization")
      "Type, constants and menu choices to select the initialisation options";
  end Init;

  package FlowReversal "Options for flow reversal support"
    type Options = enumeration(
        fullFlowReversal "Full flow reversal support",
        smallFlowReversal "Small flow reversal allowed (approx. model)",
        noFlowReversal "Flow reversal is not allowed")
      "Type, constants and menu choices to select the flow reversal support options";
  end FlowReversal;

  package System
    type Dynamics = enumeration(
        DynamicFreeInitial
          "DynamicFreeInitial -- Dynamic balance, Initial guess value",
        FixedInitial "FixedInitial -- Dynamic balance, Initial value fixed",
        SteadyStateInitial
          "SteadyStateInitial -- Dynamic balance, Steady state initial with guess value",
        SteadyState "SteadyState -- Steady state balance, Initial guess value")
      "Enumeration to define definition of balance equations";

  end System;

end Choices;
