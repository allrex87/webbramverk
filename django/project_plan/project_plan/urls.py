from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',

    url(r'^admin/', include(admin.site.urls)),
	
	url(r'^project/(?P<project_id>\d+)$', 'project_manager.views.one_project', name="one_project"),
	url(r'^projects/$', 'project_manager.views.projects_for_user', name="projects_for_user"),
	url(r'^projects/add$', 'project_manager.views.project_add', name="project_add"),
	url(r'^project/(?P<project_id>\d+)/edit/$', 'project_manager.views.project_edit', name="project_edit"),
	url(r'^project/(?P<project_id>\d+)/remove/$', 'project_manager.views.project_remove', name="project_remove"),
	
	url(r'^project/(?P<project_id>\d+)/ticket/(?P<ticket_id>\d+)/$', 'project_manager.views.one_ticket', name="one_ticket"),
	url(r'^project/(?P<project_id>\d+)/ticket/(?P<ticket_id>\d+)/edit/$', 'project_manager.views.ticket_edit', name="ticket_edit"),
	url(r'^project/(?P<project_id>\d+)/ticket/add$', 'project_manager.views.ticket_add', name="ticket_add"),
	url(r'^project/(?P<project_id>\d+)/ticket/(?P<ticket_id>\d+)/remove/$', 'project_manager.views.ticket_remove', name="ticket_remove"),
	
	url(r'^$', 'project_manager.views.login_user', name='login_user'),
	url(r'^logout/$', 'project_manager.views.logout_user', name='logout_user'),
	url(r'^register/$', 'project_manager.views.register_user', name="register_user"),
	
	#url(r'^projects/(?P<project_id>/d+)/delete/$', 'project_manager.views.project_delete', name="project_delete"),
	#url(r'^projects/ticket/(?P<ticket_id>\d+)/$', 'project_manager.views.project_list', name="project_list_with_ticket"),
	#url(r'^projects/user/(?P<user_id>\d+)/$', 'project_manager.views.project_list', name="project_list"),
)