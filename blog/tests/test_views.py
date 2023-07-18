from django.contrib.auth.models import User
from django.core import mail
from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase, Client
from django.urls import reverse
from django.utils import timezone

from blog.models import Post, Comment, Profile


class PostListViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        user = User.objects.create_user(username='testuser', password='testpassword')
        for i in range(10):
            Post.objects.create(title=f'Test Post {i}', slug=f'test-post-{i}', author=user,
                                body=f'This is test post {i}', publish=timezone.now(), status='published')

    def test_view_url_exists_at_desired_location(self):
        response = self.client.get('/en/blog/')
        self.assertEqual(response.status_code, 200)

    def test_view_url_accessible_by_name(self):
        response = self.client.get(reverse('blog:post_list'))
        self.assertEqual(response.status_code, 200)

    def test_view_uses_correct_template(self):
        response = self.client.get(reverse('blog:post_list'))
        self.assertTemplateUsed(response, 'blog/post/list.html')

    def test_pagination_is_three(self):
        response = self.client.get(reverse('blog:post_list'))
        self.assertEqual(len(response.context['posts']), 3)

    def test_first_page_contains_last_three_posts(self):
        response = self.client.get(reverse('blog:post_list'))
        self.assertEqual(len(response.context['posts']), 3)
        self.assertEqual(response.context['posts'][0].title, 'Test Post 9')
        self.assertEqual(response.context['posts'][1].title, 'Test Post 8')
        self.assertEqual(response.context['posts'][2].title, 'Test Post 7')

    def test_second_page_contains_next_three_posts(self):
        response = self.client.get(reverse('blog:post_list') + '?page=2')
        self.assertEqual(len(response.context['posts']), 3)
        self.assertEqual(response.context['posts'][0].title, 'Test Post 6')
        self.assertEqual(response.context['posts'][1].title, 'Test Post 5')
        self.assertEqual(response.context['posts'][2].title, 'Test Post 4')

    def test_third_page_contains_next_three_posts(self):
        response = self.client.get(reverse('blog:post_list') + '?page=3')
        self.assertEqual(len(response.context['posts']), 3)
        self.assertEqual(response.context['posts'][0].title, 'Test Post 3')
        self.assertEqual(response.context['posts'][1].title, 'Test Post 2')
        self.assertEqual(response.context['posts'][2].title, 'Test Post 1')

    def test_fourth_page_contains_last_post(self):
        response = self.client.get(reverse('blog:post_list') + '?page=4')
        self.assertEqual(len(response.context['posts']), 1)
        self.assertEqual(response.context['posts'][0].title, 'Test Post 0')


