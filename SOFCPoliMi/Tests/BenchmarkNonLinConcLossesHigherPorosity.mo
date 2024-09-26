within SOFCPoliMi.Tests;
model BenchmarkNonLinConcLossesHigherPorosity
  extends SOFCPoliMi.Tests.BenchmarkNonLinConcLosses(
                                    stack(porosity = 0.35));
  annotation (
    experiment(StartTime = 0, StopTime = 10000, Tolerance = 1e-06, Interval = 20),
    __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian --maxSizeNonlinearTearing=40000",
    __OpenModelica_simulationFlags(homotopyOnFirstTry = "()", lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", variableFilter = ".*"));
end BenchmarkNonLinConcLossesHigherPorosity;
