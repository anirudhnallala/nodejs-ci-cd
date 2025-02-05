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


### **2. Dockerfile**
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
