# This script counts the number of water molecules and Cl, CO3, HCO3, and Na ions which can 
# be found in each frame of an MD trajectory generated by NAMD (in *.dcd format)
# in an area of the protein of interest specified by x, y and z coordinates (x, y, and z should be determined in advance)
# this script has sample x values between 20 and -20
# y values between 15 and -15
# z values between 10 and -10

# to use: vmd -dispdev text -e permeation_count_ions_water.tcl
# This command generates the output file, named here water_ions_count.dat

#To extract the data from the output file, use the following bash commands
#(the example below is for extraction of Na ion counts):
#sed -n -e '/Na/p' water_ions_count.dat > Na_count.dat
#for i in 0 1 2 3 4 5 6 7 8 9 10; do
#printf "$i " >> Na_count_stats.dat
#grep -o "$i" Na_count.dat | wc -l >> Na_count_stats.dat
#The Na_count_stats.dat file contains the number of times 0, 1, 2,..., 10 Na atoms were found in the area, specified by x, y, and z
#The data from the Na_count_stats.dat file was used for the generation of Fig.3d of the manuscript 



#Create output file
set outfile [open "water_ions_count.dat" w]

#Specify psf and dcd from a NAMD MD simulation
set mol [mol new name_of_psf.psf type psf]
mol addfile name_of_trajectory.dcd type dcd first 0 last -1 step 2 waitfor all molid $mol

#For every step of the trajectory evaluate the number of waters and ions found in the area of the protein determined from x, y, z, 
#and input this information in the output file
#
set numfr [molinfo top get numframes]
for {set j 1} {$j < $numfr} {incr j} {
set wat_sel [atomselect top "name OH2 and z < 10 and z > -10 and y < 15 and y > -15 and x < 20 and x > -20" frame $j]
set cla_sel [atomselect top "resname CLA and z < 10 and z > -10 and y < 15 and y > -15 and x < 20 and x > -20" frame $j]
set co31_sel [atomselect top "resname CO31 and name C and z < 10 and z > -10 and y < 15 and y > -15 and x < 20 and x > -20" frame $j]
set co3_sel [atomselect top "resname CO3 and name C and z < 10 and z > -10 and y < 15 and y > -15 and x < 20 and x > -20" frame $j]
set sod_sel [atomselect top "resname SOD and z < 10 and z > -10 and y < 15 and y > -15 and x < 20 and x > -20" frame $j]
set wat_sel_num [$wat_sel num]
set cla_sel_num [$cla_sel num]
set co31_sel_num [$co31_sel num]
set co3_sel_num [$co3_sel num]
set sod_sel_num [$sod_sel num]
    puts $outfile "frame $j"
    puts $outfile "water $wat_sel_num"
    puts $outfile "Cl $cla_sel_num"
    puts $outfile "HCO3 $co31_sel_num"
    puts $outfile "CO3 $co3_sel_num"
    puts $outfile "Na $sod_sel_num"
    puts $outfile "\n"
}
close $outfile
quit