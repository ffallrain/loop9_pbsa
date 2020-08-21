#$ -S /bin/bash
#$ -N ts2_loop15_md_0_9
#$ -cwd
#$ -o /dev/null
#$ -e /dev/null
#$ -q opel
#$ -pe opel 4

source ~/.bashrc
cwd=$(pwd)

mkdir -p /pubdata/fengjie/ppdocking/GROMAC/ts2_loop15_md_0_9
cp *mdp *py ts2_loop15_md_0_9*  ts2_loop15_md_0_9_gmmpbsa_PP.sh /pubdata/fengjie/ppdocking/GROMAC/ts2_loop15_md_0_9
cd /pubdata/fengjie/ppdocking/GROMAC/ts2_loop15_md_0_9

bash  ts2_loop15_md_0_9_gmmpbsa_PP.sh

cp -r ../ts2_loop15_md_0_9 $cwd
