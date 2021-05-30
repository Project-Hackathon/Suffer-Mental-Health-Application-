from django.shortcuts import render
import json
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.db import IntegrityError
from django.http import JsonResponse
from django.shortcuts import HttpResponse, HttpResponseRedirect, render
from django.urls import reverse
from django.views.decorators.csrf import csrf_exempt
from .models import *
# Create your views here.

def index(request):
    return render(request, "healthymind/index.html")

def login_view(request):
    if request.method == "POST":

        # Attempt to sign user in
        email = request.POST["email"]
        password = request.POST["password"]
        user = authenticate(request, username=email, password=password)

        # Check if authentication successful
        if user is not None:
            login(request, user)
            return HttpResponseRedirect(reverse("index"))
        else:
            return render(request, "healthymind/login.html", {
                "message": "Invalid email and/or password."
            })
    else:
        return render(request, "healthymind/login.html")


def logout_view(request):
    logout(request)
    return HttpResponseRedirect(reverse("index"))


def register(request):
    if request.method == "POST":
        email = request.POST["email"]

        # Ensure password matches confirmation
        password = request.POST["password"]
        name = request.POST["name"]
        # Attempt to create new user
        try:
            user = User.objects.create_user(email, email, password)
            user.first_name = name
            user.save()
        except IntegrityError as e:
            print(e)
            return render(request, "healthymind/login.html", {
                "message": "Email address already taken."
            })
        login(request, user)
        return HttpResponseRedirect(reverse("index"))
    else:
        return render(request, "healthymind/login.html")


@csrf_exempt
def contactform(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        name = data.get("name")
        email = data.get("email")
        subject = data.get("subject")
        message = data.get("message")
        newcontact = Contact(
            name = name,
            email = email,
            subject = subject,
            message = message
        )
        newcontact.save()
        return JsonResponse({"message": "Message Sent!"})
    else:
        return JsonResponse({"message": "POST method required!"})


def blogs(request):
    posts = Storeblog.objects.all().order_by("-id")
    return render(request, "healthymind/blogs.html", {
        "posts": posts
    })

def readblog(request, blogid):
    reqblog = Storeblog.objects.get(id = blogid)
    return render(request, "healthymind/readblog.html", {
        "blog": reqblog
    })

@csrf_exempt
def blog(request):
    if request.method == 'POST':
    
        data = json.loads(request.body)
        owner = data.get('owner')
        header = data.get('header')
        shortdesc = data.get('shortdesc')
        blogdata = data.get('blogdata')
        new = Storeblog(
            owner= owner,
            header= header,
            short= shortdesc,
            data= blogdata
        )
        new.save()
        return JsonResponse({"message": "Published."})
    posts = Storeblog.objects.all().order_by("-id")
    return JsonResponse([post.serialize() for post in posts], safe=False)

@csrf_exempt
def registerapi(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        email = data.get("email")
        name = data.get("name")
        password = data.get("password")

        users = User.objects.filter(username=email)
        if len(users) > 0:
            return JsonResponse({"message": "Email address already taken."})
        newuser = User.objects.create_user(email, email, password)
        newuser.first_name = name
        newuser.save()
        return JsonResponse({"message": "Registered!"})

@csrf_exempt
def loginapi(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        email = data.get("email")
        password = data.get("password")
        user = authenticate(request, username=email, password=password)
        if user is not None:
            return JsonResponse({"message": "Login Successfull."})
        else:
            return JsonResponse({"message": "Invalid Credentials."})

def seepost(request):
    return render(request, "healthymind/post.html")

def getcurrentuser(request):
    if request.user.is_authenticated:
        return JsonResponse({"message": f"{request.user.first_name}"})
    else:
        return JsonResponse({"message": "Login first to Access!"})