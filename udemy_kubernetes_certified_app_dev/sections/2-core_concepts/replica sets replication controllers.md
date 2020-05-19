## Replication Controllers

```
kubectl create -f rc-definition.yml
kebectl get replicationcontroller
kebectl get pods
```

## Replica Sets

New concept that replaces replicaiton controllers

```
kubectl create -f replicaset-definition.yml
kubectl get replicaset
kubectl get pods
```

### Selectors
Select on pod `labels`
Can be used to select pods that alread exist

## Scaling

`replicas: 3` -> `replicas: 6`

`kubectl replace -f replicaset-definition.yml`

## Verify your setup

```
kubectl get rs
kubectl describe rs foo-replicaset-1
```
------------------------------
## Deployents
rolling updates

------------------------------

## Namespaces
Two marks, different families
Inside their house they say Mark
refering to other marks they say full name 'Mark foo'
Each house has it's own roles and shared resources

Services inside a pod (house) can refere to each other by name `db-service`.
Talking to a service in another pod uses full namespace (full name).
`db-service.dev.svc.cluster.local`

default
dev, prod
