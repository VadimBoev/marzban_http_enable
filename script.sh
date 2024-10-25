#!/bin/bash

# Install Nginx if it is not installed
if ! command -v nginx &> /dev/null
then
    echo -e "\e[32mNginx is not installed. Installing...\e[0m"
    sudo apt-get update
    sudo apt-get install -y nginx
else
    echo -e "\e[32mNginx is already installed.\e[0m"
fi

# Function to replace the proxy port in the configuration
replace_proxy_port() {
    local new_port=$1
    sudo sed -i "0,/listen [0-9]\+/s//listen $new_port/" /etc/nginx/sites-available/default
}

# Backup the configuration file
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
echo -e "\e[32mConfiguration file backed up to /etc/nginx/sites-available/default.bak\e[0m"

# Write the content to the default file
cat <<EOF | sudo tee /etc/nginx/sites-available/default > /dev/null
server {
    listen 7000;
	
    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

read -p $'\033[36mEnter the new proxy port (default is \033[33m\033[1m7000\033[36m): \e[0m' new_port

# If the user did not enter a port, use the default port
if [ -z "$new_port" ]; then
    new_port=7000
fi

# Validate the port number
if ! [[ "$new_port" =~ ^[0-9]+$ ]] || [ "$new_port" -lt 1 ] || [ "$new_port" -gt 65535 ]; then
    echo -e "\e[31mInvalid port number. Please enter a number between 1 and 65535.\e[0m"
    exit 1
fi

# Replace the proxy port in the configuration
sudo sed -i "0,/listen 7000/s//listen $new_port/" /etc/nginx/sites-available/default

# Restart Nginx
echo -e "\e[32mRestarting Nginx...\e[0m"
sudo systemctl restart nginx

# Check if Nginx restarted successfully
if [ $? -eq 0 ]; then
    echo -e "\e[32mNginx successfully restarted with proxy port \033[36m$new_port.\e[0m"
else
    echo -e "\e[31mFailed to restart Nginx. Restoring the backup...\e[0m"
    sudo cp /etc/nginx/sites-available/default.bak /etc/nginx/sites-available/default
    sudo systemctl restart nginx
    echo -e "\e[32mBackup restored and Nginx restarted.\e[0m"
fi
