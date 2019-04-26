. .env

docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME && docker rmi $IMAGE_NAME

# You'll need self-signed certs
mkdir -p certs
cp -f ~/src/localhost.product.com.crt certs/
docker build -t $IMAGE_NAME .
