#dockerbuild.sh
tag="1.3"
docker rmi aurora:$tag
docker rmi lenhattan86/aurora:$tag
docker build -t aurora:$tag .
docker tag aurora:$tag lenhattan86/aurora:$tag
docker push lenhattan86/aurora:$tag