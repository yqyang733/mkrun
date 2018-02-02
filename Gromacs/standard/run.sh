#!/bin/bash

if false; then
prefix=step1_mini_crystal
gmx grompp -f $prefix.mdp -o $prefix.tpr -c pdb2gmx/ionized.gro -n pdb2gmx/index.ndx -p pdb2gmx/topol_inter.top -debug
gmx mdrun -v -s $prefix.tpr -deffnm output/$prefix


prefix1=step1_mini_crystal
prefix2=step2_mini
gmx grompp -f $prefix2.mdp -o $prefix2.tpr -c output/$prefix1.gro -n pdb2gmx/index.ndx -p pdb2gmx/topol_inter.top -debug
gmx mdrun -v -s $prefix2.tpr -deffnm output/$prefix2
fi

prefix1=step2_mini
prefix2=step3_annealing
gmx grompp -f $prefix2.mdp -o $prefix2.tpr -c output/$prefix1.gro -n pdb2gmx/index.ndx -p pdb2gmx/topol_inter.top
gmx mdrun -v -s $prefix2.tpr -deffnm output/$prefix2
