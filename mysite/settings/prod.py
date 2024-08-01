from mysite.settings.base import *  # noqa: F403, F401
import os

DEBUG = False

ADMINS = [
    ('Aleksei Shevchuk', 'alexei.shef@gmail.com'),
]

ALLOWED_HOSTS = [os.getenv('WEB_ADDRESS')]

CSRF_TRUSTED_ORIGINS = [f"https://{os.getenv('WEB_ADDRESS')}"]
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True

# Static files (CSS, JavaScript, Images)
DEFAULT_FILE_STORAGE = "django_gcp.storage.GoogleCloudMediaStorage"
GCP_STORAGE_MEDIA = {
    "bucket_name": os.getenv('GCP_STORAGE_MEDIA_NAME'),
    "file_overwrite": False,
    "querystring_auth": False
}

STATICFILES_STORAGE = "django_gcp.storage.GoogleCloudStaticStorage"
GCP_STORAGE_STATIC = {
    "bucket_name": os.getenv('GCP_STORAGE_STATIC_NAME'),
    "querystring_auth": False
}

MEDIA_URL = f"https://storage.googleapis.com/{os.getenv('GCP_STORAGE_MEDIA_NAME')}/"
STATIC_URL = f"https://storage.googleapis.com/{os.getenv('GCP_STORAGE_STATIC_NAME')}/"
