#dockerbuild.sh
tag="1.3"

docker rmi -f aurora:${tag}
docker rmi -f lenhattan86/aurora:${tag}
docker build . -f Dockerfile_aurora -t aurora:${tag}
docker tag aurora:${tag} lenhattan86/aurora:${tag}
docker push lenhattan86/aurora:${tag}

tag="1.5.1"
docker rmi -f mesos-agent:${tag}
docker rmi -f lenhattan86/mesos-agent:${tag}
docker build . -f Dockerfile_mesos_agent -t mesos-agent:${tag}
docker tag mesos-agent:${tag} lenhattan86/mesos-agent:${tag}
docker push lenhattan86/mesos-agent:${tag}