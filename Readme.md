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
