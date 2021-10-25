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


https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-20-04



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

digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04

https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04

sudo mysql_secure_installation
Q
CREATE USER 'john'@'localhost' IDENTIFIED WITH mysql_native_password BY '2022LoylV^ct1';
<!-- GRANT PRIVILEGE ON database.table TO 'john'@'host'; -->
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, REFERENCES, RELOAD on *.* TO 'john'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;


pm2:
https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-20-04