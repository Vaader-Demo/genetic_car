#!/bin/bash

#mkdir miniconda

wget https://repo.anaconda.com/miniconda/Miniconda3-py311_24.5.0-0-Linux-x86_64.sh -O ./miniconda.sh
bash ./miniconda.sh -b -s -p ./miniconda
rm -rf miniconda.sh

export PATH=$PWD/miniconda/bin:$PATH

conda create --name sim_gen python=3.11.9 -y

#conda init bash

. $PWD"/miniconda/etc/profile.d/conda.sh"

conda activate sim_gen

conda install -c conda-forge pygame=2.6.0 -y
conda install -c conda-forge numpy=1.26.4 -y
conda install -c fastai opencv-python-headless=4.10.0.84 -y
conda install -c conda-forge matplotlib-base=3.9.1 -y

# conda install -c conda-forge pygame=2.4.0 numpy=1.24.3 matplotlib-base=3.7.1 -y
# conda install -c fastai opencv-python-headless=4.7.0 -y

#conda activate sim_gen
python3 src/main.py