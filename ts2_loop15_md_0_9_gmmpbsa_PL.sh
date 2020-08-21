echo -e "r 1-151 \n name 22 PDE6 \n 1 & ! 22 \n name 23 CRBN \n 1 | 13 \n q " | gmx make_ndx -f ts2_loop15_md_0_9.gro -o index.ndx

echo -e "24\n24" | gmx trjconv -s ts2_loop15_md_0_9.tpr -f ts2_loop15_md_0_9_cluster.xtc   -pbc cluster -o ts2_loop15_md_0_9_100.xtc -dt 100 -n index.ndx 
echo -e "1\n13" |g_mmpbsa -f ts2_loop15_md_0_9_100.xtc -s ts2_loop15_md_0_9.tpr -n index.ndx -mme -pdie 2 -decomp
 -mm ts2_loop15_md_0_9_PL_energy_MM.xvg  -mmcon ts2_loop15_md_0_9_PL_contrib_MM.dat
echo -e "1\n13" | g_mmpbsa -f ts2_loop15_md_0_9_100.xtc -s ts2_loop15_md_0_9.tpr -n index.ndx -i polar.mdp -nomme -pbsa -decomp  -pol ts2_loop15_md_0_9_PL_polar.xvg -pcon ts2_loop15_md_0_9_PL_contrib_pol.dat
echo -e "1\n13" | g_mmpbsa -f ts2_loop15_md_0_9_100.xtc -s ts2_loop15_md_0_9.tpr -n index.ndx -i apolar_sasa.mdp -nomme -pbsa -decomp -apol ts2_loop15_md_0_9_PL_sasa.xvg -apcon ts2_loop15_md_0_9_PL_sasa_contrib.dat


python3 MmPbSaStat.py -bs -nbs 2000 -m ts2_loop15_md_0_9_PL_energy_MM.xvg -p ts2_loop15_md_0_9_PL_polar.xvg -a  ts2_loop15_md_0_9_PL_sasa.xvg  -of ts2_loop15_md_0_9_PL_full_energy.dat -os ts2_loop15_md_0_9_PL_summary_energy.dat 

python3 MmPbSaDecomp.py -m ts2_loop15_md_0_9_PL_contrib_MM.dat -p ts2_loop15_md_0_9_PL_contrib_pol.dat -a ts2_loop15_md_0_9_PL_sasa_contrib.dat -bs -nbs 2000 -ct 999 -o ts2_loop15_md_0_9_PL_final-contrib-energy.dat -om ts2_loop15_md_0_9_PL_energymapin.dat

echo -e "1\n13" |energy2bfac -s ts2_loop15_md_0_9_e.pdb -i ts2_loop15_md_0_9_PL_energymapin.dat -n index.ndx -c ts2_loop15_md_0_9_PL_complex.pdb -s1 ts2_loop15_md_0_9_PL_s1.pdb -s2 ts2_loop15_md_0_9_PL_s2.pdb

