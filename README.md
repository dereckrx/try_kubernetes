## Useful links

Validate yaml `https://kubeyaml.com/`

View all Docker images that you've pushed to docker hub
https://cloud.docker.com/repository/list

Play with k8s in the browser
https://labs.play-with-k8s.com/

## Overview

See `Makefile` for commands commands.

`kubectl` command line tool is used send API requests and commands to an API-server which runs in the master node inside the cluster. Api-commands are used with JSON manifest files to describes desired state.


## View in browser

GET ip of nodes
$ kubectl describe nodes <node-name> (ex: minikube)

```
Addresses:
  InternalIP:  192.168.64.2
```

\$ kubectl describe svc hello-service

```
NodePort:                 <unset>  30752/TCP
```

Then the app is available at:
[](http://192.168.64.2:30752/)


## Courses Links

https://app.pluralsight.com/library/courses/managing-kubernetes-api-server-pods/table-of-contents
https://app.pluralsight.com/library/courses/kubernetes-installation-configuration-fundamentals/table-of-contents

https://app.pluralsight.com/player?course=kubernetes-installation-configuration-fundamentals&author=anthony-nocentino&name=c841b22a-35fa-4260-b592-e1a755760ace&clip=0&mode=live

## Done

### Thu Jun 6 2019 1:33 PM

This one was really good, hands on with minikube
https://app.pluralsight.com/library/courses/getting-started-kubernetes/table-of-contents

Meh, history part was good but no real info on how k8s works
https://app.pluralsight.com/library/courses/docker-kubernetes-big-picture/table-of-contents
