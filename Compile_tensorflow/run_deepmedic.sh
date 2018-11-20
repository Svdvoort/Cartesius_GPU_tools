#!/bin/bash
#SBATCH -N 1        # request 5 nodes
#SBATCH -p gpu_short    # request partition 'short', see below
#SBATCH -n 16       # request 40 processes (each runs on 1 core), mostly to run MPI programs on
                    # SLURM will compute the number of nodes needed
#SBATCH -t 1:00:00  # The job can take at most 2 wall-clock hours.
#SBATCH -o /home/vandervo/logfiles/output/%j.log
#SBATCH -e /home/vandervo/logfiles/error/%j.log
#SBATCH --mail-user=s.vandervoort@erasmusmc.nl
#SBATCH --mail-type=ALL

cd $HOME/TensorflowBuild
./Install_tensorflow.sh
