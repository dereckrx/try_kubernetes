app_secret.properties
```
DB_Host: mysql
DB_User: root
DB_Password: paswrd
```

kubectl create secret generic \
app-secret --from-literal=DB_Host=mysql

kubectl create secret generic \
app-secret --from-file=app_secret.properties
