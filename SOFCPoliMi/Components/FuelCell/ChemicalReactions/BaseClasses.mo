within SOFCPoliMi.Components.FuelCell.ChemicalReactions;

package BaseClasses
  extends Modelica.Icons.BasesPackage;

  partial model ChannelReactionRates
    constant Integer nX = 10 "Number of species in the mixture";
    input Types.Pressure pX[nX] "Partial pressure in the volume";
    input Types.Temperature T(start = T_start) "Mixture temperature";
    // Start values
    parameter Types.Temperature T_start "";
  end ChannelReactionRates;
end BaseClasses;
