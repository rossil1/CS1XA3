from django.shortcuts import render
from django.http import HttpResponse

def test(request):
    html = "<html><body>TEST</body></html>"
    return HttpResponse(html)


# Create your views here.
