from django.contrib.auth.models import User
from django.test import TestCase

from blog.forms import EmailPostForm, CommentForm, LoginForm, UserRegistrationForm, UserEditForm, ProfileEditForm
from blog.models import Profile


class EmailPostFormTest(TestCase):
    def test_form_is_valid_with_valid_data(self):
        form = EmailPostForm(data={
            'name': 'John Doe',
            'email': 'johndoe@example.com',
            'to': 'friend@example.com',
            'comments': 'Check out this post!'
        })
        self.assertTrue(form.is_valid())

    def test_form_is_invalid_with_missing_required_fields(self):
        form = EmailPostForm(data={})
        self.assertFalse(form.is_valid())

    def test_form_is_invalid_with_invalid_email(self):
        form = EmailPostForm(data={
            'name': 'John Doe',
            'email': 'invalidemail',
            'to': 'friend@example.com',
            'comments': 'Check out this post!'
        })
        self.assertFalse(form.is_valid())

    def test_form_is_valid_with_empty_comments(self):
        form = EmailPostForm(data={
            'name': 'John Doe',
            'email': 'johndoe@example.com',
            'to': 'friend@example.com',
            'comments': ''
        })
        self.assertTrue(form.is_valid())


class CommentFormTest(TestCase):
    def test_form_with_valid_data(self):
        data = {
            'name': 'John Doe',
            'email': 'johndoe@example.com',
            'body': 'This is a test comment.'
        }
        form = CommentForm(data=data)
        self.assertTrue(form.is_valid())

    def test_form_with_empty_data(self):
        form = CommentForm(data={})
        self.assertFalse(form.is_valid())

    def test_form_with_invalid_email(self):
        data = {
            'name': 'John Doe',
            'email': 'johndoe@example',
            'body': 'This is a test comment.'
        }
        form = CommentForm(data=data)
        self.assertFalse(form.is_valid())

    def test_form_with_empty_name(self):
        data = {
            'name': '',
            'email': 'johndoe@example.com',
            'body': 'This is a test comment.'
        }
        form = CommentForm(data=data)
        self.assertFalse(form.is_valid())


class LoginFormTest(TestCase):
    def test_form_with_valid_data(self):
        data = {
            'username': 'testuser',
            'password': 'testpassword'
        }
        form = LoginForm(data=data)
        self.assertTrue(form.is_valid())

    def test_form_with_empty_data(self):
        form = LoginForm(data={})
        self.assertFalse(form.is_valid())

    def test_form_with_missing_username(self):
        data = {
            'password': 'testpassword'
        }
        form = LoginForm(data=data)
        self.assertFalse(form.is_valid())

    def test_form_with_missing_password(self):
        data = {
            'username': 'testuser'
        }
        form = LoginForm(data=data)
        self.assertFalse(form.is_valid())


class UserRegistrationFormTest(TestCase):
    def test_form_with_valid_data(self):
        data = {
            'username': 'testuser',
            'first_name': 'John',
            'email': 'testuser@example.com',
            'password': 'testpassword',
            'password2': 'testpassword',
        }
        form = UserRegistrationForm(data=data)
        self.assertTrue(form.is_valid())

    def test_form_with_empty_data(self):
        form = UserRegistrationForm(data={})
        self.assertFalse(form.is_valid())

    def test_form_with_passwords_not_matching(self):
        data = {
            'username': 'testuser',
            'first_name': 'John',
            'email': 'testuser@example.com',
            'password': 'testpassword',
            'password2': 'differentpassword',
        }
        form = UserRegistrationForm(data=data)
        self.assertFalse(form.is_valid())

    def test_form_with_missing_required_fields(self):
        form = UserRegistrationForm(data={})
        self.assertFalse(form.is_valid())


class UserEditFormTest(TestCase):
    def test_form_with_valid_data(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        data = {
            'first_name': 'John',
            'last_name': 'Doe',
            'email': 'johndoe@example.com',
        }
        form = UserEditForm(instance=user, data=data)
        self.assertTrue(form.is_valid())

    def test_form_with_empty_data(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        form = UserEditForm(instance=user, data={})
        self.assertTrue(form.is_valid())


class ProfileEditFormTest(TestCase):
    def test_form_with_valid_data(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        profile = Profile.objects.create(user=user)
        data = {
            'date_of_birth': '1990-01-01',
        }
        form = ProfileEditForm(instance=profile, data=data)
        self.assertTrue(form.is_valid())

    def test_form_with_empty_data(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        profile = Profile.objects.create(user=user)
        form = ProfileEditForm(instance=profile, data={})
        self.assertTrue(form.is_valid())
