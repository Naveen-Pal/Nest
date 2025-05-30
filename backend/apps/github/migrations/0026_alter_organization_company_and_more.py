# Generated by Django 5.2 on 2025-05-07 15:54

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("github", "0025_organization_is_owasp_organization"),
    ]

    operations = [
        migrations.AlterField(
            model_name="organization",
            name="company",
            field=models.CharField(blank=True, default="", max_length=200, verbose_name="Company"),
        ),
        migrations.AlterField(
            model_name="organization",
            name="description",
            field=models.CharField(
                blank=True, default="", max_length=1000, verbose_name="Description"
            ),
        ),
        migrations.AlterField(
            model_name="user",
            name="company",
            field=models.CharField(blank=True, default="", max_length=200, verbose_name="Company"),
        ),
    ]
