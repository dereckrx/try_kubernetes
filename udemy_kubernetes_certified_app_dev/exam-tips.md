## Exam link
https://www.cncf.io/certification/ckad/
Tips Video: https://www.youtube.com/watch?v=rnemKrveZks&feature=youtu.be

K8s version: 1.18

Make sure you can succeed the Lightning Labs with at least 80% correct

Make sure you can succeed the Mock Tests with at least 90% correct

## Time management
2 hours
19 questions
66% needed to pass

can skip and come back
dont waste time debugging more than twice

understand how the documentation is layout

run the context command at the top of each question

What resources am I allowed to access during my exam?
Candidates may use their Chrome or Chromium browser to open one additional tab in order to
access assets at: https://kubernetes.io/docs/, https://github.com/kubernetes/,
https://kubernetes.io/blog/ and their subdomains.

13% – Core Concepts
18% – Configuration
10% – Multi-Container Pods
18% – Observability
20% – Pod Design
13% – Services & Networking
8% – State Persistence

## Pivots Recomendations
https://docs.google.com/presentation/d/1-WkSvLI_pe9RqLIVSDNnczM8srFnB4TgVwGYl_em2IU/edit#slide=id.p

Use imperative commands 
- (when you can)
- Some resources cannot be created this way (e.g. pv, pvc, network policy...)
- Learn which ones!

Look at the question weight
If it’s low and there is lots of text, mark it and come back to it later
If you think you can do it, try it out
If it’s still not working after multiple tries, mark it and come back to it later
If you think it’s hard mark it right away, don’t try it


## Shortcuts
po: pods
rs: repicasets
deploy: deployments
svc: services
ns: namespace
netpol: network policies
pv: persistant volume
pvc: persistent volume claims
sa: service account

-n namespace

## vi commands
^ start line
$ end line
D delete to end of line

vi ~/.vimrc
```bash
set nu
set expandtab
set list
set shiftwidth=2
set tabstop=2
```

## Commands 
alias k=kubectl
k config set-context mycontext --namespace=mynamespace
kubectl expalain cronjob.spec.jobTemplate --recursive
man if_exam # exam tips during exam
sudo -i
ssh <node-name>

k run nginx --image=nginx (deployment)
k run nginx --image=nginx --restart=Never (pod)
k run nginx --image=nginx --restart=OnFailure (job)
k run nginx --image=nginx --restart=OnFailure --schedule="* * * * *" (cronjob)

k run nginx --image=nginx --restart=Never 
--port=80 
--namespace=myname 
--command
--serviceaccount=mysql
--env=HOSTNAME=local
--labels=bu=finance,env=dev
--requests='cpu=100m,memory=256Mi'
--limits='cpu=200m,memory=512Mi'
--dry-run -o yaml
-- /bin/sh -c 'echo hellow world'

k run frontent --replicas=2 
--labels=run=load-balancer-example 
--image=busybox
--port=8080

k expose deployment frontend --type=NodePort 
--name=frontent-service --port=6262 --target-port=8080

k set serviceaccount deployment frontend myuser
k create service clusterip my-cs --tcp=5678:8080 --dry-run -o yaml

## Unix on-liners
args: ["-c", while true; do date >> /var/logs/app.txt; sleep 5; done"]
args: [/bin/sh, -c, 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done']
args: ["-c", "mkdir -p collect; while true; do cat /var/data/* > /collect/data.txt; sleep 10; done"]

a=10;b=5; if [ $a -le $b ]; then echo "a is small"; else echo "b is small"; fi
x=1; while [$x -le 10]; do echo "welcome $x times"; x=$((x+1)); done



## Kubectl reference
cheatsheet and imperative commands without yaml