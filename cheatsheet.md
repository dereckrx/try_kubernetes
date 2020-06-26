# Cheatsheet

## Syntax
kubectl <action> <resourceType> <name> <options>

### Primary commands

kubectl create -f pod_definition_file.yaml

kubectl apply -f pod_definition_file.yaml

## actions
get, describe, edit, delete

get
-o yaml: output config to editor
-o yaml > new-file.yaml: output to file
-o wide: more detailed
--all-namespaces
get all

create 
-f <filename>: yaml config file

describe

edit

delete

## resourceType
pod: pods
rs: replicasets 
rc: replication-controller
deployments
service
nodes

## name
show in `get` output

## options
--dry-run: only output success/failure
--namespace=<namespace>

## Less common

kubectl scale rs myapp-rs --replicas=5
kubectl run nginx --image=nginx
Set namespace
kubectl config set-context $(kubectl config currentContext) --namespace=dev

## 
Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)
`kubectl run nginx --image=nginx --restart=Never --dry-run -o yaml`

Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)
`kubectl create deployment --image=nginx nginx --dry-run -o yaml > nginx-deployment.yaml`

## Kubernetes commands and argurments

Override in `pod-definiton.yml`
ENTRYPOINT ["sleep"] -> command: ["sleep"]
CMD ["5"] -> args: ["10"]
