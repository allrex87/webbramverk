from django import template
register = template.Library()

@register.filter
def ownership(project, user):
	return project.owner == user

@register.filter
def membership(project, user):
	return user in project.members.all() or project.owner == user
	
@register.filter
def ticket_ownership(ticket, user):
	return ticket.owner == user