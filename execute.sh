# 対象となる動画はサーバに上がっている前提 (~/$1)
sudo su
git clone https://gist.github.com/f24aed76b4cc91bfb2c1.git
sh f24aed76b4cc91bfb2c1/install-ffmpeg-amazon-linux.sh

git clone https://github.com/graphific/DeepDreamVideo.git
pip install numpy
cd DeepDreamVideo
mkdir frames
mkdir processed_frames
./1_movie2frames.sh ffmpeg ~/$1 frames jpg
python 2_dreaming_time.py -i frames -o processed_frames --gpu 0
./3_frames2movie.sh processed_frames ~/$1 jpg
