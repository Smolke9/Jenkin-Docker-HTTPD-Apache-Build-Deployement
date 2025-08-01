
# 🚀 Apache (httpd) Docker Deployment using Jenkins Freestyle on AWS EC2

This guide provides step-by-step instructions to deploy an Apache HTTP Server (httpd) Docker container using Jenkins Freestyle Job, GitHub, and Docker on an AWS EC2 Ubuntu instance.

---

## 🧰 Prerequisites

- ✅ AWS EC2 instance (Ubuntu)
- ✅ Docker installed
- ✅ Jenkins installed
- ✅ Jenkins user added to `docker` group
- ✅ GitHub repository with Dockerfile and index.html

---

## 📁 GitHub Repository Structure

```
httpd-docker/
├── Dockerfile
├── site/
│   └── index.html
└── README.md (optional)
```

---

## 📄 Dockerfile

```
FROM httpd:latest
COPY site/ /usr/local/apache2/htdocs/
EXPOSE 80
```

---

## 🌍 index.html (inside `site/` folder)

```
<!DOCTYPE html>
<html>
<head>
  <title>Apache Deployment</title>
</head>
<body>
  <h1>✅ Deployed via Jenkins & Docker on Apache Server</h1>
</body>
</html>
```

---

## 🖥️ EC2 Setup

### 1. SSH into your EC2 instance

```
ssh -i your-key.pem ubuntu@your-ec2-public-ip
```

### 2. Install Docker

```
sudo apt update
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
```

### 3. Install Jenkins

```
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install openjdk-11-jdk jenkins -y
```

Start Jenkins:

```
sudo systemctl start jenkins
```

Enable Docker for Jenkins:

```
sudo usermod -aG docker jenkins
sudo reboot
```

---

## 🔧 Jenkins Freestyle Job Setup

### 1. Open Jenkins UI
Access Jenkins: `http://<EC2_PUBLIC_IP>:8080`

### 2. Create a new Freestyle Job

- Go to **Dashboard** → **New Item**
- Name: `Apache-Docker-Deploy`
- Type: **Freestyle project**

### 3. Configure Git

Under **Source Code Management**:

- Select: `Git`
- Repo URL: `https://github.com/<your-username>/<your-repo>.git`
- Add credentials (if private repo)

### 4. Add Build Step → Execute Shell

Paste the following:

```
echo "🧹 Cleaning up old container..."
docker rm -f apache-container || true

echo "🔧 Building Docker image..."
docker build -t apache-image .

echo "🚀 Running Apache container on port 80..."
docker run -d -p 80:80 --name apache-container apache-image

echo "✅ Deployed! Visit http://<EC2_PUBLIC_IP>:80"
```

> Replace `<EC2_PUBLIC_IP>` with your instance's public IP address

---

## 🧪 Test Deployment

Visit: `http://<EC2_PUBLIC_IP>`

You should see:
```
✅ Deployed via Jenkins & Docker on Apache Server
```

---

## 🛠️ Troubleshooting

- Ensure Jenkins user is in the Docker group
- Restart Jenkins and Docker if needed
- Check EC2 security group rules (allow port 80)
- Use `docker ps -a` to debug container state

---

## ✅ Done!
You’ve now deployed a static website using Apache Docker container with Jenkins on AWS EC2.
