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
    - DB and api of products : return data of product: name , price , type 
    - (go)
    
- ##### Cart: 
    - store products that user want to buy it : add , remove show cart 
    - (Java)
    - mongodb: it's suitable to store flexible data
- ##### Order:
    - after choosing the order => create, save and follow order 
    - (Java)
    - PostgreSQL: used for orders => suitable for transactions, orders, data integrity
- ##### Checkout: 
    - last stage before buying: collect data of cart and calculate the all 
    - (JavaScript / Node.js)
    - 

