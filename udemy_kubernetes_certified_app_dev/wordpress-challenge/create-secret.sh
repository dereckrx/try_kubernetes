# Create the secret:
kubectl create secret generic mysql-pass --from-literal=password=admin

# Create wordpress pv
kubectl create -f wordpress-pv.yml

# Create wordpress pv claim
kubectl create -f wordpress-pvc.yml

# Create mysql pv
kubectl create -f mysql-pv.yml

# Cretae mysql pv claim
kubectl create -f mysql-pvc.yml

# Create mysql deploy
kubectl create -f mysql-deploy.yml

# Create wordpress-mysql service
kubectl create -f wordpress-mysql-svc.yml

# Create wordpress deploy
kubectl create -f wordpress-deploy.yml

# Create wordpress service
kubectl create -f wordpress-svc.yml
