#This VMD TCL script combines several MD trajectories generated with NAMD into one big trajectory 
#and wraps and aligns this big trajectory with respect to the protein

# to use: vmd -dispdev text -e pbcwrap_trajectory.tcl
#
# The aligned trajectories from this script have been used for generation of 
# ion density maps (Fig.3) in the manuscript with the use of the Volmap tool available from the VMD GUI.


# Set the input psf, xsc, and dcd files. List however many dcd files you need.
set psf name_of_psf.psf
set dcd name_of_dcd1.dcd
set dcd2 name_of_dcd2.dcd
set dcd3 name_of_dcd3.dcd
set xsc name_of_xsc.xsc


# Load the psf and dcd files (here every 2nd step of the trajectories is loaded)
mol new $psf
mol addfile $dcd last -1 step 2 waitfor all
mol addfile $dcd2 last -1 step 2 waitfor all
mol addfile $dcd3 last -1 step 2 waitfor all


#Get number of frames, output frame counter on the screen
set nFrames [molinfo top get numframes]
puts [format "Reading %i frames." $nFrames]

animate delete beg 0 end 0

#Select the protein atoms with repsect to which the trajectory will be wrapped and aligned 
#and the reference frame (frame 0 here) for the alignment 
set sel [atomselect top "protein and backbone"] 
set ref [atomselect top "protein and backbone" frame 0]
set all [atomselect top "all"]


#Wrap and align the trajectory, using pbctools
package require pbctools

pbc readxst $xsc

pbc wrap -center com -centersel "protein and backbone" -compound residue -all


for {set f 0 } {$f <= $nFrames } {incr f 1} {
                 molinfo top set frame $f
                 $sel frame $f
                 $all frame $f
		 set trans_mat [measure fit $sel $ref]
		 $all move $trans_mat
}

pbc join res -first 0 -last 0 -sel "protein"
pbc unwrap -sel "protein" -all


#Write a new wrapped and aligned trajectory
animate write dcd name_of_aligned_dcd.dcd end -1  waitfor all

mol delete top
quit
#
