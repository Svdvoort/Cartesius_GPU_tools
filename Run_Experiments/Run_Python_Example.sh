#!/bin/bash
#SBATCH -N 1        # request 1 nodes
#SBATCH -p gpu   	# request partition 'GPU'
#SBATCH -n 16       # request 16 processes (each runs on 1 core)
					# However, you get one full node anyway
#SBATCH -t 24:00:00  # The job can take at most 24 wall-clock hours.
#SBATCH -o /path/to/output/logs/%j.log
#SBATCH -e /path/to/error/logs/%j.log
#SBATCH --mail-user=your_email@example.com
#SBATCH --mail-type=ALL

# The following modules need to be loaded to work with the environment 
# set-up from the Configure_System folder
# Do not change the order of these module loads! It will cause errors
module load cuda/9.0.176
module load cudnn/8.0-v7
module load python/2.7.11
module load gcc/5.2.0

# Active the python environment
source $HOME/path/to/environment/bin/activate

# Run your script
python $HOME/Example_script.py
