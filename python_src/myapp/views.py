from django.shortcuts import render
from django.views import View


class MyAppView(View):
    def get(self, request):
        print('Hello World')
        return render(request, 'myapp/hello.html')
