within SOFCPoliMi.Media.Utilities;
model MassToMolExec

  SOFCPoliMi.Media.Utilities.MassToMol massToMol "";

  parameter Types.MassFraction X[massToMol.nX] = {0.7,0.3, 0, 0, 0, 0, 0, 0};


equation

  massToMol.X = X;

annotation (
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
end MassToMolExec;
