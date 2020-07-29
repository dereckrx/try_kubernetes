# State Persistance

* k exec -it webapp cat /log/app.log
* k get pvc # persistentvolumeclaim
* k get pv # persistentvolume

* pod: has a pvClaim
* pvClaim: has spec requirements for volume
* volume: has spec (accessMode, capacity, host or 3rd party info)
* pvClaim -> requirements mapped to available volumes -> volume

## Volumes

```yaml
# Mount and write data to:
# -> /opt (in container) 
# -> data-volume 
# -> /data (on host)
spec: 
  container:
    - name: alpine
      ...
      volumeMounts: 
        - mountPath: /opt
          name: data-volume
  volumes: 
    - name: data-volume
      hostPath: 
        path: /data
        type: Directory
```


```yaml
# Using a persistent volume claim for volume
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim
```

## PersistentVolume
resource

`persistentVolumeReclaimPolicy`
- Retain: kept after claim deletion, but not reused
- Delete: deleted when claim is deleted
- Recycle: clear data and allow reclaim

```yaml
spec: 
  accessModes:
    - ReadWriteOnce
  capacity: 
    storage: 1Gi
  awsElasticBlockStore:
    volumeID: <volume-id>
    fsType: est4
```
```yaml
apiVersion: v1
kind: PersistentVolume
metadata: 
  name: pv-vol1
spec: 
  accessModes:
    - ReadWriteOnce
  capacity: 
    storage: 1Gi
  hostPath:
    path: /tmp/data
```

## Persistent Volume Claim
Resource

- claims our bound to volumes

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata: 
  name: myclaim
spec:
  accessModes: 
    - ReadWriteOnce
  resources: 
    requests: 
      storage: 50Mi

```
