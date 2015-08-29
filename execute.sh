# 対象となる動画はサーバに上がっている前提 (~/$1)
yum install git -y
git clone https://gist.github.com/69203cd11dec2fd0805e.git
sh f24aed76b4cc91bfb2c1/install-ffmpeg-amazon-linux.sh

############
scipyインストール
http://kesin.hatenablog.com/entry/20111229/1325174595
protobufインストール
https://github.com/google/protobuf
## protobuf はv2.5.0にチェックアウトして使う

numpyインストール
http://soqdoq.com/teq/?cat=54k

yum install kernel-devel

caffeインストール
http://blog.jnory.com/archives/137


yum install protobuf-devel snappy-devel

wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz
tar zxvf glog-0.3.3.tar.gz
cd glog-0.3.3
./configure
make && sudo make install

wget https://github.com/schuhschuh/gflags/archive/master.zip
unzip master.zip
cd gflags-master
mkdir build && cd build
export CXXFLAGS="-fPIC" && cmake .. && make VERBOSE=1
make && make install

git clone https://github.com/google/leveldb.git
make -j8
make check
cd ..
sudo mv leveldb-1.15.0 /opt/leveldb

wget http://www.hdfgroup.org/ftp/HDF5/current/src/hdf5-1.8.15-patch1.tar
tar xvzf hdf5-1.8.15-patch1.tar
cd hdf5-1.8.15-patch1
./configure --prefix=/usr/local/hdf5 --enable-fortran --enable-cxx
make -j8
make -j8 check
sudo make install
sudo make check-install

git clone https://github.com/LMDB/lmdb
cd lmdb/libraries/liblmdb
make && make install


git clone https://github.com/BVLC/caffe.git
cd caffe
cp Makefile.config.example Makefile.config

## MakefileのLIBRARIESにopencv_imgcodecsを追加
## Makefile.configを
## INCLUDE_DIRS := $(PYTHON_INCLUDE) /usr/local/include /usr/local/hdf5/include /opt/leveldb/include
## LIBRARY_DIRS := $(PYTHON_LIB) /usr/local/lib /usr/lib /usr/local/hdf5/lib /opt/leveldb /usr/lib64/atlas-sse3 

make -j8 all
make test
make runtest

cd python
sudo CPATH=/usr/local/hdf5/include LIBRARY_PATH=/usr/local/hdf5/lib pip install -r requirements.txt
cd ..
make -j8 pycaffe
##########

git clone https://github.com/graphific/DeepDreamVideo.git
pip install numpy
cd DeepDreamVideo
mkdir frames
mkdir processed_frames
./1_movie2frames.sh ffmpeg ~/$1 frames jpg
python 2_dreaming_time.py -i frames -o processed_frames --gpu 0
./3_frames2movie.sh processed_frames ~/$1 jpg
