This script deploys a Rails app using Dokku to a VPS. It assumes you already has SSH access to it from the current machine.

Set up the IP in the .env file and the script will deploy the app to production

How to deploy a Rails 7 with Postgres, Redis + TailwindCss

1. Create a VPS

2. Make sure you can SSH into it from your terminal 

3. Add the IP to .env like this (MY_APP):
```
MY_APP_IP=126.34.234.34
```
4. type ```chikideploy``` from the root of your app.


## This program could not be possible without the Official Dokku docs and this RailsNotes article:
https://dokku.com/docs/deployment/application-deployment/

https://railsnotes.xyz/blog/deploying-ruby-on-rails-with-dokku-redis-sidekiq-arm-docker-hetzner#adding-a-domain-name-and-lets-encrypt-ssl-certificates-to-our-dokku-app
