from django.http import HttpResponseServerError, HttpResponse
from django.shortcuts import get_list_or_404, render, redirect, get_object_or_404
from project_manager.models import Project, ProjectForm, Ticket, TicketForm, LoginForm, SearchForm
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django import forms
from django.contrib.auth.forms import UserCreationForm

def index(request):
	return HttpResponse("Hello World")
	
#-------------------------PROJECT-----------------------------

@login_required(login_url='/')
def one_project(request, project_id):
	project = get_object_or_404(Project, pk=project_id)
	if project.is_member(request.user):
		return render(request, 'projects/one.html', {"project" : project})
	else:
		messages.warning(request, 'You are not authorized to do this')
		return redirect(projects_for_user)

@login_required(login_url='/')
def project_remove(request, project_id):
	project = get_object_or_404(Project, pk=project_id)
	if project.is_owner(request.user):
		project.delete()
		messages.success(request, 'Your Project is now removed')
	else:
		messages.warning(request, 'You are not authorized to do this')
	return redirect(projects_for_user)

@login_required(login_url='/')
def projects_for_user(request):
	if request.method == "POST":
		searchValue = request.POST.get('search')
		if searchValue:
			projects = Project.objects.filter(project_name__contains=searchValue) | Project.objects.filter(project_desc__contains=searchValue)
	else:
		user = request.user
		projects = Project.objects.filter(members = user)
	form = SearchForm()
	return render(request, 'projects/list.html', {"projects" : projects, "form" : form})

@login_required(login_url='/')
def project_add(request):
	if request.method == "POST":
		form = ProjectForm(request.POST)
		form.instance.owner = request.user
		if form.is_valid():
			form.save()
			messages.success(request, 'Your Project is now created')
			return redirect(projects_for_user)
	else:
		form = ProjectForm()	
	return render(request, 'projects/add.html', {"form" : form})
	
@login_required(login_url='/')
def project_edit(request, project_id):
	project = get_object_or_404(Project, pk=project_id)
	if project.is_owner(request.user):
		if request.method == "POST":
			form = ProjectForm(request.POST, instance = project)
			if form.is_valid():
				try:
					form.save()
					messages.success(request, 'Your Project is now edited')
					return redirect(projects_for_user)
				except:
					return HttpResponseServerError()
		else:
			form = ProjectForm(instance = project)
	else:
		messages.warning(request, 'You are not authorized to do this')
		return redirect(projects_for_user)
	return render(request, 'projects/add.html', {"form" : form})

#-------------------------USER-----------------------------	

@login_required(login_url='/')
def logout_user(request):
	logout(request)
	return redirect('login_user')
	
def login_user(request):
	message = ''
	if request.method == "POST":
		form = LoginForm(request.POST)
		if form.is_valid():
			username_to_try = form.cleaned_data["username"]
			password_to_try = form.cleaned_data["password"]

			user = authenticate(username = username_to_try, password = password_to_try )
			if user is not None:
				if user.is_active:
					login(request, user)
					request.session['has_logged_in'] = True
					return redirect('projects_for_user')
				else:
					return HttpResponse("<h1>Your account is disabled by admin</h1>")
			else:
				messages.warning(request, 'Wrong userinfo')
	else:
		form = LoginForm()
	return render(request, 'users/login.html',{'form': form, 'message' : message})
	
def register_user(request):
	message = ''
	if request.method == "POST":
		form = UserCreationForm(request.POST)
		if form.is_valid():
			new_user = form.save()
			messages.success(request, 'Your  are now a member!')
			return redirect(login_user)
	else:
		form = UserCreationForm()
	return render(request, 'users/register.html',{'form': form})
	
#-------------------------TICKET-----------------------------

@login_required(login_url='/')
def one_ticket(request, project_id, ticket_id):
	project = get_object_or_404(Project, pk=project_id)
	ticket = get_object_or_404(Ticket, pk=ticket_id)
	if project.is_member(request.user):
		return render(request, 'tickets/one.html', {"ticket" : ticket})
	else:
		messages.warning(request, 'You are not authorized to do this')
		return redirect(projects_for_user)

@login_required(login_url='/')
def ticket_add(request, project_id):
	message=''
	project = get_object_or_404(Project, pk=project_id)
	if project.is_member(request.user):
		if request.method == "POST":
			form = TicketForm(request.POST)
			form.instance.owner = request.user
			form.instance.project_id = project_id
			if form.is_valid():
				form.save()
				messages.success(request, 'Your Ticket is now created')
				return redirect(one_project, project_id)
		else:
			form = TicketForm()
	else:
		messages.warning(request, 'You are not authorized to do this')
		return redirect(projects_for_user)
			
	return render(request, 'tickets/add.html', {"form" : form})
	
@login_required(login_url='/')
def ticket_edit(request, project_id, ticket_id):
	ticket = get_object_or_404(Ticket, pk=ticket_id)
	project = get_object_or_404(Project, pk=project_id)
	if ticket.is_owner(request.user) and project.is_member(request.user):
		if request.method == "POST":
			form = TicketForm(request.POST, instance = ticket)
			if form.is_valid():
				form.save()
				messages.success(request, 'Your Ticket is now edited')
				return redirect(one_project, ticket.project_id)
	
		else:
			form = TicketForm(instance = ticket)
	else:
		messages.warning(request, 'You are not authorized to do this')
		return redirect(projects_for_user)
		
	return render(request, 'projects/add.html', {"form" : form})
	
@login_required(login_url='/')
def ticket_remove(request, project_id, ticket_id):
	message = ''
	ticket = get_object_or_404(Ticket, pk=ticket_id)
	if ticket.is_owner(request.user):
		ticket.delete()
		messages.success(request, 'Your Ticket is now removed')
	else:
		messages.warning(request, 'You are not authorized to do this')
		return redirect(projects_for_user)
	return redirect(one_project, ticket.project_id)
	
	
