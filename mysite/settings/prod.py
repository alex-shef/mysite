from .base import *

DEBUG = False

ADMINS = [
    ('Aleksei Shevchuk', 'alexei.shef@gmail.com'),
]

ALLOWED_HOSTS = [os.getenv('WEB_ADDRESS')]

CSRF_TRUSTED_ORIGINS = [f"https://{os.getenv('WEB_ADDRESS')}"]
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
