# Generated by Django 5.1.4 on 2024-12-15 20:15

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Usuario',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('nombre', models.CharField(max_length=255)),
                ('numero', models.CharField(max_length=20)),
                ('gmail', models.EmailField(max_length=254)),
                ('nombre_de_usuario', models.CharField(max_length=255, unique=True)),
            ],
        ),
    ]
