# Infrastructure Setup (Terraform on AWS Free Tier)

## 📌 Overview
This document details the setup of AWS infrastructure using Terraform, ensuring best practices, modularity, and **zero-cost** deployment using AWS Free Tier.

## 🚀 Why These Services?
To ensure **scalability, security, and efficiency**, we chose the following AWS services:

### **1️⃣ Amazon EKS (Elastic Kubernetes Service)**
✅ **Why?**
- Manages Kubernetes clusters without the need for self-hosted control planes.
- Integrates with AWS IAM, making it highly secure.
- Ensures **auto-scaling, high availability, and cost-efficiency** with Free Tier options.

### **2️⃣ Amazon RDS (Relational Database Service - PostgreSQL)**
✅ **Why?**
- Provides **managed PostgreSQL with automatic backups**.
- Eliminates maintenance overhead, ensuring **high reliability**.
- Uses AWS Free Tier with **`db.t3.micro` instance** and **20GB storage**.

### **3️⃣ Amazon S3 (Simple Storage Service)**
✅ **Why?**
- Highly scalable **object storage** with **encryption and versioning**.
- Stores **logs, artifacts, and backups securely**.
- Uses AWS Free Tier **first 5GB free**.

### **4️⃣ AWS IAM (Identity & Access Management)**
✅ **Why?**
- **Secures access to AWS resources** using fine-grained role-based policies.
- Allows EKS, RDS, and S3 to interact securely.
- Best practice to **follow least privilege principles**.

---

## 📂 Folder Structure
To maintain **modularity, reusability, and scalability**, we structured the Terraform files as follows:

```plaintext
📂 infrastructure/
├── main.tf                      # Root Terraform configuration
├── variables.tf                 # Global variables
├── outputs.tf                   # Global outputs
├── providers.tf                 # AWS Provider configuration
├── modules/
│   ├── eks/
│   │   ├── main.tf              # EKS Cluster configuration
│   │   ├── variables.tf         # Variables for EKS
│   │   ├── outputs.tf           # EKS Outputs
│   ├── iam/
│   │   ├── main.tf              # IAM Roles & Policies
│   │   ├── variables.tf         # IAM Variables
│   │   ├── outputs.tf           # IAM Outputs
│   ├── rds/
│   │   ├── main.tf              # RDS Database configuration
│   │   ├── variables.tf         # RDS Variables
│   │   ├── outputs.tf           # RDS Outputs
│   ├── s3/
│   │   ├── main.tf              # S3 Bucket configuration
│   │   ├── variables.tf         # S3 Variables
│   │   ├── outputs.tf           # S3 Outputs
```

---

## 🛠 Setting Up Terraform
### **1️⃣ Install Terraform & AWS CLI**
Ensure Terraform and AWS CLI are installed.
```sh
terraform -version  # Verify Terraform installation
aws configure       # Set AWS credentials
```

### **2️⃣ Initialize Terraform**
```sh
cd infrastructure/
terraform init
```

### **3️⃣ Plan & Apply Infrastructure**
```sh
terraform plan  # Preview changes
terraform apply --auto-approve  # Deploy infrastructure
```

---

## 📌 Module Breakdown
### **1️⃣ EKS Cluster Setup (`modules/eks/`)**
✅ Creates an **EKS cluster** with:
- Managed worker nodes (Free Tier eligible `t3.micro` instances).
- IAM role allowing Kubernetes API access.

### **2️⃣ IAM Roles (`modules/iam/`)**
✅ Provisions IAM roles for:
- **EKS Cluster** – Grants AWS access to Kubernetes.
- **EKS Nodes** – Allows nodes to join the cluster.
- **S3 & RDS Access** – Restricts permissions using **least privilege principle**.

### **3️⃣ RDS Database (`modules/rds/`)**
✅ Deploys a **PostgreSQL database** with:
- **Private subnets** ensuring security.
- **AWS Secrets Manager** storing credentials securely.
- Free Tier-compatible instance (`db.t3.micro`).

### **4️⃣ S3 Bucket (`modules/s3/`)**
✅ Creates an **S3 bucket** for logs and backups with:
- **Versioning & Encryption** enabled.
- **Lifecycle policy** for cost-efficient long-term storage.

---

## ✅ Next Steps
- ✅ **Deploy Terraform infrastructure (`terraform apply`)**
- 🔜 **Configure Kubernetes & Deploy Microservices (Next Phase)**
- 📄 **Document CI/CD Pipeline & Kubernetes Setup**

🚀 **Your AWS infrastructure is now deployed & ready!**
