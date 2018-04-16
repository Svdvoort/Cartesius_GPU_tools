#!/bin/bash

# Specificy the directory of your code (Assumed to be in Home folder)
code_dir_name=Example_dir
# Specify the name you want for the virtual environment
vir_env_name=Example

# Change directory to the code folder
cd $HOME/$code_dir_name

# Load modules
module purge
module load python/3.5.2

# Create environment
python3 -m venv --system-site-packages $vir_env_name
source $HOME/$code_dir_name/$vir_env_name/bin/activate

#install packages
pip install -I --upgrade --user tensorflow
pip install -I --upgrade --user tensorflow-gpu
pip install -I --upgrade --user keras
