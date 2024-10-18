within SOFCPoliMi.Tests;
model BenchmarkCammarataIndex1
  extends Modelica.Icons.Example;
  ParametrizedModels.StackCammarataIndex1 stack
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Components.Sources.SourceIdealMassFlow anodeSource(p_start( displayUnit = "Pa")= 101325, T_start = 750 + 273.15, rho_start = 0.2, X_start = {0.36323032, 0.63676965, 0, 0, 0, 0, 0, 0, 0, 0})  annotation (
    Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Components.Sources.SourceIdealMassFlow cathodeSource(p_start(displayUnit = "Pa") = 101325, T_start = 750 + 273.15, X_start = {0.0, 0.0, 0.0, 0.0, 0, 0, 0.0, 0.205131882988603, 0.794868117011396, 0.0}, rho_start = 0.2)  annotation (
    Placement(transformation(extent = {{-80, 14}, {-60, 34}})));
  Components.Sources.IdealSinkPressure cathodeSink(p(displayUnit = "Pa") = 101325)  annotation (
    Placement(transformation(origin = {8, 4}, extent = {{40, 20}, {60, 40}})));
  Components.Sources.IdealSinkPressure anodeSink(p( displayUnit = "Pa")= 101325)  annotation (
    Placement(transformation(origin = {10, -2}, extent = {{40, -40}, {60, -20}})));
  inner System system annotation (
    Placement(transformation(origin = {70, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant massFlowCathode(k = 2.116452937599743e-5)  annotation (
    Placement(transformation(origin = {-105, 45}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant compositionCathode[10](k = {0.0, 0.0, 0.0, 0.0, 0, 0, 0.0, 0.205131882988603, 0.794868117011396, 0.0})  annotation (
    Placement(transformation(origin = {-105, 65}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant temperatureCathode(k = 750 + 273.15)  annotation (
    Placement(transformation(origin = {-105, 85}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant massFlowAnode(k = 4.4942613434132953e-7)  annotation (
    Placement(transformation(origin = {-133, -35}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.Constant temperatureAnode(k = 750 + 273.15)  annotation (
    Placement(transformation(origin = {-133, 5}, extent = {{-5, -5}, {5, 5}})));
  Components.Sources.ConcentrationRamp compositionAnode(
    nX=10,
    Xstart={0.36323032,0.63676965,0,0,0,0,0,0,0,0},
    Xend={0.36323032,0.63676965,0,0,0,0,0,0,0,0},
    tstart=1,
    tend=1e7) annotation (
    Placement(transformation(origin = {-133, -15}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(transformation(origin = {0, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
    annotation (
    Placement(transformation(origin = {76, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Constant Qloss(k=0) annotation (
    Placement(transformation(origin = {-15, 35}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Sources.TimeTable elCurrentTable(table=[0, 0.001; 10000,9])
    annotation (
    Placement(transformation(origin = {110, -30}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Modelica.Blocks.Sources.RealExpression elCurrent(y = homotopy(9, 0.001))  annotation(
    Placement(transformation(origin = {110, 0}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  Components.PressureLosses.LinearPressureLoss linearPressureLossAnode(nX = 10, wNom = 1.1956255660642811e-6, dpNom = 9)  annotation(
    Placement(transformation(origin = {41, -13}, extent = {{-7, -7}, {7, 7}})));
  Components.PressureLosses.LinearPressureLoss linearPressureLossCathode(nX = 10, wNom = 2.0418329944277608e-5, dpNom = 9)  annotation(
    Placement(transformation(origin = {39, 11}, extent = {{-7, -7}, {7, 7}})));
equation
  connect(anodeSource.flange, stack.anodeIn) annotation (Line(points={{-60,
          -16},{-44,-16},{-44,-12},{-20,-12}}, color={0,0,0}));
  connect(cathodeSource.flange, stack.cathodeIn) annotation (Line(points={{
          -60,24},{-46,24},{-46,12},{-20,12}}, color={0,0,0}));
  connect(stack.anodePin, ground.p)
    annotation (Line(points={{0,-18},{0,-60}}, color={0,0,255}));
  connect(stack.anodePin, signalCurrent.n) annotation (Line(points={{0,-18},
          {0,-46},{76,-46},{76,-10}}, color={0,0,255}));
  connect(stack.cathodePin, signalCurrent.p) annotation (Line(points={{0,18},
          {0,48},{76,48},{76,10}}, color={0,0,255}));
  connect(
      massFlowCathode.y, cathodeSource.w) annotation (
    Line(points={{-99.5,45},{-78,45},{-78,28}},       color = {0, 0, 127}));
  connect(
      temperatureCathode.y, cathodeSource.Tset) annotation (
    Line(points={{-99.5,85},{-66,85},{-66,28}},       color = {0, 0, 127}));
  connect(
      temperatureAnode.y, anodeSource.Tset) annotation (
    Line(points={{-127.5,5},{-66,5},{-66,-12}},          color = {0, 0, 127}));
  connect(
      massFlowAnode.y, anodeSource.w) annotation (
    Line(points={{-127.5,-35},{-89.5,-35},{-89.5,-6},{-78,-6},{-78,-12}},          color = {0, 0, 127}));
  connect(
      compositionAnode.y, anodeSource.X) annotation (
    Line(points={{-127.5,-15},{-114,-15},{-114,0},{-72,0},{-72,-12}},            color = {0, 0, 127}, thickness = 0.5));
  connect(
      compositionCathode.y, cathodeSource.X) annotation (
    Line(points={{-99.5,65},{-72,65},{-72,28}},       color = {0, 0, 127}, thickness = 0.5));
  connect(Qloss.y, stack.Qloss)
    annotation (Line(points={{-9.5,35},{10,35},{10,16}}, color={0,0,127}));
  connect(elCurrent.y, signalCurrent.i) annotation(
    Line(points = {{99, 0}, {88, 0}}, color = {0, 0, 127}));
  connect(stack.anodeOut, linearPressureLossAnode.inlet) annotation(
    Line(points = {{20, -12}, {34, -12}}));
  connect(linearPressureLossAnode.outlet, anodeSink.flange) annotation(
    Line(points = {{48, -12}, {60, -12}, {60, -32}}));
  connect(stack.cathodeOut, linearPressureLossCathode.inlet) annotation(
    Line(points = {{20, 12}, {32, 12}}));
  connect(linearPressureLossCathode.outlet, cathodeSink.flange) annotation(
    Line(points = {{46, 12}, {58, 12}, {58, 34}}));

annotation (
    Diagram(coordinateSystem(extent = {{-140, 100}, {120, -100}})),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeNonlinearTearing=40000",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end BenchmarkCammarataIndex1;
