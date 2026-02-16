# 1. Use Nginx (a tiny web server)
FROM nginx:alpine

# 2. Copy your HTML file to the folder Nginx looks at
COPY index.html /usr/share/nginx/html/index.html

# 3. Open port 80 (Standard Web Port)
EXPOSE 80
