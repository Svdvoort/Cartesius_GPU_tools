#!/bin/bash
bazel_version=0.18.1

module purge
module load java/oracle/8u73
# This fix is needed since some Python versions do not find the openssl
# library otherwise, and thus can't use pip
#apt-get install -y build-essential openjdk-8-jdk python zip unzip

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

temp_dir=/home/vandervo/temp/bazel_"${bazel_version}"
# Make folder to store temporary files and get source
mkdir -p ${temp_dir}


cd ${temp_dir}
wget https://github.com/bazelbuild/bazel/releases/download/${bazel_version}/bazel-${bazel_version}-dist.zip
unzip bazel-${bazel_version}-dist.zip
./compile.sh

package_dir=/home/vandervo/packages/bazel/"${bazel_version}"
mkdir -p ${package_dir}
cp ./output/bazel ${package_dir}/bazel
