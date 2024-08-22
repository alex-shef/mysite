## The blog on Django(Python3) deployed on GCP(GKE).

### The app includes registration users system, internationalization and full-text search.

### The deployment process includes installing in the cluster and configuration of Jenkins, ArgoCD, Grafana/Loki services.

*APPLICATION LAUNCH*

Necessary software: Terraform, gcloud, kubectl.

Configure `terraform.tfvars`.

Enable Google Cloud Service Usage API: https://console.cloud.google.com/apis/library/serviceusage.googleapis.com

`gcloud config set project 'PROJECT'`

`cd deploy`

`terraform init`

`terrafrom apply`

   *** 

The user can view posts, share, comment, log in to his blog account and edit it, as well as reset a forgotten password and create a new one.

In the Django admin panel, you can create and manage publications using the WYSIWYG editor "Summernote". You can also manage users and comments.

Added:
* sitemap.xml for indexing the site
* pop-up message system at user's profile edit page
* Email Authorisation feature
* Internationalization for users and admins