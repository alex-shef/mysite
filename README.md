## The blog on Django(Python3) deployed on GCP(GKE).

### The app includes registration users system, internationalization and full-text search.

### The deployment process includes installing in the cluster and configuration of Jenkins, ArgoCD, Grafana/Loki services.

*APPLICATION LAUNCH*

Required software: Terraform, gcloud, kubectl.

Required Hashicorp Cloud secrets:
* 'DOMAIN' - example.com
* 'GITHUB_EMAIL'
* 'GITHUB_TOKEN' - with 'repo', 'write:packages', 'delete:packages', 'admin:repo_hook' scopes
* 'GITHUB_USERNAME'
* 'POSTGRES_DB' - database name
* 'POSTGRES_HOST'
* 'POSTGRES_PASSWORD'
* 'POSTGRES_PORT'
* 'POSTGRES_USER'
* 'SECRET_KEY' - for Django app
* 'WEB_ADDRESS' - www.example.com

Configure `terraform.tfvars`.

Enable Google Cloud Service Usage API: https://console.cloud.google.com/apis/library/serviceusage.googleapis.com

`gcloud config set project 'PROJECT'`

`cd deploy`

`terraform init`

`terrafrom apply`

- configure DNS after finishing with ArgoCD error (terraform provider ArgoCD requires working domain)

`terrafrom apply` (again)

Every service has UI (jenkins.domain, argocd.domain, grafana.domain).

A Jenkins job is created and a build version is changed in the Jenkinsfile manually. The Github repo and webhook are configured in the github.tf

   *** 

A user can view posts, share, comment, log in to his blog account and edit it, as well as reset a forgotten password and create a new one.

In the Django admin panel, you can create and manage publications using the WYSIWYG editor "Summernote". You can also manage users and comments.

Added:
* sitemap.xml for indexing the site
* pop-up message system at user's profile edit page
* Email Authorisation feature
* Internationalization for users and admins