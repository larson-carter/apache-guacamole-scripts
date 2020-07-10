#!/bin/bash

# Add certbot repository
add-apt-repository ppa:certbot/certbot -y

# Update package lists
apt-get update

# Upgrade existing packages
apt-get upgrade -y

# Install nginx
apt-get install nginx -y

# Get script arguments for non-interactive mode
while [ "$1" != "" ]; do
    case $1 in
        -f | --fqdn )              shift
                                   argfqdn="$1";;
        -e | --email )             shift
                                   argemail="$1";;
        -g | --guacamole )         shift
                                   argguacamole="$1"
    esac
    shift
done

# Get fqdn and email
if [ -n "$argfqdn" ] && [ -n "$argemail" ]; then
        certbotfqdn=$argfqdn
        certbotemail=$argemail
else
    echo 
    while true
    do
        read -s -p "Enter the fqdn for your domain: " certbotfqdn
        echo
        read -s -p "Confirm the fqdn for your domain: " certbotfqdn2
        echo
        [ "$certbotfqdn" = "$certbotfqdn2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
    echo
    while true
    do
        read -s -p "Enter your email address: " certbotemail
        echo
        read -s -p "Confirm your email address: " certbotemail2
        echo
        [ "$certbotemail" = "$certbotemail2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
    echo
fi

# Get guacamole url
if [ -n "$argguacamole" ]; then
        guacamoleurl=$argguacamole
else
        guacamoleurl=http://localhost:8080/guacamole/
fi

# Configure /etc/nginx/sites-available/default
echo "server {" > /etc/nginx/sites-available/default
echo " " >> /etc/nginx/sites-available/default
echo "    listen 80 default_server;" >> /etc/nginx/sites-available/default
echo "    listen [::]:80 default_server;" >> /etc/nginx/sites-available/default
echo "    root /var/www/html;" >> /etc/nginx/sites-available/default
echo "    index index.html index.htm index.nginx-debian.html;" >> /etc/nginx/sites-available/default
echo "    server_name $certbotfqdn;" >> /etc/nginx/sites-available/default
echo "    location / {" >> /etc/nginx/sites-available/default
echo "        proxy_pass $guacamoleurl;" >> /etc/nginx/sites-available/default
echo "        proxy_buffering off;" >> /etc/nginx/sites-available/default
echo "        proxy_http_version 1.1;" >> /etc/nginx/sites-available/default
echo "        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;" >> /etc/nginx/sites-available/default
echo "        proxy_set_header Upgrade \$http_upgrade;" >> /etc/nginx/sites-available/default
echo "        proxy_set_header Connection \$http_connection;" >> /etc/nginx/sites-available/default
echo "        access_log off;" >> /etc/nginx/sites-available/default
echo "    }" >> /etc/nginx/sites-available/default
echo " " >> /etc/nginx/sites-available/default
echo "}" >> /etc/nginx/sites-available/default

# Restart Nginx to apply the changes
systemctl restart nginx

# Install Certbot
apt-get install python-certbot-nginx -y

# Generate and Install a Let's Encrypt SSL certificate into Nginx
certbot --nginx -n -d $certbotfqdn --email $certbotemail --agree-tos --redirect --hsts