# State Persistance

pod: 
-> has a pvClaim
  pvClaim: 
  -> has spec requirements for volume

volume: 
-> has spec (accessMode, capacity, host or 3rd party info)

pvClaim -> requirements mapped to available volumes -> volume

## Volumes

Pod mounts directly to volume:

-> /opt (in container) which is where the 'data-volume' is mounted
  -> data-volume 
    -> /data (on host) where the data ends up

OR Pod mounts volume via a claim:

-> /opt (in container) which is where the 'data-volume' is mounted
  -> data-volume 
    -> pv claim maps to 'pv-vol1'
      -> pv-vol1
        -> /data (on host)

```yaml
# POD yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec: 
  container:
    - name: myfrontend
      image: nginx
      volumeMounts: 
        - mountPath: /opt # or whatever ex: "/var/www/html"
          name: data-volume # <- match to volume spec
  # Mounted directly
  volumes: 
    - name: data-volume # <-  ^ so data written to /opt with go to /data
      hostPath: 
        path: /data
        type: Directory
  # OR Using a persistent volume claim for volume
  volumes:
    - name: data-volume
      persistentVolumeClaim:
        claimName: myclaim
```

## Persistent Volume Claim

- claims are bound to volumes

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

## PersistentVolume

`persistentVolumeReclaimPolicy`
- Retain: kept after claim deletion, but not reused
- Delete: deleted when claim is deleted
- Recycle: clear data and allow reclaim

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
  # with AWS
  awsElasticBlockStore:
    volumeID: <volume-id>
    fsType: est4
  # or with HostPath
  hostPath:
    path: /data
```
