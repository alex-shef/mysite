## Final work IT-academy by Aleksei Shevchuk on Django(Python3) and PostgreSQL.

### The blog with authentication system and full-text search.


*SETUP INSTRUCTIONS for Windows*
  
  Assuming you have Python setup.
  
  1. If 'pip' not installed:
        https://pip.pypa.io/en/stable/installing/
        
  2. Creating an isolated Python environment
  
        `pip install virtualenv`
        
        `virtualenv my_env`
        
        `my_env\Scripts\activate`
        
  3. Install the libraries
  
        `pip install -r requirements.txt`
        
*APPLICATION LAUNCH*

   `python manage.py runserver`
   
   http://127.0.0.1:8000/admin/ - Django administration

   http://127.0.0.1:8000/blog/ - the blog
   
   http://127.0.0.1:8000/search/ - search
   ***
   
The user can view posts, share, comment, and log in to their blog account, as well as reset a forgotten password and create a new one.

In the Django admin panel, you can create and manage publications using the WYSIWYG editor "Summernote". You can also manage users and comments.

Using a Django Management Command `python manage.py mailing --days` you can mailing posts for a certain number of days to all users.

Added sitemap.xml for indexing the site.