class PostDetailViewTest(TestCase):

    current_datetime = timezone.now()

    @classmethod
    def setUpTestData(cls):
        user = User.objects.create_user(username='testuser', password='testpassword')
        post = Post.objects.create(title='Test Post', slug='test-post', author=user,
                                   body='This is a test post', publish=cls.current_datetime, status='published')
        Comment.objects.create(post=post, name='John Doe', email='johndoe@example.com', body='Test comment', active=True)

    def setUp(self):
        self.client = Client()

    def test_view_url_exists_at_desired_location(self):
        response = self.client.get(f'/en/blog/{self.current_datetime.year}/{self.current_datetime.month}/{self.current_datetime.day}/test-post/')
        self.assertEqual(response.status_code, 200)

    def test_view_url_accessible_by_name(self):
        response = self.client.get(reverse('blog:post_detail', args=[self.current_datetime.year, self.current_datetime.month, self.current_datetime.day, 'test-post']))
        self.assertEqual(response.status_code, 200)

    def test_view_uses_correct_template(self):
        response = self.client.get(reverse('blog:post_detail', args=[self.current_datetime.year, self.current_datetime.month, self.current_datetime.day, 'test-post']))
        self.assertTemplateUsed(response, 'blog/post/detail.html')

    def test_detail_page_displays_post_data(self):
        response = self.client.get(reverse('blog:post_detail', args=[self.current_datetime.year, self.current_datetime.month, self.current_datetime.day, 'test-post']))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Test Post')
        self.assertContains(response, 'This is a test post')

    def test_detail_page_displays_comments(self):
        response = self.client.get(reverse('blog:post_detail', args=[self.current_datetime.year, self.current_datetime.month, self.current_datetime.day, 'test-post']))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'John Doe')
        self.assertContains(response, 'Test comment')

    def test_detail_page_can_add_comment(self):
        response = self.client.post(reverse('blog:post_detail', args=[self.current_datetime.year, self.current_datetime.month, self.current_datetime.day, 'test-post']), data={
            'name': 'Jane Doe',
            'email': 'janedoe@example.com',
            'body': 'Another test comment',
        })
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, reverse('blog:post_detail', args=[self.current_datetime.year, self.current_datetime.month, self.current_datetime.day, 'test-post']))

        post = Post.objects.get(slug='test-post')
        comments = post.comments.filter(active=True)
        self.assertEqual(comments.count(), 2)
        new_comment = comments.last()
        self.assertEqual(new_comment.name, 'Jane Doe')
        self.assertEqual(new_comment.email, 'janedoe@example.com')
        self.assertEqual(new_comment.body, 'Another test comment')

    def test_detail_page_with_invalid_form_data_does_not_add_comment(self):
        response = self.client.post(reverse('blog:post_detail', args=[self.current_datetime.year, self.current_datetime.month, self.current_datetime.day, 'test-post']), data={
            'name': '',  # Invalid data
            'email': 'janedoe@example.com',
            'body': 'Another test comment',
        })
        self.assertEqual(response.status_code, 200)

        post = Post.objects.get(slug='test-post')
        comments = post.comments.filter(active=True)
        self.assertEqual(comments.count(), 1)  # Should still be 1 comment


class PostShareViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        user = User.objects.create_user(username='testuser', password='testpassword')
        Post.objects.create(title='Test Post', slug='test-post', author=user,
                            body='This is a test post', publish=timezone.now(), status='published')

    def setUp(self):
        self.client = Client()

    def test_view_url_exists_at_desired_location(self):
        post = Post.objects.get(slug='test-post')
        url = reverse('blog:post_share', args=[post.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)

    def test_post_share_form_submission_sends_email(self):
        post = Post.objects.get(slug='test-post')
        url = reverse('blog:post_share', args=[post.id])
        form_data = {
            'name': 'John Doe',
            'email': 'johndoe@example.com',
            'to': 'recipient@example.com',
            'comments': 'Check out this post!'
        }

        response = self.client.post(url, form_data)
        self.assertEqual(response.status_code, 200)  # The view should return to the same page
        self.assertEqual(len(mail.outbox), 1)
        sent_email = mail.outbox[0]
        self.assertEqual(sent_email.subject, f'John Doe (johndoe@example.com) рекоммендует Вам пост "Test Post"')
        self.assertIn('Check out this post!', sent_email.body)
        self.assertIn(post.get_absolute_url(), sent_email.body)

    def test_post_share_form_invalid_data_does_not_send_email(self):
        post = Post.objects.get(slug='test-post')
        url = reverse('blog:post_share', args=[post.id])
        invalid_form_data = {
            'name': 'John Doe',
            'email': 'invalid-email',
            'to': 'recipient@example.com',
            'comments': 'Check out this post!'
        }

        response = self.client.post(url, invalid_form_data)
        self.assertEqual(response.status_code, 200)  # The view should return to the same page
        self.assertEqual(len(mail.outbox), 0)


class PostSearchViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = User.objects.create_user(username='testuser', password='testpassword')
        for i in range(10):
            Post.objects.create(
                title_ru=f'Тест Пост {i} РУ',
                title_en=f'Test Post {i} EN',
                slug=f'test-post-{i}',
                body_ru=f'Это тест пост {i} на Русском',
                body_en=f'This is test post {i} in English',
                author=cls.user,
                publish=timezone.now(),
                status='published'
            )

    def setUp(self):
        self.client = Client()

    def test_view_url_exists_at_desired_location(self):
        response = self.client.get('/en/blog/search/')
        self.assertEqual(response.status_code, 200)

    def test_view_url_accessible_by_name(self):
        response = self.client.get(reverse('blog:post_search'))
        self.assertEqual(response.status_code, 200)

    def test_view_uses_correct_template(self):
        response = self.client.get(reverse('blog:post_search'))
        self.assertTemplateUsed(response, 'blog/post/search.html')

    def test_post_search_with_query_ru(self):
        response = self.client.get(reverse('blog:post_search'), data={'query': 'Тест Пост 1 РУ'})
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Тест Пост 1 РУ')

    def test_post_search_with_query_en(self):
        response = self.client.get(reverse('blog:post_search'), data={'query': 'Test Post 1 EN'})
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Test Post 1 EN')

    def test_post_search_with_invalid_query(self):
        response = self.client.get(reverse('blog:post_search'), data={'query': 'Invalid Query'})
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Nothing was found for your search.')


class AccountViewTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = User.objects.create_user(username='testuser', password='testpassword')

    def setUp(self):
        self.client = Client()

    def test_view_redirects_for_unauthenticated_user(self):
        response = self.client.get(reverse('blog:account'))
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, '/en/blog/login/?next=/en/blog/account/')

    def test_view_returns_200_for_authenticated_user(self):
        self.client.login(username='testuser', password='testpassword')
        response = self.client.get(reverse('blog:account'))
        self.assertEqual(response.status_code, 200)

    def test_view_uses_correct_template(self):
        self.client.login(username='testuser', password='testpassword')
        response = self.client.get(reverse('blog:account'))
        self.assertTemplateUsed(response, 'blog/registration/account.html')


class RegisterViewTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_view_redirects_authenticated_user_to_account(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        self.client.login(username='testuser', password='testpassword')

    def test_view_returns_200_for_unauthenticated_user(self):
        response = self.client.get(reverse('blog:register'))
        self.assertEqual(response.status_code, 200)

    def test_view_uses_correct_templates(self):
        response = self.client.get(reverse('blog:register'))
        self.assertTemplateUsed(response, 'blog/registration/register.html')
        response = self.client.post(reverse('blog:register'), data={})
        self.assertTemplateUsed(response, 'blog/registration/register.html')


class EditViewTest(TestCase):
    def setUp(self):
        self.client = Client()

    def test_view_redirects_unauthenticated_user_to_login(self):
        response = self.client.get(reverse('blog:edit'))
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, '/en/blog/login/?next=/en/blog/edit/')

    def test_view_returns_200_for_authenticated_user(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        profile = Profile.objects.create(user=user)
        self.client.login(username='testuser', password='testpassword')
        response = self.client.get(reverse('blog:edit'))
        self.assertEqual(response.status_code, 200)

    def test_view_uses_correct_templates(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        profile = Profile.objects.create(user=user)
        self.client.login(username='testuser', password='testpassword')
        response = self.client.get(reverse('blog:edit'))
        self.assertTemplateUsed(response, 'blog/registration/edit.html')
        response = self.client.post(reverse('blog:edit'), data={})
        self.assertTemplateUsed(response, 'blog/registration/edit.html')

    def test_view_updates_profile_with_valid_data(self):
        user = User.objects.create_user(username='testuser', password='testpassword')
        profile = Profile.objects.create(user=user)
        self.client.login(username='testuser', password='testpassword')
        response = self.client.post(reverse('blog:edit'), data={
            'first_name': 'John',
            'last_name': 'Doe',
            'email': 'johndoe@example.com',
            'photo': SimpleUploadedFile('avatar.jpg', b'avatar content', content_type='image/jpeg'),
        })
        self.assertEqual(response.status_code, 200)
        user.refresh_from_db()
        profile.refresh_from_db()
        self.assertEqual(user.first_name, 'John')
        self.assertEqual(user.last_name, 'Doe')
        self.assertEqual(user.email, 'johndoe@example.com')
        self.assertEqual(profile.photo.read(), b'avatar content')
