within SOFCPoliMi.Tests.Dymola;
model BenchmarkCammarataDym
  extends Modelica.Icons.Example;
  ParametrizedModels.StackCammarata stack(isOMC=false)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Components.Sources.SourceIdealMassFlow anodeSource(p_start( displayUnit = "Pa")= 101325, T_start = 750 + 273.15, rho_start = 0.2, X_start = {0.36323032, 0.63676965, 0, 0, 0, 0, 0, 0, 0, 0})  annotation (
    Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Components.Sources.SourceIdealMassFlow cathodeSource(p_start(displayUnit = "Pa") = 101325, T_start = 750 + 273.15, X_start = {0.0, 0.0, 0.0, 0.0, 0, 0, 0.0, 0.205131882988603, 0.794868117011396, 0.0}, rho_start = 0.2)  annotation (
    Placement(transformation(extent = {{-80, 14}, {-60, 34}})));
  Components.Sources.IdealSinkPressure cathodeSink(p(displayUnit = "Pa") = 101325)  annotation (
    Placement(transformation(extent = {{40, 20}, {60, 40}})));
  Components.Sources.IdealSinkPressure anodeSink(p( displayUnit = "Pa")= 101325)  annotation (
    Placement(transformation(extent = {{40, -40}, {60, -20}})));
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
  Modelica.Blocks.Sources.Constant elCurrent(k=9) annotation (
    Placement(transformation(origin = {129, 19}, extent = {{-5, -5}, {5, 5}}, rotation = 180)));
  Modelica.Blocks.Sources.TimeTable elCurrentTable(table=[0,0.001; 10000,9])
    annotation (
    Placement(transformation(origin = {124, -34}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(anodeSource.flange, stack.anodeIn) annotation (Line(points={{-60,
          -16},{-44,-16},{-44,-12},{-20,-12}}, color={0,0,0}));
  connect(cathodeSource.flange, stack.cathodeIn) annotation (Line(points={{
          -60,24},{-46,24},{-46,12},{-20,12}}, color={0,0,0}));
  connect(stack.cathodeOut, cathodeSink.flange)
    annotation (Line(points={{20,12},{50,12},{50,30}}, color={0,0,0}));
  connect(stack.anodeOut, anodeSink.flange)
    annotation (Line(points={{20,-12},{50,-12},{50,-30}}, color={0,0,0}));
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
  connect(
      signalCurrent.i, elCurrentTable.y) annotation (
    Line(points={{88,0},{146,0},{146,-34},{135,-34}},          color = {0, 0, 127}));
annotation (
    Diagram(coordinateSystem(extent = {{-140, 100}, {120, -100}})),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeNonlinearTearing=40000",
  __OpenModelica_simulationFlags(ils = "100", lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end BenchmarkCammarataDym;
