#/bin/bash

###
# Install Docker
##

sudo dnf config-manager \
--add-repo \
https://download.docker.com/linux/fedora/docker-ce.repo

## OJO: Cuando docker agregue el repositorio para f30 quitar switch --release server
sudo dnf install -y --releasever=29 docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker
sudo groupadd docker
sudo usermod -aG docker $(whoami)
sudo newgrp docker


###
# VM KVM2 driver plugin installation
###
sudo dnf -y nstall libvirt-daemon-kvm qemu-kvm
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo systemctl status libvirtd.service
sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
###### install the docker-machine-driver-kvm2:
curl -Lo docker-machine-driver-kvm2 https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2 \
&& chmod +x docker-machine-driver-kvm2 \
&& sudo cp docker-machine-driver-kvm2 /usr/local/bin/ \
&& rm docker-machine-driver-kvm2

# Install kubectl
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo dnf -y install kubectl 

# install Minikub
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo cp minikube /usr/local/bin && rm minikube

