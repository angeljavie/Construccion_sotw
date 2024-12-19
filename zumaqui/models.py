from django.db import models

# Create your models here.

class Usuario(models.Model):
    nombre = models.CharField(max_length=255)
    numero = models.CharField(max_length=20)
    gmail = models.EmailField(max_length=254)
    nombre_de_usuario = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.nombre_de_usuario
    

from django.db import models

class UserEntry(models.Model):
    title = models.CharField(max_length=100, verbose_name="Título")
    description = models.TextField(verbose_name="Descripción")
    image = models.ImageField(upload_to='uploads/', verbose_name="Imagen")
    created_at = models.DateTimeField(auto_now_add=True, verbose_name="Fecha de creación")

    def __str__(self):
        return self.title