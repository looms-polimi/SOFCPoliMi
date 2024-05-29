within SOFCPoliMi.Tests.Dymola;
model BenchmarkNonLinConcLossesDym
  extends Modelica.Icons.Example;
  ParametrizedModels.StackNonLinConcLosses stack(isOMC=false)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Components.Sources.SourceIdealMassFlow anodeSource(p_start( displayUnit = "Pa")= 27.5e5, T_start( displayUnit = "K")= 930, rho_start = 0.2, X_start = {0.36323032,0.63676965,0,0,0,0,0,0,0,0})  annotation (
    Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Components.Sources.SourceIdealMassFlow cathodeSource(p_start(displayUnit = "Pa") = 27.5e5, T_start( displayUnit = "K")= 930, X_start = {0.0014, 0, 0.8641, 0, 0,0,0, 0.1345, 0, 0}, rho_start = 0.2)  annotation (
    Placement(transformation(extent = {{-80, 14}, {-60, 34}})));
  Components.Sources.IdealSinkPressure cathodeSink(p(displayUnit = "Pa") = 27.5e5)  annotation (
    Placement(transformation(extent = {{40, 20}, {60, 40}})));
  Components.Sources.IdealSinkPressure anodeSink(p( displayUnit = "Pa")= 27.5e5)  annotation (
    Placement(transformation(extent = {{40, -40}, {60, -20}})));
  inner System system annotation (
    Placement(transformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant massFlowCathode(k = 1e-5*1.5*2.33)  annotation (
    Placement(transformation(origin = {-105, 45}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant compositionCathode[10](k = {0.0014, 0, 0.8641, 0, 0,0,0, 0.1345, 0, 0})  annotation (
    Placement(transformation(origin = {-105, 65}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant temperatureCathode(k = 930)  annotation (
    Placement(transformation(origin = {-105, 85}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant massFlowAnode(k = 1e-5*1.5)  annotation (
    Placement(transformation(origin = {-133, -35}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant temperatureAnode(k = 930)  annotation (
    Placement(transformation(origin = {-133, 5}, extent = {{-5, -5}, {5, 5}})));
Components.Sources.ConcentrationRamp compositionAnode(nX = 10,
    Xstart={0.36323032,0.63676965,0,0,0,0,0,0,0,0},                                                              Xend = {0.3785, 0.0128, 0.5450, 0, 0.0637, 0, 0, 0, 0, 0}, tstart = 1,
    tend=100)                                                                                                                                                                                        annotation (
    Placement(transformation(origin = {-133, -15}, extent = {{-5, -5}, {5, 5}})));
Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}})));
Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent annotation (
    Placement(transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
Modelica.Blocks.Sources.Constant Qloss(k = 0)  annotation (
    Placement(transformation(origin = {-15, 35}, extent = {{-5, -5}, {5, 5}})));
Modelica.Blocks.Sources.TimeTable elCurrentTable(table=[0,0.001; 100,0.001; 10000,
        iTot])                                                                       annotation (
    Placement(transformation(origin={110,0},      extent={{10,-10},{-10,10}})));

parameter Types.ElCurrent iTot = 45;
equation
connect(massFlowCathode.y, cathodeSource.w) annotation (
    Line(points={{-99.5,45},{-78,45},{-78,28}},       color = {0, 0, 127}));
connect(temperatureCathode.y, cathodeSource.Tset) annotation (
    Line(points={{-99.5,85},{-66,85},{-66,28}},       color = {0, 0, 127}));
connect(temperatureAnode.y, anodeSource.Tset) annotation (
    Line(points={{-127.5,5},{-66,5},{-66,-12}},          color = {0, 0, 127}));
connect(massFlowAnode.y, anodeSource.w) annotation (
    Line(points={{-127.5,-35},{-89.5,-35},{-89.5,-6},{-78,-6},{-78,-12}},          color = {0, 0, 127}));
connect(compositionAnode.y, anodeSource.X) annotation (
    Line(points={{-127.5,-15},{-114,-15},{-114,0},{-72,0},{-72,-12}},            color = {0, 0, 127}, thickness = 0.5));
connect(compositionCathode.y, cathodeSource.X) annotation (
    Line(points={{-99.5,65},{-72,65},{-72,28}},       color = {0, 0, 127}, thickness = 0.5));
  connect(stack.anodePin, ground.p)
    annotation (Line(points={{0,-18},{0,-60}}, color={0,0,255}));
  connect(signalCurrent.n, stack.anodePin) annotation (Line(points={{76,-10},
          {76,-46},{0,-46},{0,-18}}, color={0,0,255}));
  connect(stack.anodeOut, anodeSink.flange)
    annotation (Line(points={{20,-12},{50,-12},{50,-30}}));
  connect(stack.cathodeOut, cathodeSink.flange)
    annotation (Line(points={{20,12},{50,12},{50,30}}));
  connect(stack.cathodePin, signalCurrent.p) annotation (Line(points={{0,18},
          {0,60},{76,60},{76,10}}, color={0,0,255}));
  connect(Qloss.y, stack.Qloss)
    annotation (Line(points={{-9.5,35},{10,35},{10,16}}, color={0,0,127}));
  connect(anodeSource.flange, stack.anodeIn)
    annotation (Line(points={{-60,-16},{-40,-16},{-40,-12},{-20,-12}}));
  connect(cathodeSource.flange, stack.cathodeIn)
    annotation (Line(points={{-60,24},{-44,24},{-44,12},{-20,12}}));
  connect(signalCurrent.i, elCurrentTable.y)
    annotation (Line(points={{88,0},{99,0}}, color={0,0,127}));
annotation (
    Diagram(coordinateSystem(extent = {{-140, 100}, {120, -100}})),
  experiment(StopTime = 10000, StartTime = 0, Tolerance = 1e-06, Interval = 20),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeNonlinearTearing=40000",
  __OpenModelica_simulationFlags(ils = "100", lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end BenchmarkNonLinConcLossesDym;
