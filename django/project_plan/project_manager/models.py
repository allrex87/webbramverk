from django.db import models
from django.contrib.auth.models import User
from django.forms import ModelForm, TextInput
from django.forms.widgets import TextInput
from django import forms

from django.core.exceptions import ValidationError

class Project(models.Model):
	project_name = models.CharField(max_length=40)
	project_desc = models.TextField()
	start_date = models.DateField()
	end_date = models.DateField()
	owner = models.ForeignKey(User, related_name="project_owner")
	members = models.ManyToManyField(User, related_name="project_members")
	def __unicode__(self):
		return self.project_name
		
	def is_owner(self, user):
		return self.owner == user
		
	def is_member(self, user):
		return user in self.members.all() or self.owner == user
		
class ProjectForm(ModelForm):
	class Meta:
		model = Project
		exclude = ('owner_id')

class Status(models.Model):
	status_name = models.CharField(max_length=40)
	def __unicode__(self):
		return self.status_name
	
class Ticket(models.Model):
	ticket_name = models.CharField(max_length=40)
	ticket_desc = models.TextField()
	owner = models.ForeignKey(User, related_name="ticket_owner")
	project = models.ForeignKey(Project, related_name="tickets")
	status = models.ForeignKey(Status, related_name="ticket_status")
	def __unicode__(self):
		return self.ticket_name
	def is_owner(self, user):
		return self.owner == user

class TicketForm(ModelForm):
	class Meta:
		model = Ticket
		exclude = ('owner', 'project')
		
class LoginForm(forms.Form):
	username = forms.CharField(max_length = 20)
	password = forms.CharField(max_length = 20, widget=forms.PasswordInput)
	
class SearchForm(forms.Form):
	search = forms.CharField(max_length=100)




