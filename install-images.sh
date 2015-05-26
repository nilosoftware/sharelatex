#!/bin/bash

##################################################
# Instructions
##################################################
# 1. Download and install docker https://docs.docker.com/installation/ubuntulinux/#installing-docker-on-ubuntu
# 2. Create an account on DockerHub.  This account will allow you to pull and install the docker image I have created.
# 3. Run the following commands

sudo docker run -d --name sharemongo mongo:2.6.9
sudo docker run -d --name shareredis redis:latest

# downloads and runs the worksheet builder docker image
sudo docker run -d -P -p 80:80 -v ~/sharelatex_data:/var/lib/sharelatex \
  --env SHARELATEX_SITE_URL=http://107.170.234.122 \
  --env SHARELATEX_MONGO_URL=mongodb://mongo/sharelatex \
  --env SHARELATEX_REDIS_HOST=redis \
  --link sharemongo:mongo \
  --link shareredis:redis \
  --name worksheet-builder \
  nilo/access-worksheet-builder:0.0.1



docker run -d -P -p 80:80 -v ~/sharelatex_data:/var/lib/sharelatex \
  --env SHARELATEX_SITE_URL=http://192.168.99.100 \
  --env SHARELATEX_MONGO_URL=mongodb://mongo/sharelatex \
  --env SHARELATEX_REDIS_HOST=redis \
  --link sharemongo:mongo \
  --link shareredis:redis \
  --name worksheet-builder \
  nilo/access-worksheet-builder:0.0.1


# creates an admin user in the tool
sudo docker exec worksheet-builder /bin/bash -c "cd /var/www/sharelatex/web; grunt create-admin-user --email benard@nilosoftware.com"