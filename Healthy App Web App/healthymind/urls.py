from django.urls import path

from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("login", views.login_view, name="login"),
    path("logout", views.logout_view, name="logout"),
    path("register", views.register, name="register"),
    path("blogs", views.blogs, name="blogs"),
    path("readblog/<str:blogid>", views.readblog, name="readblog"),
    path("post", views.seepost, name="seepost"),
    path("getcurruser", views.getcurrentuser, name="getcurruser"),

    # API urls
    path("contactform", views.contactform, name="contactform"),
    path("blogapiurl", views.blog, name="postblog"),
    path("resigterapi", views.registerapi, name="registerapi"),
    path("loginapi", views.loginapi, name="loginapi")
]