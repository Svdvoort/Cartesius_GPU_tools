#!/bin/bash

cuda_version=10.0.130
cuda_file=/home/vandervo/TensorflowBuild/cuda_10.0.130_410.48_linux.run
package_dir=/home/vandervo/packages/CUDA/${cuda_version}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

mkdir -p ${package_dir}

# # According to installation instructions on nvidia website
chmod +x ${cuda_file}
${cuda_file} --silent --toolkit --toolkitpath="${package_dir}" --verbose
