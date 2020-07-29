## Literal 

kubectl create secret generic \
app-secret --from-literal=DB_Host=mysql

Outputs
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  DB_Host: bXlzcWw=
```

## Using properties file

app_secret.properties
```
DB_Host: mysql
DB_User: root
DB_Password: paswrd
```

kubectl create secret generic \
app-secret --from-file=app_secret.properties

