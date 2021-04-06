from django.contrib.auth import views as auth_views
from django.urls import path, reverse_lazy

from . import views

app_name = 'blog'
urlpatterns = [
    # path('', views.post_list, name='post_list'),
    path('', views.PostListView.as_view(), name='post_list'),
    path('<int:year>/<int:month>/<int:day>/<slug:post>/',
         views.post_detail, name='post_detail'),
    path('<int:post_id>/share/', views.post_share, name='post_share'),

    path('search/', views.post_search, name='post_search'),

    # path('login/', views.user_login, name='login'),
    path('login/', auth_views.LoginView.as_view(
        template_name='blog/registration/login.html',
        redirect_authenticated_user=True), name='login'),
    path('logout/', auth_views.LogoutView.as_view(
        template_name='blog/registration/logged_out.html'), name='logout'),
    path('account/', views.account, name='account'),

    path('password_change/', auth_views.PasswordChangeView.as_view(
        success_url=reverse_lazy('blog:password_change_done'),
        template_name='blog/registration/password_change_form.html'),
        name='password_change'),
    path('password_change/done/', auth_views.PasswordChangeDoneView.as_view(
        template_name='blog/registration/password_change_done.html'),
        name='password_change_done'),

    path('password_reset/', auth_views.PasswordResetView.as_view(
        email_template_name='blog/registration/password_reset_email.html',
        # subject_template_name='blog/registration/password_reset_subject.txt',
        success_url=reverse_lazy('blog:password_reset_done'),
        template_name='blog/registration/password_reset_form.html'),
        name='password_reset'),
    path('password_reset/done/', auth_views.PasswordResetDoneView.as_view(
        template_name='blog/registration/password_reset_done.html'),
        name='password_reset_done'),
    path('reset/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(
        success_url=reverse_lazy('blog:password_reset_complete'),
        template_name='blog/registration/password_reset_confirm.html'),
        name='password_reset_confirm'),
    path('reset/done/', auth_views.PasswordResetCompleteView.as_view(
        template_name='blog/registration/password_reset_complete.html'),
        name='password_reset_complete'),

    path('register/', views.register, name='register'),

    path('edit/', views.edit, name='edit')
    ]
