from django.shortcuts import render, redirect
from .forms import UserEntryForm
from .models import UserEntry
from django.views import generic
from zumaqui.models import Usuario


from django.views.generic import ListView
from .models import Usuario

#creaste your views here.

class ZumaquiListView(generic.ListView):
    model = Usuario 






class UsuarioListView(ListView):
    model = Usuario
    template_name = 'zumaqui/usuario_list.html'  # Ruta correcta a tu plantilla
    context_object_name = 'usuarios'  # Opcional: el nombre del contexto








#ingresa descripcion de la planta 
def create_entry(request):
    if request.method == 'POST':
        form = UserEntryForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('entry_list')  # Redirigir a una lista o detalle después de guardar
    else:
        form = UserEntryForm()
    return render(request, 'create_entry.html', {'form': form})

def entry_list(request):
    entries = UserEntry.objects.all()
    return render(request, 'entry_list.html', {'entries': entries})
