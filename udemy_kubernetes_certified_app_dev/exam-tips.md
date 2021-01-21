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
`k config set-context mycontext --namespace=mynamespace`

What resources am I allowed to access during my exam?
Candidates may use their Chrome or Chromium browser to open one additional tab in order to
access assets at: https://kubernetes.io/docs/, https://github.com/kubernetes/,
https://kubernetes.io/blog/ and their subdomains.

20% – Pod Design
18% – Configuration
18% – Observability
13% – Core Concepts
13% – Services & Networking
10% – Multi-Container Pods
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

## vi commands
^ start line
$ end line
D delete to end of line
u Undo last change
:set nu  set line numbers

vi ~/.vimrc
```bash
set nu # line number
set expandtab #  use tabs instead of spaces 
set tabstop=2 # max tab width in spaces
set shiftwidth=2 # Size of indent in spaces
set list # show all whitespace chars
```

## Commands 
https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad

alias k=kubectl

At the start of each task you'll be provided with the command to ensure you are on the correct cluster to complete the task.
k config set-context mycontext --namespace=mynamespace # Run this on every question

kubectl explain cronjob.spec.jobTemplate --recursive
man if_exam # exam tips during exam
sudo -i // Assume elevated privileges on any node

Nodes making up each cluster can be reached via ssh, using a command such as the following:
ssh <node-name>

You must return to the base node (hostname node-1) after completing each task.

## Unix on-liners
args: ["-c", "while true; do date >> /var/logs/app.txt; sleep 5; done"]
args: [/bin/sh, -c, 'i=0; while true; do echo "$i: $(date)"; i=$((i+1)); sleep 1; done']
args: ["-c", "mkdir -p collect; while true; do cat /var/data/* > /collect/data.txt; sleep 10; done"]

a=10;b=5; if [ $a -le $b ]; then echo "a is small"; else echo "b is small"; fi
x=1; while [$x -le 10]; do echo "welcome $x times"; x=$((x+1)); done
