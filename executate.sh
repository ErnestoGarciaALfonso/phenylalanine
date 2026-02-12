source /usr/local/gromacs/bin/GMXRC

rm  \#*
#rm 1AKI_newbox.gro 1AKI_solv.gro


#echo "Remove the SOL and Na in topol,top in case you are running a previous calculation"
#read -p "Press [Enter] key to continue..."

# Copy NP.top to NP.itp and create a topol.top


echo "SOLVATION"
read -p "Press [Enter] key to continue..."


### powder unit cell 0.6  3.08020  0.87980  nm
gmx editconf -f coordinates.pdb -o File.gro   -box 0.6  3.08020  0.87980  -angles 90 90.120 90 

gmx genconf -f File.gro -o File_more_cell.gro -nbox 2 2 2 -dist 1.5
#### Replicating unit cell : -nbox 4x3x3=36 then 36*number of molecules replicated at each cell, to fix at topology file
## -dist 1.5 nm distance between unit cell

#gmx editconf -f coordinates.pdb -o File.gro -c -d  2 -bt cubic
#gmx solvate -cp File.gro -cs spc216.gro -o 1AKI_solv.gro -p topol.top


#
#echo "Adding Ions"
#gmx grompp -f ions.mdp -c 1AKI_solv.gro -p topol.top -o ions.tpr -maxwarn 2


#### comment the systme and what is below in order to not repeat system


### Choose SOL to be replaced by Na atoms
#gmx genion -s ions.tpr -o 1AKI_solv_ions.gro -p topol.top -pname NA -nname CL -neutral << EOF

#7
#EOF

#echo "Minimization"
read -p "Press [Enter] key to continue..."
gmx grompp -f minim.mdp -c File_more_cell.gro  -p topol.top -o em.tpr -maxwarn 2

read -p "run? Press [Enter] key to continue..."
gmx mdrun -v -deffnm em



#gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -n index.ndx -o nvt.tpr -maxwarn 2
#mpirun -np 4 gmx mdrun -v -deffnm nvt



