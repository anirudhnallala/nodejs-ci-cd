# Node.js CI/CD with Kubernetes and GitHub Actions

![CI/CD Workflow](https://img.shields.io/github/actions/workflow/status/anirudhnallala/nodejs-ci-cd/main.yml?branch=main)
![Docker Pulls](https://img.shields.io/docker/pulls/anirudhnallala/nodejs-ci-cd)

## 🚀 Project Overview
This project demonstrates a **CI/CD pipeline** for a Node.js application using **GitHub Actions, Docker, and Kubernetes**. The application is automatically built, tested, and deployed to a Kubernetes cluster whenever new changes are pushed to the `main` branch.

## 🏗️ Tech Stack
- **Node.js** (Express.js)
- **Docker** (Containerization)
- **GitHub Actions** (CI/CD)
- **Kubernetes** (Orchestration)
- **Minikube** (Local Kubernetes cluster)
- **KVM2 Driver** (Minikube backend)

---

## 📂 Folder Structure
```
📦 nodejs-ci-cd
├── 📂 k8s                    # Kubernetes manifests
│   ├── deployment.yml        # Kubernetes Deployment
│   ├── service.yml           # Kubernetes Service
├── .github/workflows
│   ├── main.yml              # GitHub Actions Workflow
├── 📜 Dockerfile              # Dockerfile for containerizing the app
├── 📜 .gitignore               # Git ignored files
├── 📜 package.json            # Node.js dependencies
├── 📜 package-lock.json       # Lockfile
├── 📜 README.md               # Project documentation
```

---

## 🚀 Getting Started

### 1️⃣ Prerequisites
Make sure you have the following installed:
- [Node.js](https://nodejs.org/en/download/)
- [Docker](https://www.docker.com/get-started)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)

---

### 2️⃣ Local Development

#### Clone the repository:
```sh
git clone https://github.com/anirudhnallala/nodejs-ci-cd.git
cd nodejs-ci-cd
```

#### Install dependencies:
```sh
npm install
```

#### Run the application locally:
```sh
npm start
```
App will be available at: **http://localhost:3000**

---

### 3️⃣ Docker Setup
#### Build and run the Docker container:
```sh
docker build -t nodejs-ci-cd .
docker run -p 3000:3000 nodejs-ci-cd
```

App will be available at: **http://localhost:3000**

---

### 4️⃣ Kubernetes Deployment

#### Start Minikube:
```sh
minikube start --driver=kvm2
```

#### Deploy the application:
```sh
kubectl apply -f k8s/deployment.yml
kubectl apply -f k8s/service.yml
```

#### Get the service URL:
```sh
minikube service nodejs-service --url
```

#### Expose using NodePort:
```sh
kubectl patch svc nodejs-service -p '{"spec":{"type":"NodePort"}}'
```

Check Minikube's external IP:
```sh
minikube ip
```
Then access the app at:
```
http://<minikube-ip>:<NodePort>
```

---

## 🔄 CI/CD Pipeline (GitHub Actions)
This project uses **GitHub Actions** for automated CI/CD:
- **On push to `main` branch:**
  - Builds and tests the Node.js app
  - Builds and pushes Docker image to **Docker Hub**
  - Deploys the updated image to Kubernetes

### 📜 Workflow File (`.github/workflows/main.yml`)
#### **Steps:**
1. Checkout repository
2. Install Node.js and dependencies
3. Build and push Docker image
4. Deploy to Kubernetes using `kubectl`

You can find the workflow file **[here](.github/workflows/main.yml)**.

---

## 🛠️ Troubleshooting

### ❌ NodePort Not Working?
If you are unable to access the app via NodePort, try these steps:
1. Ensure Minikube is running: `minikube status`
2. Get Minikube's IP: `minikube ip`
3. Check NodePort: `kubectl get svc nodejs-service -o=jsonpath='{.spec.ports[0].nodePort}'`
4. Access the app at: `http://<minikube-ip>:<nodeport>`

### ❌ Minikube Issues with KVM2?
If Minikube fails to start with KVM2:
```sh
minikube delete
minikube start --driver=kvm2
```

---

## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙌 Contributing
Pull requests are welcome! Feel free to fork the repository and submit a PR.

---

## 📧 Contact
👤 **Anirudh Nallala**
- GitHub: [@anirudhnallala](https://github.com/anirudhnallala)
- Docker Hub: [anirudhnallala](https://hub.docker.com/u/anirudhnallala)

---

⭐ **If you found this project useful, please consider giving it a star!** ⭐

