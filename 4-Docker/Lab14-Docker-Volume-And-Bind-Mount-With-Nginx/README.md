# Lab 14: Docker Volume and Bind Mount with Nginx

This lab demonstrates how to use Docker **Volumes** and **Bind Mounts** with an Nginx container to:
- Persist access logs to a Docker volume (`nginx_logs`)
- Serve a custom HTML file using a Bind Mount from the host

---

## 🧱 Steps

### 1. Create Project Folder and HTML File
```bash
mkdir -p ~/nginx-bind/html
echo "Hello from Bind Mount" > ~/nginx-bind/html/index.html
```

### 2. Create Volume for Logs
```bash
docker volume create nginx_logs
```

### 3. Run Nginx Container
```bash
docker run -d \
  --name nginx-server \
  -v nginx_logs:/var/log/nginx \
  -v /home/sherif/nginx-bind/html:/usr/share/nginx/html \
  -p 8080:80 \
  nginx
```
![Image](https://github.com/user-attachments/assets/180bec5e-a4a8-4aaa-91fb-9192c35105ae)
---

## 🌐 4. Verify Nginx is Serving HTML

```bash
curl localhost:8080
# Output:
# Hello from Bind Mount
```
![Image](https://github.com/user-attachments/assets/2c047183-cc38-434a-a1dd-04645be480fd)
---

### 5. Update the HTML and Verify Again

```bash
echo "Updated Bind Mount content" > ~/nginx-bind/html/index.html
curl localhost:8080
# Output:
# Updated Bind Mount content
```
![Image](https://github.com/user-attachments/assets/c56f251f-e999-4944-af2e-98eaacdecf8a)
---

## 📁 6. Enable Real File Logging

Inside the container:

```bash
docker exec -it nginx-server bash
rm /var/log/nginx/access.log /var/log/nginx/error.log
touch /var/log/nginx/access.log /var/log/nginx/error.log
nginx -s reload
exit
```

---

## 📄 7. Confirm Logs in the Volume

Option 1 - Inside container:
```bash
docker exec -it nginx-server cat /var/log/nginx/access.log
```

Option 2 - From host:
```bash
sudo cat /var/lib/docker/volumes/nginx_logs/_data/access.log
```

---

## 📸 Screenshots

### Docker Volume

![Image](https://github.com/user-attachments/assets/9e9d1631-3c2e-4a96-bfce-2b5688926dbe)


### Nginx-Logs 

![Image](https://github.com/user-attachments/assets/202385ad-31f4-464c-aa77-2ba86a8b796a)

---

## ✅ Result

This lab successfully demonstrated:
- Using Docker volumes to persist logs.
- Using bind mounts to serve HTML from host machine.
- Verifying changes and log persistence.