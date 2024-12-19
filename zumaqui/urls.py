from django.urls import path
from zumaqui import views

from .views import UsuarioListView

urlpatterns = [
    path('', views.ZumaquiListView.as_view(), name='zumaqui_list'),
]



urlpatterns = [
    path('', UsuarioListView.as_view(), name='usuario-list'),
]
