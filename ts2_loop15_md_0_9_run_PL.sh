#$ -S /bin/bash
#$ -N ts2_loop15_md_0_9
#$ -cwd
#$ -o /dev/null
#$ -e /dev/null
#$ -q ford
#$ -pe ford 4

source ~/.bashrc
cwd=$(pwd)

mkdir -p /pubdata/fengjie/ppdocking/GROMACS/ts2_loop15_md_0_9
cp *mdp *py ts2_loop15_md_0_9*  ts2_loop15_md_0_9_gmmpbsa_PL.sh /pubdata/fengjie/ppdocking/GROMACS/ts2_loop15_md_0_9
cd /pubdata/fengjie/ppdocking/GROMACS/ts2_loop15_md_0_9

bash  ts2_loop15_md_0_9_gmmpbsa_PL.sh

cp -r ../ts2_loop15_md_0_9 $cwd
