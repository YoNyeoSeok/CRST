IMAGE=yonyeoseok/conda3:cuda9.0-cudnn7-devel-ubuntu16.04
NAME=crst

docker run -idt --name $NAME $IMAGE
# create conda env
docker exec $NAME conda update -n base -c defaults conda
docker exec $NAME \
	conda create -yn py27torch04 \
	python=2.7.12 pytorch=0.4.0 torchvision=0.2.1 py-opencv=3.4 cuda90 -c conda-forge -c pytorch
docker exec $NAME \
	conda install -yn py27torch04 \
    packaging scipy h5py pyyaml matplotlib
# add user
docker exec $NAME apt-get update --fix-missing
docker exec $NAME apt-get install -y sudo git vim screen ssh
docker exec $NAME apt-get clean
docker exec $NAME useradd -m -G sudo,conda $NAME
docker exec $NAME /bin/bash -c "echo $NAME:passwd | chpasswd"
docker stop $NAME

docker commit $NAME yonyeoseok/$NAME:devel
docker rm $NAME

docker push yonyeoseok/$NAME:devel