## Intro
s
Solution: 
https://github.com/kodekloudhub/kubernetes-challenge-1-wordpress
-------
## FS server
FS Server: 
name: nfs01

* storage for `mysql-pv`
* storage for `wordpress-pv`

## Mysql-pass secret
Secret Name: mysql-pass
Secret: password=admin

-------------

## Wordpress PV
Volume Name: wordpress-persistent-storage
Storage: 1Gi
Access modes: ReadWriteMany
NFS Path: /html

* Will be bound to Claim: `wordpress-pvc`

## wordpress pvc
Claim Name: `wordpress-persistent-storage`
Storage Request: 1Gi
Access modes: ReadWriteMany

* Bind to Volume: `wordpress-persistent-storage`
wordpress pv -> wordpress pvc: Bind to Volume: wordpress-persistent-storage

---------

## Mysql PV
Volume Name: `mysql-persistent-storage`
Storage: 1Gi    
Access modes: ReadWriteMany
NFS Path: /mysql

* use NFS server for storage
mysql pv -> nfs01: NFS Server: nfs01

## mysql pvc
Claim Name: mysql-persistent-storage
Storage Request: 1Gi
Access modes: ReadWriteMany

* Bind to volume: `mysql-persistent-storage`

## mysql deploy
Name: mysql
Replicas: 1
Image: mysql:5.7
ENV: MYSQL_ROOT_PASSWORD=secret: mysql-pass
Volume Mount: mysql-persistent-storage
Volume Mount Path: /var/lib/mysql

* Use Secret for root db password
* Use claim to get a volume for db storage
mysql deploy -> secret: ENV: MYSQL_ROOT_PASSWORD=secret: mysql-pass
mysql deploy -> mysql-pvc: 
    Volume: mysql-persistent-storage
    Volume Claim: mysql-persistent-storage

-----------

## wordpress->mysql service
Name: wordpress-mysql
Type: ClusterIP
Port: 3306
TargetPort: 3306
tcp://wordpress-mysql:3306 -> tcp://mysql:3306

* Expose endpoint for db calls from wordpress deploy
wordpress-mysql-svc -> mysql deploy: Service Endpoint: `mysql pod`

----------

## wordpress Deploy
Name: wordpress
Replicas: 2
Image: wordpress
Volume Mount: wordpress-persistent-storage
Volume Mount Path: /var/www/html

* Use secret for wordpress-user db password
* Set db host to wordpress-mysql service 
* Use claim to bind to volume for content storage

wordpress deploy -> secret: ENV: WORDPRESS_DB_PASSWORD=secret:mysql-pass
wordpress deploy -> wordpress-mysql-svc: ENV: WORDPRESS_DB_HOST=wordpress-mysql
wordpress deploy -> wordpress pvc:
    Volume: wordpress-persistent-storage
    Volume Claim: wordpress-persistent-storage

## wordpress service
Name: wordpress
Type: NodePort
NodePort: 31004
Port: 80
TargetPort: 80
<nodeIP>:31004 -> wordpress:80 

* Expose endpoint to wordpress deployment for user traffic 
user => wordpress-svc: Wordpress Endpoint: `wordpress pods`

-----------------------

## Overview 

Node Port service

* maps to a deployment using a selector: wordpress
* exposes a port to user traffic: <nodeIP>:31004 -> wordpress:80
* this will allow us to `curl <nodeIP>:31004` and get our wordpress page

pv with nfs
  nfs:
    path: /tmp
    server: 172.17.0.2
