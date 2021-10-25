# json-server-deploy-digital-ocean
# json-server-deploy-digital-ocean
HAVE INCLUDED A NEW BASH SCRIPT TO AUTO DEPLOY TO THE POINT OF SECURE MYSQL INSTALLATION - 

all you need is to git init ; git pull <this repo> ;
sudo bash ./dep.sh

then proceed with mysql installation then import server and pm2- profit!
https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04


!~SUCCESS : managed to deploy a running json server:
future FE foplder: https://main.johnmogi.com/
api: https://main.johnmogi.com/api/contacts
(nodejs json-server exposing localhost:3000 with nginx reverse proxy)

@@ next step - produce a simple cra form to CRUD json server then on to new horisons (:

1. test - floating ip on device
hello world - nodejs

2. DO - ubunto 20:
nodejs 

LEMP

https://www.digitalocean.com/community/tutorials/how-to-set-up-nginx-server-blocks-virtual-hosts-on-ubuntu-16-04

sudo mkdir -p /var/www/main.johnmogi.com/html


sudo chown -R $USER:$USER /var/www/main.johnmogi.com/html


sudo chmod -R 755 /var/www

nano /var/www/main.johnmogi.com/html/index.html

<html>
    <head>
        <title>Welcome to main.com!</title>
    </head>
    <body>
        <h1>Success! The main.com server block is working!</h1>
    </body>
</html>


sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/main.johnmogi.com
sudo nano /etc/nginx/sites-available/main.johnmogi.com


server {
        listen 80;
        listen [::]:80;

        root /var/www/main.johnmogi.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name main.johnmogi.com www.main.johnmogi.com;

        location / {
                try_files $uri $uri/ =404;
        }
}


sudo ln -s /etc/nginx/sites-available/main.johnmogi.com /etc/nginx/sites-enabled/

sudo nano /etc/nginx/nginx.conf
sudo nginx -t
sudo systemctl restart nginx


install nodeJS
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-20-04

re edit the site config to listen on port from api:

server {
        listen 80;
        listen [::]:80;

        root /var/www/main.johnmogi.com/html;
        index index.html index.htm index.nginx-debian.html;

        server_name main.johnmogi.com www.main.johnmogi.com;

        location / {
                try_files $uri $uri/ =404;
        }
        
        location /api {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

pm2:
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-20-04
