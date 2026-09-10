# Automated Cloud Infrastructure Provisioning Pipeline

An end-to-end Infrastructure as Code (IaC) and automated configuration management pipeline that provisions AWS compute resources and configures an operational Apache web server without manual intervention.

---

## 🛠 Tech Stack

* **Cloud Provider:** AWS (EC2, VPC, Security Groups)
* **Infrastructure as Code (IaC):** Terraform (HCL, `hashicorp/aws` provider)
* **Configuration Management:** Ansible (Playbooks, dynamic/static inventory)
* **Web Server:** Apache HTTP Server
* **Operating System:** Linux (Ubuntu/Debian)
* **Version Control:** Git & GitHub
* **Networking & Security:** SSH (`.pem` key authentication, strict `chmod 400` permissions)

---

## 🔄 Project Workflow
[ Developer ]
│
▼

Terraform Phase
├── Define resources (main.tf, variables.tf)
├── Initialize provider (terraform init)
├── Generate execution plan (terraform plan)
└── Apply infrastructure (terraform apply)
│
▼
[ AWS Cloud ]
├── Security Group (web_sg: Allow SSH:22, HTTP:80)
└── EC2 Instance (aws_instance.web)
│
▼
Terraform Outputs: Public IP (e.g., 13.235.78.124)
│
▼

Ansible Phase
├── Target host using public IP in inventory
├── Authenticate via SSH Key (chmod 400 my-key.pem)
└── Execute Playbook (ansible-playbook playbook.yml)
│
├── [Task 1] Gather System Facts
├── [Task 2] Update Package Repositories (apt/yum)
├── [Task 3] Install & Enable Apache Web Server
└── [Task 4] Deploy custom index.html
│
▼
[ Automated Environment Ready / Live Web Application ]


---
The Workflow Architecture
[ Terraform ] ---> Provisions Cloud Infrastructure (e.g., AWS EC2, Security Groups)
     │
     └───> Outputs IPs / Generates Inventory
             │
             ▼
[ Ansible ] ----> Configures OS, Installs Packages, & Deploys Application
## 🚀 Execution Guide

### Prerequisites
* AWS CLI installed and configured (`aws configure`)
* Terraform installed (`>= v1.0.0`)
* Ansible installed on the control machine
* An active SSH private key pair (`.pem`)

### Step 1: Provision Cloud Infrastructure (Terraform)
```bash
# Clone the repository
git clone [https://github.com/Parmitadhara/ansible-project.git](https://github.com/Parmitadhara/ansible-project.git)
cd ansible-project/terraform

# Initialize Terraform plugins
terraform init

# Review execution plan
terraform plan

# Deploy resources to AWS
terraform apply -auto-approve
Take note of the dynamic public IP address returned in the terminal output.

Step 2: Configure Server (Ansible)
Bash
cd ../ansible

# Secure SSH private key
chmod 400 path/to/your-key.pem

# Update inventory file with the Terraform-generated public IP
# Run the Ansible Playbook
ansible-playbook -i inventory.ini playbook.yml --private-key path/to/your-key.pem
Step 3: Verify Deployment
Open your browser and navigate to the public IP address:

http://<YOUR_EC2_PUBLIC_IP>
You should see the deployed web page served by Apache.

🛡️ Repository Best Practices
State Management: .gitignore excludes local state files (terraform.tfstate*) to prevent sensitive data leaks.

Provider Cleanliness: Cached binary dependencies (.terraform/ directories and plugins) are untracked to keep repository sizes minimal.

Idempotency: Re-running the Ansible playbook ensures no drift and guarantees state consistency across multiple executions.


