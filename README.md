# Installation guideline
## Hardware Requirements
| Minimum Requirement  | Specification |
| ------------- | ------------- |
| Number of servers  | 1  |
| Minimum processor class  | Single- CPU Intel(R) Xeon(R) CPU E5-2697 v4 @ 2.30GHz, 18 cores |
| Minimum memory | 32 GB |
| Primary disk | 500 GB |
| Minimum network ports | 1x1GE|

## Prerequisites Linux & Network
Start with a clean and minimal install of a Linux system. Ubuntu 18.04 (Bionic Beaver) is the most tested, and will probably go the smoothest.

### Network Configuration
Determine the network configuration on the interface used to integrate your OpenStack cloud with your existing network. For example, if the IPs given out on your network by DHCP are 192.168.10.X/24 - where X is between 100 and 200 you will be able to use IPs 201-254 for floating ips.

## Install Devstack
### Add Stack User
``` 
sudo useradd -s /bin/bash -d /opt/stack -m stack 
```

Providing `stack` user sudo privileges:
```
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo su - stack
```

### Download DevStack
```
git clone https://opendev.org/openstack/devstack
git checkout f8a6eac9b5c0a77a11498bef9e274161727ca364
cd devstack
```

### Create a local.conf
**Set HOST_IP to a host's IP used on the local network**
```
[[local|localrc]]
HOST_IP=192.168.10.10
MULTI_HOST=True

ADMIN_PASSWORD=root
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD

NOVA_BRANCH=stable/ussuri
CINDER_BRANCH=stable/ussuri
GLANCE_BRANCH=stable/ussuri
NEUTRON_BRANCH=stable/ussuri
KEYSTONE_BRANCH=stable/ussuri

```

The `local.conf` installs the components: aodh, barbican, ceilometer, cinder, fenix, glance, heat, heat-dashboard, horizon, keystone, mistral, mistral-dashboard, networking-sfc, neutron, nova, noVNC, octavia, octavia-dashboard, placement, requirements, tacker, tacker-horizon, tacker-specs, vitrage, vitrage-dashboard.

There is a sample [`local.conf`](local.conf) file under the samples directory in the devstack repository.

### Start the install
```
./stack.sh
```
This will take a 15 - 20 minutes, largely depending on the speed of your internet connection. Many git trees and packages will be installed during this process.
