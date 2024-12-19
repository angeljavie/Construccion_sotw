from django.contrib import admin

from zumaqui.models import Usuario, UserEntry
from django.contrib import admin

# Register your models here. Registra tus modelos en el admin
@admin.register(Usuario)
class UsuarioAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'numero', 'gmail', 'nombre_de_usuario')

@admin.register(UserEntry)
class UserEntryAdmin(admin.ModelAdmin):
    list_display = ('title', 'description', 'image')


 
