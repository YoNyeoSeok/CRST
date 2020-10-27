NAME=crst

IMAGE=yonyeoseok/$NAME:devel
docker build -t $IMAGE .
docker push $IMAGE