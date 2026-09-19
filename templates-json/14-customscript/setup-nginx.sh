sudo apt-get update -y
sudo apt-get install -y nginx

sudo bash -c 'cat > /var/www/html/index.html <<EOF
<html>
  <head><title>Custom Script Extensions Demo</title></head>
  <body>
    <h1>We now have NGINX running as a web server</h1>
  </body>
</html>
EOF'

sudo systemctl enable nginx
sudo systemctl restart nginx