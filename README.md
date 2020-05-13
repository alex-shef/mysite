## Final work IT-academy by Aleksei Shevchuk on Python3 (still in development)

### The blog about Belarusian banks.
This blog will publish information about Belarusian banks: comparison of services, commissions, and exclusive offers.

*SETUP INSTRUCTIONS for Windows*

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
   
You can view publications, share them, leave comments, and log in to your account on the blog.
