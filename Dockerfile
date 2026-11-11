
# Use a lightweight Nginx web server
FROM nginx:alpine

# Copy the HTML page into the Nginx web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
