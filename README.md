# vagrant-puppet-docker-swarmmode-example
###Overview
Vagrant and puppet to provision a docker swarm mode based architecture, to deploy the guestbook application https://github.com/askcharlie/guestbook
Using docker in swarm mode ensures a smooth scalability and allow updates to the deployed services (and also for clustring).
The current version of this example includes only one docker host.

####Architecture
![alt tag](https://github.com/zanoubia/vagrant-puppet-docker-swarmmode-example/blob/master/architecture.png)



The storage of redis is persistent in the vagrant box.

####Project layout
```
.
├── Vagrantfile
├── environments
│   └── production
│       ├── environemnt.conf
│       ├── hieradata
│       │   └── guestbook.yaml  
│       ├── manifests
│       │   └── site.pp
│       └── modules
│           ├── docker
│           ├── guestbook
│           ├── stdlib
│           ├── swarm_mode
│           └── vcsrepo
├── hiera.yaml          # Hiera Config File
└── nginx.conf

```
###Requirements
* Install Vagrant: https://www.vagrantup.com/downloads.html
* clone this repository

###Getting Started

* Adjust the variables in hiera environments/production/hieradata/guestbook.yaml, especially the replicas values and the db_url :
```
---

redis:
  replicas: 1

guestbook:
  replicas: 1
  git_repo: "https://github.com/askcharlie/guestbook.git"
  tag: "1.0"
  db_url: "postgres://test:test@postgres:5432/test"

nginx:
  replicas: 1
```

* from the project directory run :
```
vagrant up
```
Check the application at http://localhost:8080

####Scaling and updating
To scale a service: update the values of replicas for the service in hiera environments/production/hieradata/guestbook.yaml. Then run:
```
vagrant provision
```

You can check that the scaling occured in the vagrant vm :
```
vagrant ssh
docker service ls

```

To update the ruby application after changes on the app github repository: change the value of guestbook.tag field in environments/production/hieradata/guestbook.yaml, then run vgrant provision


