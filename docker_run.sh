IMAGE=yonyeoseok/crst:devel
NAME=crst
CODEDIR=$HOME/research/CRST
DATADIR=$HOME/data
WORKDIR=/home/crst

docker run -idt -u $NAME -w $WORKDIR -e "TERM=$TERM" \
	--name $NAME --pid host \
	-v=$CODEDIR:$WORKDIR/CRST \
	--gpus all --shm-size 32g \
	-v=$DATADIR:$WORKDIR/data:ro \
	$IMAGE