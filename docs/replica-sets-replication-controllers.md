## Replica Sets

New concept that replaces replication controllers (deprecated)

### Selectors
Select on pod `labels`
Can be used to select pods that already exist

## Scaling

`replicas: 3` -> `replicas: 6`

`kubectl replace -f replicaset-definition.yml`

## Deployments
rolling updates
