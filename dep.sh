
sudo mkdir -p /var/www/main.johnmogi.com/html
sudo chown -R $USER:$USER /var/www/main.johnmogi.com/html
sudo chmod -R 755 /var/www
touch /var/www/main.johnmogi.com/html/index.html
echo '<title>Welcome to main.com!</title>
Success! The main.com server block is working!' > /var/www/main.johnmogi.com/html/index.html
sudo apt update
sudo apt install nginx -y
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw enable -y
sudo systemctl restart nginx
sudo systemctl enable nginx

sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/main.johnmogi.com 
echo 'server { 
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
' > /etc/nginx/sites-available/main.johnmogi.com
sudo ln -s /etc/nginx/sites-available/main.johnmogi.com /etc/nginx/sites-enabled/
echo 'user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
	worker_connections 768;
	# multi_accept on;
}

http {

	##
	# Basic Settings
	##

	sendfile on;
	tcp_nopush on;
	tcp_nodelay on;
	keepalive_timeout 65;
	types_hash_max_size 2048;
	# server_tokens off;

	server_names_hash_bucket_size 64;
	# server_name_in_redirect off;

	include /etc/nginx/mime.types;
	default_type application/octet-stream;

	##
	# SSL Settings
	##

	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POODLE
	ssl_prefer_server_ciphers on;

	##
	# Logging Settings
	##

	access_log /var/log/nginx/access.log;
	error_log /var/log/nginx/error.log;

	##
	# Gzip Settings
	##

	gzip on;

	# gzip_vary on;
	# gzip_proxied any;
	# gzip_comp_level 6;
	# gzip_buffers 16 8k;
	# gzip_http_version 1.1;
	# gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;

	##
	# Virtual Host Configs
	##

	include /etc/nginx/conf.d/*.conf;
	include /etc/nginx/sites-enabled/*;
}


#mail {
#	# See sample authentication script at:
#	# http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
# 
#	# auth_http localhost/auth.php;
#	# pop3_capabilities "TOP" "USER";
#	# imap_capabilities "IMAP4rev1" "UIDPLUS";
# 
#	server {
#		listen     localhost:110;
#		protocol   pop3;
#		proxy      on;
#	}
# 
#	server {
#		listen     localhost:143;
#		protocol   imap;
#		proxy      on;
#	}
#}' > etc/nginx/nginx.conf
sudo nginx -t
sudo systemctl restart nginx
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
sudo npm install pm2@latest -g
pm2 startup systemd
pm2 save
sudo systemctl start pm2-root


sudo apt install mysql-server -y




