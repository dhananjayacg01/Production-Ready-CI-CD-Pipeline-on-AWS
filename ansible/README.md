# Ansible Configuration Management

This directory contains Ansible automation used to configure an application server and deploy the containerized application.

## Architecture

```text
                    Ansible Control Node
                            |
                            | SSH
                            v
                     Application Server
                            |
                    +-------+-------+
                    |               |
               Install Docker    Install Git
                    |
                    v
              Pull Docker Image
                    |
                    v
              Run Application
                    |
                    v
             Production Web App
```

## Project Structure

```text
ansible/
├── ansible.cfg
├── inventory
├── playbook.yml
├── vars.yml
└── README.md
```

## File Descriptions

### ansible.cfg

Contains Ansible configuration settings such as:

* Inventory location
* Remote user
* Python interpreter
* SSH host key checking

### inventory

Defines the servers managed by Ansible.

The current inventory is a template and uses `YOUR_SERVER_IP` because this portfolio project is not connected to a live AWS environment.

### playbook.yml

Automates application server configuration and deployment.

The playbook performs the following tasks:

1. Updates the APT package cache.
2. Installs Docker and Git.
3. Starts and enables the Docker service.
4. Pulls the application Docker image from Docker Hub.
5. Removes any existing application container.
6. Starts the latest application container.

### vars.yml

Contains configurable deployment values such as:

* Docker image name
* Container name
* Host port
* Container port

## Docker Image

The application image used by the playbook is:

```text
dhananjaya01/production-cicd-app:v1
```

The application is exposed using:

```text
Host Port: 8080
Container Port: 80
```

## Deployment Flow

```text
GitHub
   |
   v
Docker Image
   |
   v
Docker Hub
   |
   v
Ansible
   |
   v
Application Server
   |
   v
Docker Container
   |
   v
Web Application
```

## Running the Playbook

After configuring a real application server and updating the inventory, the playbook can be executed using:

```bash
ansible-playbook -i inventory playbook.yml
```

If an SSH private key is required:

```bash
ansible-playbook -i inventory playbook.yml --private-key ~/.ssh/my-key.pem
```

## Security Considerations

The following practices should be followed in a production environment:

* Do not commit private SSH keys to GitHub.
* Do not store passwords or secrets directly in YAML files.
* Use Ansible Vault or a secure secrets manager for sensitive information.
* Restrict SSH access to trusted IP addresses.
* Use least-privilege access wherever possible.
* Use versioned Docker image tags instead of relying only on `latest`.

## Project Limitation

This portfolio project does not connect to a live AWS environment because no AWS account is being used.

The Terraform and Ansible configurations are maintained as infrastructure and automation code to demonstrate DevOps skills and production-oriented project organization.

The configurations can be connected to a real environment by providing valid infrastructure and server credentials.

