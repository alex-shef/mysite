from mysite.settings.base import *  # noqa: F403, F401

DEBUG = True

ALLOWED_HOSTS = ['*']

# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.0/howto/static-files/

STATIC_URL = 'static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')     # noqa: F405
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'blog/static'), ]    # noqa: F405

MEDIA_URL = 'media/'
MEDIA_ROOT = os.path.join(BASE_DIR, 'media/')   # noqa: F405
