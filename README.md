# SOFC PoliMi

A library showing how a SOFC for plant-wide studies might be modelled in Modelica.

## Content

Modelica models for a 1-D Solid-Oxide fuel cell.

## How to use

On OpenModelica set parameter `isOMC=true` in the models you want to test. 
This is a Fuel Cell model parameter that can be changed from the GUI. 

Moreover, to successfully complete a simulation, set the following flags:
- Translation flag: `--maxSizeNonlinearTearing=40000`
- Simulation flag: `-ils=100`

These flags allow to perform tearing on larger nonlinear systems of equations and increase the homotopy steps from 3 (default value) to 100.

On Dymola, use the script *start_up_dymola.mos* to enable homotopy operator. Set `isOMC=false` in the models you want to test.

## Versions

- #### commit 5d19eb79c0247428cc90e79c6dfa2ce8887a44e6 "Created two separate packages for OMC and Dymola and added missing flags for OMC simulation"
  As the title describes, two separate test packages were created to directly simulate on OpenModelica and Dymola and missing flags were added to run OpenModelica simulations

- #### commit 484d9b23fb18907ecf388b1d696e84346a231a99 "Update: improvements and running on OpenModelica"

  Model improvements, better code documentation and now running on OpenModelica (set parameter isOMC=true in the tests)

- #### commit f4870a81b98c73a251a2c0c2d48416f2cdeab253 "First commit"

  First commit with tests to replicate reference paper results (only works with Dymola).

## Bibliography

M. L. De Pascali, A. Donazzi, E. Martelli and F. Casella, "A Control-Oriented Modelica 1-D Model of a Planar Solid-Oxide Fuel Cell for Oxy-Combustion Cycles," 2023 IEEE Conference on Control Technology and Applications (CCTA), Bridgetown, Barbados, 2023, pp. 394-399, doi: 10.1109/CCTA54093.2023.10252534.
