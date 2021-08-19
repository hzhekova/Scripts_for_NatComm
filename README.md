# Scripts_for_NatComm
This repository contains several TCL scripts used for trajectory analysis with VMD and CHARMM. 
The scripts were used in the following publication in Nature Communications:
Cryo-EM Structure of the Sodium-driven Chloride/Bicarbonate Exchanger NDCBE (SLC4A8) by
Weiguang Wang, Kirill Tsirulnikov, Hristina Zhekova, Gulru Kayik, Hanif
Muhammad-Khan, Rustam Azimov, Natalia Abuladze, Liyo Kao, Debbie Newman,
Sergei Yu. Noskov, Z. Hong Zhou, Alexander Pushkin, Ira Kurtz

VMD scripts:
- pbcwrap_trajectory.tcl: Wraps and aligns a MD trajectory with respect to selected protein atoms.
This results in a MD trajectory with the protein in the center of the periodic cell, which can then be
used for further analysis with scripts or VMD tools(e.g. VolMap)


- permeation_count_ions_water.tcl: Evaluates the number of water molecules and Cl, CO3, HCO3, and Na ions which can
be found in each frame of an MD trajectory.


CHARMM script:
- ion_time_series.inp: Uses the MIND CHARMM function to select the closest anion and Na ions to a defined region of
the protein and then outputs the distance between the ions and the protein for each step of the trajectory. 
The output can be used for generation of time series of the ions in the binding pocket of the protein.


More information on the usage of the scripts is provided as comments in the scripts.
