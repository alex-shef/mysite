from blog.models import Post, User, Comment
from django.core.paginator import Paginator
from django.template.loader import render_to_string
from django.test import TestCase, Client
from django.utils import timezone
from django.utils.translation import activate
from django.urls import reverse


class BaseTemplateTests(TestCase):

    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='12345', first_name='Тест')
        activate('ru')

    def test_sidebar_content(self):
        response = self.client.get('/', follow=True, HTTP_ACCEPT_LANGUAGE='ru')
        self.assertContains(response, '<a href="{0}">Блог о финансах</a>'.format(reverse('blog:post_list')))
        self.assertContains(response,
                            '<p>В этом блоге будет публиковаться информация о банках: сравнение услуг, комиссий, эксклюзивных предложений.</p>')
        self.assertContains(response, '<a href="{0}">Поиск</a>'.format(reverse('blog:post_search')))

    def test_authenticated_user_sidebar(self):
        self.client.login(username='testuser', password='12345')
        response = self.client.get('/', follow=True, HTTP_ACCEPT_LANGUAGE='ru')
        self.assertContains(response, 'Привет, <a href="{0}">{1}.</a>'.format(reverse('blog:account'), self.user.first_name))
        self.assertContains(response, '<a href="{0}">&nbsp;&nbsp;&nbsp;Выйти из аккаунта</a>'.format(reverse('blog:logout')))

    def test_unauthenticated_user_sidebar(self):
        response = self.client.get('/', follow=True, HTTP_ACCEPT_LANGUAGE='ru')
        self.assertContains(response, '<a href="{0}">Авторизация</a>'.format(reverse('blog:login')))


class PaginationTemplateTest(TestCase):

    def setUp(self):
        data = [f'Item {i}' for i in range(1, 10)]
        self.paginator = Paginator(data, 3)

    def test_pagination_template(self):
        rendered = render_to_string('blog/pagination.html', {'page': self.paginator.page(1)})
        self.assertInHTML('<span class="current">Страница 1 из 3.</span>', rendered)
        self.assertInHTML('<a href="?page=2">Следующая</a>', rendered)

        rendered = render_to_string('blog/pagination.html', {'page': self.paginator.page(2)})
        self.assertIn('<a href="?page=1">Предыдущая</a>', rendered)
        self.assertInHTML('<span class="current">Страница 2 из 3.</span>', rendered)
        self.assertInHTML('<a href="?page=3">Следующая</a>', rendered)

        rendered = render_to_string('blog/pagination.html', {'page': self.paginator.page(3)})
        self.assertIn('<a href="?page=2">Предыдущая</a>', rendered)
        self.assertInHTML('<span class="current">Страница 3 из 3.</span>', rendered)


class PostDetailTemplateTest(TestCase):

    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='12345')

        self.post = Post.objects.create(
            title='Тестовый пост',
            author=self.user,
            body='Тело тестового поста.',
            publish=timezone.now(),
            slug='slug',
            status='published'
        )

        self.comment1 = Comment.objects.create(
            post=self.post,
            name='Тестовый автор комментария 1',
            body='Тело первого тестового комментария.',
            created=timezone.now(),
        )
        self.comment2 = Comment.objects.create(
            post=self.post,
            name='Тестовый автор комментария 2',
            body='Тело второго тестового комментария.',
            created=timezone.now(),
        )
        activate('ru')

    def test_post_detail_template(self):

        url = reverse('blog:post_detail', kwargs={
            'year': self.post.publish.year,
            'month': self.post.publish.month,
            'day': self.post.publish.day,
            'post': self.post.slug,
        })
        response = self.client.get(url, HTTP_ACCEPT_LANGUAGE='ru')

        self.assertEqual(response.status_code, 200)
        self.assertContains(response, '<h1>Тестовый пост</h1>')
        self.assertContains(response, '<p class="date">testuser опубликовал')
        self.assertContains(response, '<h3>Добавить комментарий</h3>')
        self.assertContains(response, 'Тело первого тестового комментария.')
        self.assertContains(response, 'Тело второго тестового комментария.')
        self.assertNotContains(response, 'Ошибка')


