#!/bin/bash
## SETTINGS
tensorflow_version=1.12.0
python_version=3.6.7

temp_dir=/home/vandervo/temp_packages/tensorflow
out_directory=/home/vandervo/packages/tensorflow/${tensorflow_version}

gcc_path=/home/vandervo/packages/gcc/7.3.0/bin
gcc_library_path=/home/vandervo/packages/gcc/7.3.0/lib
gcc_library64_path=/home/vandervo/packages/gcc/7.3.0/lib64
gcc_bin=/home/vandervo/packages/gcc/7.3.0/bin/gcc
python_path=/home/vandervo/packages/python/3.6.7/bin
bazel_path=/home/vandervo/packages/bazel/0.18.1/
bazel_bin=${bazel_path}/bazel
cuda_path=/home/vandervo/packages/CUDA/10.0.130/
cudnn_path=/home/vandervo/packages/CUDNN/7.4.1/
nccl_path=/home/vandervo/packages/NCCL/2.3.7/
tensorrt_path=/home/vandervo/packages/TensorRT/5.0.2.6/
python_tensorflow_directory=/home/vandervo/packages/TensorFlow/1.12.0/

# Load the modules for which we want to install this tensorflow
# Start with purge to make sure we have everything we actually want
module purge
module load java/oracle/8u73

export PATH=${bazel_path}:$PATH
export PATH=${gcc_path}:$PATH
export PATH=${cuda_path}/bin:$PATH
export PATH=${tensorrt_path}/bin:$PATH
export LD_LIBRARY_PATH=${gcc_library_path}:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${gcc_library64_path}:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${cuda_path}/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${cuda_path}/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${cuda_path}/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${cudnn_path}/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${cudnn_path}/include:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${tensorrt_path}/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${nccl_path}/lib:$LD_LIBRARY_PATH





DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

python_version_elements=(${python_version//./ })
python_main_version="${python_version_elements[0]}"

mkdir -p ${temp_dir}
cd ${temp_dir}

# Get python dependencies for tensorflow
# NOTE: change this so that all the packages have a specified version
if [ $python_main_version = "2" ]; then
  # Python 2
  ${python_path}/pip install --upgrade pip
  ${python_path}/pip install setuptools==39.1.0
  ${python_path}/pip install numpy
  ${python_path}/pip install enum34
  ${python_path}/pip install mock
  ${python_path}/pip install keras_applications --no-deps
  ${python_path}/pip install keras_preprocessing --no-deps
elif [ $python_main_version = "3" ]; then
  # Python 3
  ${python_path}/pip3 install --upgrade pip
  ${python_path}/pip3 install setuptools==39.1.0
  ${python_path}/pip3 install numpy
  ${python_path}/pip3 install enum34
  ${python_path}/pip3 install mock
  ${python_path}/pip3 install keras_applications --no-deps
  ${python_path}/pip3 install keras_preprocessing --no-deps
fi
#
# # Get tensorflow
git clone -b "v${tensorflow_version}" --single-branch --depth 1 https://github.com/tensorflow/tensorflow
cd tensorflow

patch -N ./third_party/gpus/crosstool/CROSSTOOL.tpl < /home/vandervo/CROSSTOOL.patch

echo "Python: ${python_path}"
echo "GCC: ${gcc_bin}"
echo "CUDA: ${cuda_path}"
echo "cudnn: ${cudnn_path}"
echo "nccl: ${nccl_path}"
echo "tensorrt: ${tensorrt_path}"

./configure


${bazel_bin} build --config=opt --config=cuda --cxxopt="-D_GLIBCXX_USE_CXX11_ABI=0" --verbose_failures //tensorflow/tools/pip_package:build_pip_package

bazel-bin/tensorflow/tools/pip_package/build_pip_package ${python_tensorflow_directory}
