echo -e "r 1-151 \n name 22 PDE6 \n 1 & ! 22 \n name 23 CRBN \n 1 | 13 \n q " | gmx make_ndx -f prodB.gro -o index.ndx

echo -e "24\n24" | gmx trjconv -s prodB.tpr -f prodB_cluster.xtc   -pbc cluster -o prodB_100.xtc -dt 100 -n index.ndx 
echo -e "22\n23" |g_mmpbsa -f prodB_100.xtc -s prodB.tpr -n index.ndx -mme -pdie 2 -decomp -mm prodB_PP_energy_MM.xvg  -mmcon prodB_PP_contrib_MM.dat
echo -e "22\n23" | g_mmpbsa -f prodB_100.xtc -s prodB.tpr -n index.ndx -i polar.mdp -nomme -pbsa -decomp  -pol prodB_PP_polar.xvg -pcon prodB_PP_contrib_pol.dat
echo -e "22\n23" | g_mmpbsa -f prodB_100.xtc -s prodB.tpr -n index.ndx -i apolar_sasa.mdp -nomme -pbsa -decomp -apol prodB_PP_sasa.xvg -apcon prodB_PP_sasa_contrib.dat


python MmPbSaStat.py -bs -nbs 2000 -m prodB_PP_energy_MM.xvg -p prodB_PP_polar.xvg -a  prodB_PP_sasa.xvg  -of prodB_PP_full_energy.dat -os prodB_PP_summary_energy.dat 

python MmPbSaDecomp.py -m prodB_PP_contrib_MM.dat -p prodB_PP_contrib_pol.dat -a prodB_PP_sasa_contrib.dat -bs -nbs 2000 -ct 999 -o prodB_PP_final-contrib-energy.dat -om prodB_PP_energymapin.dat

echo -e "22\n23" |energy2bfac -s prodB_e.pdb -i prodB_PP_energymapin.dat -n index.ndx -c prodB_PP_complex.pdb -s1 prodB_PP_s1.pdb -s2 prodB_PP_s2.pdb

