IMAGE=yonyeoseok/conda3:cuda9.0-cudnn7-devel-ubuntu16.04
NAME=crst

docker run -idt --name tmp $IMAGE
# create conda env
docker exec tmp conda update -n base -c defaults conda
docker exec tmp \
	conda create -yn py27torch04 \
	python=2.7 pytorch=0.4.0 torchvision=0.2.1 py-opencv=3.4 cuda90 \
    packaging scipy h5py pyyaml matplotlib \
	-c conda-forge -c pytorch
# add user
docker exec tmp apt-get update --fix-missing
ddocker exec tmp apt-get install -y sudo git vim screen ssh libgl1-mesa-glx
docker exec tmp apt-get clean
docker exec tmp useradd -m -G sudo,conda $NAME
docker exec tmp /bin/bash -c "echo $NAME:passwd | chpasswd"
docker stop tmp

docker commit tmp yonyeoseok/$NAME:devel
docker rm tmp

docker push yonyeoseok/$NAME:devel