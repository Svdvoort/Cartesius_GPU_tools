module purge

module load java/oracle/8u73

cd $HOME
mkdir -p $HOME/TF-BUILD/
cd $HOME/TF-BUILD

# Compile Bazel
#mkdir -p bazel
#cd bazel
#wget https://github.com/bazelbuild/bazel/releases/download/0.11.0/bazel-0.11.0-dist.zip
#unzip -o bazel-0.11.0-dist.zip
#./compile.sh

mkdir -p tensorflow
cd tensorflow 
git clone https://github.com/tensorflow/tensorflow src
cd src
git checkout r1.6
/home/vandervo/TF-BUILD/bazel/output/bazel ./configure
