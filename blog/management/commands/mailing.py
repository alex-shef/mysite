import datetime

from django.conf import settings
from django.contrib.auth.models import User
from django.core.mail import send_mass_mail
from django.core.management.base import BaseCommand
from django.utils import timezone

from blog.models import Post

HOST = 'http://127.0.0.1:8000'  # for checking


class Command(BaseCommand):
    help = 'Makes a mailing list for users(only with argument --days)'

    def add_arguments(self, parser):
        parser.add_argument('--days', dest='days', type=int,
                            help='Sending out publications for a certain number of days (example: --days=3)')

    def handle(self, *args, **options):
        emails = []
        subject = 'Рассылка "Блога о банках"'
        message = ''
        date_mailing_from = timezone.now() - datetime.timedelta(
            days=options['days'])
        posts = Post.published.filter(publish__gte=date_mailing_from)
        for post in posts:
            post_url = post.get_absolute_url()
            message += f'{post.title}\n{HOST}{post_url}\n\n'
        users = User.objects.all()
        for user in users:
            emails.append((subject,
                           message,
                           settings.DEFAULT_FROM_EMAIL,
                           [user.email]))
        send_mass_mail(emails)
        self.stdout.write('Sent {} mailings'.format(len(emails)))
