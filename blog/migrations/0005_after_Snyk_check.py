# Generated by Django 3.0.14 on 2021-05-21 09:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0004_translation'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='photo',
            field=models.ImageField(blank=True, null=True, upload_to='users/%Y/%m/%d/', verbose_name='photo'),
        ),
    ]
