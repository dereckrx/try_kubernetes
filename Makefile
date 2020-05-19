# start cluster
start:
	# minikube config set vm-driver hyperkit
	minikube start --vm-driver hyperkit

stop:
	minikube stop

# List nodes in the cluster to see minicube
nodes:
	kubectl get nodes

# Open web UI for cluster
dashboard:
	minikube dashboard

setup:
	brew install minikube && \
	brew install hyperkit && \
	curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit && \
	sudo install -o root -g wheel -m 4755 docker-machine-driver-hyperkit /usr/local/bin/

push:
	GIT_SSH_COMMAND="ssh -i ~/.ssh/id_drx_rsa -F /dev/null" git push

# Docker container repo commands
#-------------------------------------------------

## Docker build image and push to image repo
# Build Image from source code:
build_image:
	docker image build -t dereckrx/container-demo:2 .

# Push the build container to the docker.io image repo
push_image:
	docker image push dereckrx/containers-demo:2

# Run the container from the image repo:
run_image:
	docker container run -d --name web -p 8080:8080 dereckrx/containers-demo:2
