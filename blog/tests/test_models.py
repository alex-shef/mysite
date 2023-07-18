from django.contrib.auth.models import User
from django.db import models
from django.test import TestCase
from django.utils import timezone

from blog.models import Comment, Post, Profile


class PostModelTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        user = User.objects.create_user(username='testuser', password='testpassword')
        cls.obj_id = Post.objects.create(title='Test Post', slug='test-post', author=user, body='This is a test post',
                            publish=timezone.now(), status='published').pk

    def test_title_max_length(self):
        post = Post.objects.get(id=self.obj_id)
        max_length = post._meta.get_field('title').max_length
        self.assertEqual(max_length, 250)

    def test_slug_max_length(self):
        post = Post.objects.get(id=self.obj_id)
        max_length = post._meta.get_field('slug').max_length
        self.assertEqual(max_length, 250)

    def test_slug_unique_for_date(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertTrue(post._meta.get_field('slug').unique_for_date)

    def test_author_foreign_key(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertEqual(post._meta.get_field('author').related_model, User)

    def test_body_textfield(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertIsInstance(post._meta.get_field('body'), models.TextField)

    def test_publish_default(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertEqual(post._meta.get_field('publish').default, timezone.now)

    def test_created_auto_now_add(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertTrue(post._meta.get_field('created').auto_now_add)

    def test_updated_auto_now(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertTrue(post._meta.get_field('updated').auto_now)

    def test_status_choices(self):
        post = Post.objects.get(id=self.obj_id)
        choices = post._meta.get_field('status').choices
        self.assertEqual(choices, (('draft', 'Draft'), ('published', 'Published')))

    def test_ordering(self):
        self.assertEqual(Post._meta.ordering, ('-publish',))

    def test_verbose_name(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertEqual(post._meta.verbose_name, 'post')

    def test_verbose_name_plural(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertEqual(post._meta.verbose_name_plural, 'posts')

    def test_str_representation(self):
        post = Post.objects.get(id=self.obj_id)
        self.assertEqual(str(post), post.title)

    def test_get_absolute_url(self):
        post = Post.objects.get(id=self.obj_id)
        expected_url = '/en/blog/{}/{}/{}/{}/'.format(post.publish.year, post.publish.month, post.publish.day, post.slug)
        self.assertEqual(post.get_absolute_url(), expected_url)


class CommentModelTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        user = User.objects.create_user(username='testuser', password='testpassword')
        post = Post.objects.create(title='Test Post', slug='test-post', author=user, body='This is a test post',
                                   publish=timezone.now(), status='published')
        cls.obj_id = Comment.objects.create(
            post=post,
            name='John Doe',
            email='johndoe@example.com',
            body='Test comment',
            created=timezone.now(),
            updated=timezone.now(),
            active=True
        ).pk

    def test_comment_str_representation(self):
        comment = Comment.objects.get(id=self.obj_id)
        expected_str = 'Comment by John Doe on Test Post'
        self.assertEqual(str(comment), expected_str)

    def test_comment_default_active_value(self):
        comment = Comment.objects.get(id=self.obj_id)
        self.assertTrue(comment.active)

    def test_comment_created_date(self):
        comment = Comment.objects.get(id=self.obj_id)
        self.assertIsNotNone(comment.created)

    def test_comment_updated_date(self):
        comment = Comment.objects.get(id=self.obj_id)
        self.assertIsNotNone(comment.updated)

    def test_comment_ordering(self):
        comments = Comment.objects.all()
        self.assertEqual(comments.count(), 1)
        self.assertEqual(comments[0].id, 1)


class ProfileModelTest(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.user = User.objects.create_user(username='testuser', password='testpassword')
        cls.profile = Profile.objects.create(user=cls.user, date_of_birth='1990-01-01')

    def test_profile_user(self):
        self.assertEqual(self.profile.user, self.user)

    def test_profile_date_of_birth(self):
        self.assertEqual(self.profile.date_of_birth, '1990-01-01')

    def test_profile_photo(self):
        self.assertFalse(self.profile.photo)

    def test_profile_str_representation(self):
        expected_str = f'Profile for user {self.user}'
        self.assertEqual(str(self.profile), expected_str)
