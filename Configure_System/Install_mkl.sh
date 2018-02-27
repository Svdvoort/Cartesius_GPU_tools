module load cmake/3.7.2
module load gcc/5.2.0
module load mkl/18.0.1
module load openmpi/icc/2.0.2

cd $HOME

git clone https://github.com/intel/mkl-dnn.git
cd mkl-dnn/scripts && ./prepare_mkl.sh && cd ..
mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/libs/mkl-intel ..
mkdir -p $HOME/libs/mkl-intel
make -j4 

make install

cp -R $HOME/mkl-dnn/external/mklml_lnx_2018.0.1.20171227/lib/libmklml_intel.so $HOME/libs/mkl-intel/lib/

echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:'"$HOME"'/libs/mkl-intel/lib/s' >> ~/.bashrc

