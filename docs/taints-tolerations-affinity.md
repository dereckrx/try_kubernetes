## Overview

* Node Taint: (Node) keep away from me
* Pod Toleration: (Pod) You smell but I can tolerate it
* Node Selector: (Pod) I'm looking for key=value
* Node Affinity: (Pod) Here are my preferences


## Taints & Tolerations
Taints are placed on Nodes
* master node starts with a taint "master"

Tolerations are defined in Pods

## Node selectors
Use basic label key-value pairs for simple assignments

nodeSelector: 
    <label-key>: <label-value>

## Node affinity 

Use for more complex operations. ex: 
- label Exists on Node (doesn't care about value)
- label In [Large, Medium]
- label NotIn [Small]


taint colors with colored=true
add toleration to all colored pods for color=true
add node selectors for colors where "color=blue" etc