#!/bin/bash

rm -f editconf.pdb solvate.gro ions.tpr ionized.pdb

cat > ions.mdp << EOF
integrator  = md
dt          = 0.001
nsteps      = 50000
nstlist         = 1
cutoff-scheme   = Verlet
ns_type         = grid
coulombtype     = PME
rcoulomb        = 1.0
rvdw            = 1.0
pbc             = xyz
EOF

#gmx pdb2gmx -f mol.pdb

# Create a cubic box of 2 nm on each side and place the system to the center and align its principle axes to the reference axes
gmx editconf -f mol.pdb -o editconf.pdb -box 11.4 11.4 14.4

# Solvate the box
gmx solvate -cp editconf.pdb -o solvate.gro -p topol.top
# Add ions to make it neutral and of 0.15 M NaCl
# If you want KCl, add -pname K
gmx grompp -f ions.mdp -c solvate.gro -o ions.tpr -p topol.top -maxwarn 1 > LOG_grompp 2>&1
gmx genion -s ions.tpr -o ionized.pdb -conc 0.15 -neutral -p topol.top -pname K
echo q | gmx make_ndx -f ionized.pdb 

rm -f \#* editconf.pdb solvate.gro ions.mdp ions.tpr mdout.mdp
