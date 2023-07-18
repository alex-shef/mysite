from django.conf import settings
from django.contrib.auth.models import User
from django.db import models
from django.urls import reverse
from django.utils import timezone
from django.utils.translation import gettext_lazy as _


class PublishedManager(models.Manager):
    def get_queryset(self):
        return super(PublishedManager, self).get_queryset().filter(
            status='published')


class Post(models.Model):
    STATUS_CHOICES = (
        ('draft', _('Draft')),
        ('published', _('Published')),
    )
    title = models.CharField(_('title'), max_length=250)
    slug = models.SlugField(_('slug'), max_length=250, unique_for_date='publish')
    author = models.ForeignKey(User, on_delete=models.CASCADE,
                               related_name='blog_posts', verbose_name=_('author'))
    body = models.TextField(_('post_body'))
    publish = models.DateTimeField(_('publish'), default=timezone.now)
    created = models.DateTimeField(_('created'), auto_now_add=True)
    updated = models.DateTimeField(_('updated'), auto_now=True)
    status = models.CharField(_('status'), max_length=10, choices=STATUS_CHOICES,
                              default='draft')

    objects = models.Manager()
    published = PublishedManager()

    class Meta:
        ordering = ('-publish',)
        verbose_name = _('post')
        verbose_name_plural = _('posts')

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('blog:post_detail', args=[self.publish.year,
                                                 self.publish.month,
                                                 self.publish.day,
                                                 self.slug])


class Comment(models.Model):
    post = models.ForeignKey(Post,
                             on_delete=models.CASCADE,
                             related_name='comments', verbose_name=_('post'))
    name = models.CharField(_('name'), max_length=80)
    email = models.EmailField()
    body = models.TextField(_('comment'))
    created = models.DateTimeField(_('created'), auto_now_add=True)
    updated = models.DateTimeField(_('updated'), auto_now=True)
    active = models.BooleanField(_('active'), default=True)

    class Meta:
        ordering = ('created',)
        verbose_name = _('comment')
        verbose_name_plural = _('comments')

    def __str__(self):
        return 'Comment by {} on {}'.format(self.name, self.post)


class Profile(models.Model):
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, verbose_name=_('user'))
    date_of_birth = models.DateField(_('date_of_birth'), blank=True, null=True)
    photo = models.ImageField(_('photo'), upload_to='users/%Y/%m/%d/', blank=True, null=True)

    def __str__(self):
        return 'Profile for user {}'.format(self.user)

    class Meta:
        verbose_name = _('profile')
        verbose_name_plural = _('profiles')
