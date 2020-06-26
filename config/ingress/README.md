service-NodePort: 80/443
-> Ingress Controller (deployment)
    -> nginx-config (ConfigMap)
-> IngressRules (Ingress)
-> App Services (Service)
Port -> Controller/LB -> IngressRules -> Service

- A deployment to create the nginx controller
- A service to expose it
- a Config map to configure
- a service account to grant permissions to access all these objects
