FROM httpd:latest
COPY site/ /usr/local/apache2/htdocs/
EXPOSE 80
