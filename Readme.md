README.md
markdown
Copy
Edit
# Node.js CI/CD Pipeline with Kubernetes and GitHub Actions

This repository demonstrates a **CI/CD pipeline** for a Node.js application using **GitHub Actions**, **Docker**, **Minikube**, and **Kubernetes**. The project is built, tested, and deployed automatically upon pushing changes to the `main` branch.

## Prerequisites

Ensure you have the following tools installed:

- [Docker](https://docs.docker.com/get-docker/)
- [Minikube](https://minikube.sigs.k8s.io/docs/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [GitHub Account](https://github.com/)
- [Jenkins](https://www.jenkins.io/doc/book/installing/) (optional, if you intend to use Jenkins)

## Project Setup

### 1. Clone the repository

```bash
git clone https://github.com/anirudhnallala/nodejs-ci-cd.git
cd nodejs-ci-cd
2. Dockerfile
The application is containerized using Docker. The Dockerfile defines how the application is built into a container.

dockerfile
Copy
Edit
# Use the official Node.js runtime as the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container's working directory
COPY package*.json ./

# Install the application dependencies
RUN npm install

# Copy the rest of the application files into the container
COPY . .

# Expose port 3000 for the app to listen on
EXPOSE 3000

# Define the command to run the app (npm start will run the server)
CMD ["npm", "start"]
3. Kubernetes Setup with Minikube
We are using Minikube to create a local Kubernetes cluster for testing. The cluster will host the Node.js application.

deployment.yml
This file defines how the application is deployed in Kubernetes.

yaml
Copy
Edit
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodejs-app
  template:
    metadata:
      labels:
        app: nodejs-app
    spec:
      containers:
        - name: nodejs-app
          image: anirudhnallala/nodejs-ci-cd:latest
          ports:
            - containerPort: 3000
service.yml
This file defines how the application is exposed inside the Kubernetes cluster using a ClusterIP service.

yaml
Copy
Edit
apiVersion: v1
kind: Service
metadata:
  name: nodejs-service
spec:
  selector:
    app: nodejs-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
  type: ClusterIP
4. CI/CD Pipeline with GitHub Actions
The CI/CD pipeline is defined in the .github/workflows/ci-cd.yml file. It automatically builds the Docker image, pushes it to DockerHub, and deploys the application to the Kubernetes cluster when changes are pushed to the main branch.

GitHub Actions Workflow
yaml
Copy
Edit
name: CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Set up Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'

      - name: Install dependencies
        run: npm install

      - name: Build Docker image
        run: |
          docker build -t ${{ secrets.DOCKER_USERNAME }}/nodejs-ci-cd:latest .
          docker images  # Verify the image exists locally

      - name: Debug Docker Username
        run: echo "DOCKER_USERNAME=${{ secrets.DOCKER_USERNAME }}"

      - name: Login to Docker Hub
        run: |
          docker login -u ${{ secrets.DOCKER_USERNAME }} -p ${{ secrets.DOCKER_PASSWORD }}

      - name: Push Docker image to DockerHub
        run: |
          echo "Pushing Docker image to DockerHub"
          docker push ${{ secrets.DOCKER_USERNAME }}/nodejs-ci-cd:latest

  deploy:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v2

      - name: Install Minikube
        run: |
          curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
          chmod +x minikube
          sudo mv minikube /usr/local/bin/
          minikube start --driver=docker
          echo "Minikube started!"

      - name: Set up kubectl
        uses: azure/setup-kubectl@v1
        with:
          version: 'latest'

      - name: Configure kubectl for Minikube
        run: |
          minikube update-context
          kubectl cluster-info
          echo "Kubeconfig updated!"

      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f k8s/deployment.yml
          kubectl apply -f k8s/service.yml

      - name: Verify Deployment
        run: |
          kubectl get pods
          kubectl get services
5. Running the Application Locally
To run the Node.js application locally in a Docker container:

Build the Docker image:

bash
Copy
Edit
docker build -t nodejs-ci-cd .
Run the container:

bash
Copy
Edit
docker run -p 3000:3000 nodejs-ci-cd
Visit http://localhost:3000 in your browser to see the application.

6. Deploying the Application to Kubernetes
Once the GitHub Action workflow is triggered (on pushing to the main branch), it will:

Build the Docker image.
Push the Docker image to DockerHub.
Deploy the application to the Minikube cluster.
Expose the service via the ClusterIP.
You can access the application in Minikube by using kubectl port-forward.

bash
Copy
Edit
kubectl port-forward service/nodejs-service 8080:80
Then, access the application in your browser at http://localhost:8080.

7. Troubleshooting
Minikube IP: If you have issues with accessing the application, check if Minikube’s IP is correctly configured:

bash
Copy
Edit
minikube ip
Port Forwarding: If the service is not exposed properly, use port forwarding as mentioned above.

License
This project is licensed under the MIT License - see the LICENSE file for details.

yaml
Copy
Edit

---

### Customizations

- Replace `DOCKER_USERNAME` and `DOCKER_PASSWORD` in your GitHub secrets.
- You can extend the troubleshooting section based on your environment.
- Adjust any file paths and names if they differ from what's in the repo.

Let me know if you need any further tweaks or additions!
