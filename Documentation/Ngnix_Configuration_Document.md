# 腾讯云 Ngnix 配置文档

> [!TIP]
> 腾讯云轻量应用服务器镜像：Debian12-Docker26

## 配置服务器防火墙

开放服务器端口 8000-8009 用于跨域资源共享（CORS），开放服务器端口 9000 用于智慧幕墙数据集管理平台后端应用程序：

![](assets/2024-12-06_08-33-39.png)

## 配置 Ngnix

更新系统软件包列表并安装 Ngnix：

```bash
sudo apt update
sudo apt install nginx
```

检查 Nginx 是否正常运行：

```bash
sudo systemctl status nginx
```

![](assets/2024-12-04_14-46-56.png)

## 配置跨域资源共享（CORS）

编辑 `proxy_params` 文件：

```bash
sudo nano /etc/nginx/proxy_params
```

```
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
proxy_set_header Host $host;
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
proxy_set_header X-Forwarded-Host $server_name;

add_header 'Access-Control-Allow-Origin' '*';
add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
add_header 'Access-Control-Max-Age' 1728000;

if ($request_method = 'OPTIONS') {
    add_header 'Access-Control-Allow-Origin' '*';
    add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
    add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type,Authorization';
    add_header 'Content-Type' 'text/plain charset=UTF-8';
    add_header 'Content-Length' 0;
    return 204;
}
```

编辑 `proxy` 文件：

```bash
sudo nano /etc/nginx/sites-available/proxy
```

```
server {
    listen 8000;
    location / {
        proxy_pass https://hz-4.matpool.com:27450;
        include proxy_params;
    }
}

server {
    listen 8001;
    location / {
        proxy_pass https://hz-4.matpool.com:26526;
        include proxy_params;
    }
}

server {
    listen 8002;
    location / {
        proxy_pass https://hz-4.matpool.com:26208;
        include proxy_params;
    }
}

server {
    listen 8003;
    location / {
        proxy_pass https://hz-4.matpool.com:27142;
        include proxy_params;
    }
}

server {
    listen 8004;
    location / {
        proxy_pass https://hz-t3.matpool.com:27515;
        include proxy_params;
    }
}

server {
    listen 8005;
    location / {
        proxy_pass https://hz-t3.matpool.com:26519;
        include proxy_params;
    }
}

server {
    listen 8006;
    location / {
        proxy_pass https://hz-t3.matpool.com:27183;
        include proxy_params;
    }
}

server {
    listen 8007;
    location / {
        proxy_pass https://hz-t3.matpool.com:28179;
        include proxy_params;
    }
}

server {
    listen 8008;
    location / {
        proxy_pass https://hz-4.matpool.com:29900;
        include proxy_params;
    }
}

server {
    listen 8009;
    location / {
        proxy_pass https://hz-t3.matpool.com:27847;
        include proxy_params;
    }
}
```

激活站点：

```bash
sudo ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/
```

测试 Nginx 配置文件正确性：

```bash
sudo nginx -t
```

![](assets/2024-12-04_14-49-47.png)

重启 Nginx 服务：

```bash
sudo systemctl restart nginx
```

## 配置数据集管理平台

将数据集管理平台部署文件上传至 `/home/lighthouse/userinterface` 文件夹。

编辑 `default` 文件：

```bash
sudo nano /etc/nginx/sites-available/default
```

```
server {
    listen 80;
    server_name 110.42.214.164;

    root /home/lighthouse/userinterface;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

测试 Nginx 配置文件正确性：

```bash
sudo nginx -t
```

![](assets/2024-12-04_14-49-47.png)

重启 Nginx 服务：

```bash
sudo systemctl restart nginx
```

```bash
docker --version
```

```bash
sudo docker pull minmuslin/intelligent-curtain-wall:oss-management
sudo docker run -d -p 9000:8080 --name oss-management minmuslin/intelligent-curtain-wall:oss-management
```