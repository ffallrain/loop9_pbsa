echo -e "r 1-151 \n name 22 PDE6 \n 1 & ! 22 \n name 23 CRBN \n 1 | 13 \n q " | gmx make_ndx -f prodB.gro -o index.ndx

echo -e "24\n24" | gmx trjconv -s prodB.tpr -f prodB_cluster.xtc   -pbc cluster -o prodB_100.xtc -dt 100 -n index.ndx 
echo -e "1\n13" |g_mmpbsa -f prodB_100.xtc -s prodB.tpr -n index.ndx -mme -pdie 2 -decomp
 -mm prodB_PL_energy_MM.xvg  -mmcon prodB_PL_contrib_MM.dat
echo -e "1\n13" | g_mmpbsa -f prodB_100.xtc -s prodB.tpr -n index.ndx -i polar.mdp -nomme -pbsa -decomp  -pol prodB_PL_polar.xvg -pcon prodB_PL_contrib_pol.dat
echo -e "1\n13" | g_mmpbsa -f prodB_100.xtc -s prodB.tpr -n index.ndx -i apolar_sasa.mdp -nomme -pbsa -decomp -apol prodB_PL_sasa.xvg -apcon prodB_PL_sasa_contrib.dat


python MmPbSaStat.py -bs -nbs 2000 -m prodB_PL_energy_MM.xvg -p prodB_PL_polar.xvg -a  prodB_PL_sasa.xvg  -of prodB_PL_full_energy.dat -os prodB_PL_summary_energy.dat 

python MmPbSaDecomp.py -m prodB_PL_contrib_MM.dat -p prodB_PL_contrib_pol.dat -a prodB_PL_sasa_contrib.dat -bs -nbs 2000 -ct 999 -o prodB_PL_final-contrib-energy.dat -om prodB_PL_energymapin.dat

echo -e "1\n13" |energy2bfac -s prodB_e.pdb -i prodB_PL_energymapin.dat -n index.ndx -c prodB_PL_complex.pdb -s1 prodB_PL_s1.pdb -s2 prodB_PL_s2.pdb

