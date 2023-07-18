## Final work IT-academy by Aleksei Shevchuk on Django(Python3) and PostgreSQL.

### The blog with registration users system, internationalization and full-text search.

  
  It is assumed that you have Docker installed. 
  Otherwise, you can choose another branch: postgresql or sqlite(with reduced functionality).

  Test coverage 95%.

*APPLICATION LAUNCH*

   `docker-compose up --build`
   
   http://127.0.0.1:8000/admin/ - Django administration

   http://127.0.0.1:8000/blog/ - the blog
   
   ***
   
The user can view posts, share, comment, log in to their blog account and edit it, as well as reset a forgotten password and create a new one.

In the Django admin panel, you can create and manage publications using the WYSIWYG editor "Summernote". You can also manage users and comments.

Using a Django Management Command `python manage.py mailing --days` you can mailing posts for a certain number of days to all users.

Added:
* sitemap.xml for indexing the site
* pop-up message system at user's profile edit page
* Email Authorisation feature
* Russian-English internationalization for users and admins