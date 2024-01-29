within SOFCPoliMi.Components.Initializers;
model HomotopyInitializerX
  replaceable model Medium =
      Media.MainClasses.SOS_CO2.SOS10ComponentsModelica                        constrainedby
    Media.BaseClasses.PartialMixture                                                                                          "Fluid model" annotation (
     choicesAllMatching = true);
  //parameter Integer nX = 5 "Number of chemical species";
  parameter Types.Pressure p_start "Initial value of pressure";
  parameter Types.MassFraction X_start[refFluid.nX] "Initial value of composition";
  parameter Types.Temperature T_start "Initial value of temperature";
  parameter Boolean computeEnthalpyCondensation = false;
  outer System system "System object";
  Types.SpecificEnthalpy h_start "Specific Enthalpy start value";
  Medium refFluid(p_start = p_start, T_start = T_start, X_start = X_start, computeEnthalpyCondensation = computeEnthalpyCondensation);
  SOFCPoliMi.Interfaces.FlangeA inlet(
    nXi=refFluid.nXi,
    nC=refFluid.nC,
    w(min=0)) annotation (Placement(
      visible=true,
      transformation(
        origin={-92,0},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={-100,0},
        extent={{-20,-20},{20,20}},
        rotation=0)));
  SOFCPoliMi.Interfaces.FlangeB outlet(
    nXi=refFluid.nXi,
    nC=refFluid.nC,
    w(max=0)) annotation (Placement(
      visible=true,
      transformation(
        origin={92,0},
        extent={{-10,-10},{10,10}},
        rotation=0),
      iconTransformation(
        origin={100,1.9984e-15},
        extent={{-20,-20},{20,20}},
        rotation=0)));
equation
  //assert(inlet.w > 0, "Mass flow rate going into the wrong direction in homotopy");
  inlet.p = outlet.p;
  inlet.w + outlet.w = 0;
  //inlet.h = inStream(outlet.h);
  h_start = refFluid.h;
  inlet.h = h_start;
  inlet.Xi = X_start[1:refFluid.nXi];
  outlet.h = inStream(inlet.h);
  //homotopy(inStream(inlet.h), h_start);
  outlet.Xi = homotopy(inStream(inlet.Xi), X_start[1:refFluid.nXi]);
  // Tracking composition mass balances
  inlet.C = inStream(outlet.C);
  inStream(inlet.C) = outlet.C;
  //Fluid model equations
  refFluid.p = p_start;
  refFluid.T = T_start;
  refFluid.Xi = X_start[1:refFluid.nXi];
  refFluid.C = inStream(inlet.C);
  annotation (
    Icon(graphics={  Ellipse(fillColor = {255, 170, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-100, 100}, {100, -100}}, textString = "H")}));
end HomotopyInitializerX;
