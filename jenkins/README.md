# Jenkins CI/CD Pipeline

This directory contains the Jenkins CI/CD pipeline configuration for the Production-Ready CI/CD Pipeline project.

The Jenkins pipeline automates the process of validating application code, building a Docker image, testing the container, and publishing the image to Docker Hub.

## CI/CD Architecture

```text
Developer
    |
    | git push
    v
GitHub Repository
    |
    | Jenkins Pipeline Trigger
    v
Jenkins
    |
    +----------------------+
    |                      |
    v                      v
Checkout Code         Validate Application
    |                      |
    +----------+-----------+
               |
               v
        Build Docker Image
               |
               v
        Run Container Test
               |
          +----+----+
          |         |
        Pass       Fail
          |         |
          v         v
    Push Image    Stop Pipeline
          |
          v
      Docker Hub
```

## Pipeline Stages

The Jenkins pipeline contains the following stages:

### 1. Checkout

Jenkins checks out the latest source code from the GitHub repository.

### 2. Validate Application

The pipeline validates that required application files exist:

* `app/index.html`
* `Dockerfile`

### 3. Build Docker Image

Jenkins builds a Docker image using the project's Dockerfile.

The image is tagged with the Jenkins build number.

Example:

```text
dhananjaya01/production-cicd-app:15
```

The image is also tagged as:

```text
dhananjaya01/production-cicd-app:latest
```

### 4. Run Container Test

Jenkins starts a temporary Docker container and sends an HTTP request to verify that the application is responding successfully.

If the test fails, the pipeline stops.

### 5. Push Docker Image

After successful validation and testing, Jenkins authenticates with Docker Hub using Jenkins Credentials and pushes the Docker image.

The pipeline publishes:

```text
dhananjaya01/production-cicd-app:<BUILD_NUMBER>
```

and:

```text
dhananjaya01/production-cicd-app:latest
```

## Jenkins Credentials

Docker Hub credentials should be stored securely in Jenkins.

The pipeline expects a Jenkins credential with the ID:

```text
dockerhub-credentials
```

The credential should be configured as a username/password credential.

Credentials must not be hardcoded inside the Jenkinsfile.

## Required Jenkins Environment

The Jenkins agent running the pipeline requires:

* Jenkins
* Git
* Docker
* Docker CLI
* curl

The Jenkins user must also have permission to execute Docker commands.

## Pipeline Configuration

The pipeline is defined in:

```text
jenkins/Jenkinsfile
```

The Jenkins job should be configured as a Pipeline job and connected to the GitHub repository.

## CI/CD Flow

```text
Developer
    |
    | Push Code
    v
GitHub
    |
    v
Jenkins
    |
    +--> Checkout
    |
    +--> Validate
    |
    +--> Build Docker Image
    |
    +--> Run Container Test
    |
    +--> Push Image to Docker Hub
    |
    v
Docker Hub
```

## Future Deployment Integration

The next stage of the project will integrate the CI/CD pipeline with Ansible.

The future deployment flow will be:

```text
GitHub
    |
    v
Jenkins
    |
    +--> Build Docker Image
    |
    +--> Run Tests
    |
    +--> Push Image to Docker Hub
    |
    v
Ansible
    |
    v
Application Server
    |
    v
Pull Latest Docker Image
    |
    v
Run Application Container
```

## Security Best Practices

* Store Docker Hub credentials in Jenkins Credentials.
* Never hardcode passwords or access tokens in the Jenkinsfile.
* Use versioned Docker image tags.
* Use Jenkins credentials for external services.
* Restrict Jenkins access.
* Keep Jenkins and its plugins updated.
* Use HTTPS for Jenkins and GitHub integrations in production.

## Project Limitation

This portfolio project is designed to demonstrate CI/CD concepts without requiring an AWS account.

The Jenkins pipeline can be executed using a local Jenkins environment with Docker installed.

The deployment stage can later be connected to an actual server using Ansible.

