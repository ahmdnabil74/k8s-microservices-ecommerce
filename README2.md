# E-Commerce Microservices Application

#### tools
- Kubernetes
- Amazon EKS
- Terraform
- ArgoCD
- GitHub Actions
- Docker
- GitOps

#### 5 microsevices
- ##### UI Service
    - site is used by user 
    - (Java) 
- ##### Catalog:
    - GO , DB and api of products : return data of product: name , price , type 
- ##### Cart: 
    - store products that user want to buy it : add , remove show cart 
    - Java, mongodb: it's suitable to store flexible data
- ##### Order:
    - after choosing the order => create, save and follow order 
    - Java, PostgreSQL: used for orders => suitable for transactions, orders, data integrity
- ##### Checkout: 
    - last stage before buying: collect data of cart and calculate the all 
    - (JavaScript / Node.js)


### phase 1 : TERRAFORM
``` sh 
terraform init
terraform plan
terraform apply -target="module.vpc" --auto-approve
terraform apply -target="module.retail_app_eks" --auto-approve
```
### phase 2 : EKS
``` sh 
#configure kubectl
aws eks update-kubeconfig --region eu-central-1 --name retail-store-eks-cluster-22bl

#CHECK PODS AND NODES THAT NO RESOURCES
kubectl get nodes
kubectl get podes -A 

#apply entire infrastructure
terraform apply --auto-approve
```

## MAINFEST FILE
- mainfest fiels in k8s is a yaml files used to describe the desired state : deployment for 3 pods, service, ingreess
- argocd is use gitops => Git Repository = Source of Truth
- all mainfest files put in repo and argocd watch repos 
- any changes in manifests, argocd will apply it automatic on k8s cluster
- developer => edit manifests => push on github => argocd see changes => pull new manifests => kubectl apply automatic => update cluster


## phase 3 : install argocd
- get link of argocd from terraform output
- get password : kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | %{ [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($_)) }


## phase 4 : monitoring
- get link from terraform output
