## FS server
FS Server: nfs01
-> msyql-pv
-> wordpress-pv

## Wordpress PV
Volume Name: wordpress-persistent-storage
Storage: 1Gi
Access modes: ReadWriteMany
NFS Path: /html
-> wordpress-persistant-storage

## wordpress pvc
Claim Name: wordpress-persistent-storage
Storage Request: 1Gi
Access modes: ReadWriteMany
->  wordpres-deploy: v name, v claim

## Mysql PV
Volume Name: mysql-persistent-storage
Storage: 1Gi
Access modes: ReadWriteMany
NFS Path: /mysql
-> mysql-persistant-storage

## mysql pvc
Claim Name: mysql-persistent-storage
Storage Request: 1Gi
Access modes: ReadWriteMany

## Mysql-pass secret
Secret Name: mysql-pass
Secret: password=admin

## wordpress Deploy
Name: wordpress
Replicas: 2
Image: wordpress
Volume Mount: wordpress-persistent-storage
Volume Mount Path: /var/www/html
ENV: WORDPRESS_DB_PASSWORD=secret:mysql-pass
-> mysql-pass (via ENV)

## mysql deploy
Name: mysql
Replicas: 1
Image: mysql:5.7
ENV: MYSQL_ROOT_PASSWORD=secret: mysql-pass
Volume Mount: mysql-persistent-storage
Volume Mount Path: /var/lib/mysql
-> mysql-pass: via ENV

## wordpress mysql service
Name: wordpress-mysql
Type: ClusterIP
Port: 3306
TargetPort: 3306
-> mysql deploy: Service Endpoint: mysql pod
<- wordpress deploy: ENV: WORDPRESS_DB_HOST=wordpress-mysql

tcp://wordpress-mysql:3306 -> tcp://mysql:3306

## wordpress service
Name: wordpress
Type: NodePort
NodePort: 31004
Port: 80
TargetPort: 80
<- Wordpress Endpoint: wordpress pods

<nodeIP>:31004 -> wordpress:80 