class PostListTemplateTest(TestCase):

    def setUp(self):
        # Создаем тестовых пользователей
        self.user = User.objects.create_user(username='testuser', password='12345')

        # Создаем несколько тестовых постов
        self.post1 = Post.objects.create(
            title='Тестовый пост 1',
            slug='test-post-1',
            author=self.user,
            body='Это тестовое содержание первого поста.',
            publish=timezone.now(),
            status='published'
        )
        self.post2 = Post.objects.create(
            title='Тестовый пост 2',
            slug='test-post-2',
            author=self.user,
            body='Это тестовое содержание второго поста.',
            publish=timezone.now(),
            status='published'
        )

    def test_blog_index_template(self):
        url = reverse('blog:post_list')
        response = self.client.get(url)

        # Проверяем, что страница доступна
        self.assertEqual(response.status_code, 200)

        # Проверяем, что ожидаемые заголовки постов присутствуют на странице
        self.assertContains(response, 'Тестовый пост 1')
        self.assertContains(response, 'Тестовый пост 2')

        self.assertContains(response, 'Это тестовое содержание первого поста.')
        self.assertContains(response, 'Это тестовое содержание второго поста.')

        # Проверяем, что ссылки на посты приводят к правильным URL
        self.assertContains(response, f'href="{self.post1.get_absolute_url()}"')
        self.assertContains(response, f'href="{self.post2.get_absolute_url()}"')


class PostSearchTemplateTest(TestCase):

    def setUp(self):
        self.client = Client()
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.post1 = Post.objects.create(
            title='First post',
            slug='first-post',
            body='Content of the first post.',
            status='published',
            author=self.user
        )
        self.post2 = Post.objects.create(
            title='Second post',
            slug='second-post',
            body='Content of the second post.',
            status='published',
            author=self.user
        )
        activate('ru')

    def test_search_form_display(self):
        response = self.client.get(reverse('blog:post_search'), HTTP_ACCEPT_LANGUAGE='ru')
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, '<h1>Поиск по постам</h1>')
        self.assertContains(response, '<input type="submit" value="Поиск">')

    def test_search_results_display(self):
        response = self.client.get(reverse('blog:post_search'), {'query': 'First'}, HTTP_ACCEPT_LANGUAGE='ru')
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Посты, содержащие "First"')
        self.assertContains(response, 'Найдено 1 совпадение')
        self.assertContains(response, self.post1.title)
        self.assertNotContains(response, self.post2.title)

    def test_no_results_message(self):
        response = self.client.get(reverse('blog:post_search'), {'query': 'NonExistent'}, HTTP_ACCEPT_LANGUAGE='ru')
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, 'Посты, содержащие "NonExistent"')
        self.assertContains(response, 'Найдено 0 совпадений')
        self.assertContains(response, 'По Вашему запросу ничего не найдено.')


class SharePostTemplateTest(TestCase):

    def setUp(self):
        self.user = User.objects.create_user(username='testuser', password='12345')
        self.post = Post.objects.create(
            title='Test Post',
            slug='test-post',
            body='Test post content',
            status='published',
            author=self.user
        )
        activate('ru')

    def test_share_post_form_display(self):
        response = self.client.get(reverse('blog:post_share', args=[self.post.id]), HTTP_ACCEPT_LANGUAGE='ru')
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, '<h1>Поделиться "Test Post" по e-mail</h1>')
        self.assertContains(response, '<input type="submit" value="Отправить e-mail">')
        self.assertContains(response, 'name="name"')
        self.assertContains(response, 'name="email"')
        self.assertContains(response, 'name="to"')
        self.assertContains(response, 'name="comments"')

    def test_share_post_success_message(self):
        form_data = {
            'name': 'Test User',
            'email': 'test@example.com',
            'to': 'friend@example.com',
            'comments': 'Check out this post!'
        }
        response = self.client.post(reverse('blog:post_share', args=[self.post.id]), data=form_data, HTTP_ACCEPT_LANGUAGE='ru')
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, '<h1>E-mail успешно отправлен</h1>')
        self.assertContains(response, '"Test Post" было успешно отправлено friend@example.com.')
