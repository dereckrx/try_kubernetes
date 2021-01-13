=== 3 ===
pod: secure-pod 
service: secure-service. 

Incoming or Outgoing connections to this pod are not working.
Troubleshoot why this is happening.

Make sure that incoming connection from the pod `webapp-color` are successful.

Important: Don't delete any current objects deployed.

service -> pod -> web-app color

=== 4 ===

Create a pod called 
name: time-check 
namespace: dvl1987
spec: 
    name: time-check 
    image: busybox 
    command: while true; do date; sleep $TIME_FREQ;done
    
Create a config map called 
name: time-config
data: TIME_FREQ=10
namespace: dvl1087 
The time-check container should run the command: while true; do date; sleep $TIME_FREQ;done 
and write the result to the location /opt/time/time-check.log.
The path /opt/time on the pod should mount a volume that lasts the lifetime of this pod.

=== 5 ===
Create a new deployment called 
name: nginx-deploy
spec:
    name: nginx, 
    image: nginx:1.16
    replicas: 4
    strategy: RollingUpdate
    maxSurge: 1
    maxUnavailable: 2

Next upgrade the deployment to version 1.17 using rolling update.
Finally, once all pods are updated, undo the update and go back to the previous version.

== 6 ====

Create a redis deployment with the following parameters:
name: redis
image: redis:alpine
replicas: 1
cpu: .2
labels:
    app: redis 
mount: 2 volumes
scheduled: on master node

