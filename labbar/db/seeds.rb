# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


u1 = User.create(:first_name => "Johan", :last_name => "Andersson", :email => "testuser@htomail.com", :password => "ettbraett")
u2 = User.create(:first_name => "Philip", :last_name => "Nilsson", :email => "testuser@htomail.com", :password => "ettbraett")
u3 = User.create(:first_name => "Andreas", :last_name => "Johansson", :email => "testuser@htomail.com", :password => "ettbraett")
u4 = User.create(:first_name => "Jonas", :last_name => "Persson", :email => "testuser@htomail.com", :password => "ettbraett")

p1 = Project.create(:project_name => "Projekt 1", :description => "nummer 1 testprojekt", :start_date => 20130401, :end_date => 20130708)
p2 = Project.create(:project_name => "Projekt 2", :description => "nummer 2 testprojekt", :start_date => 20130405, :end_date => 20130708)
p3 = Project.create(:project_name => "Projekt 3", :description => "nummer 3 testprojekt", :start_date => 20130409, :end_date => 20130708)
p4 = Project.create(:project_name => "Projekt 4", :description => "nummer 4 testprojekt", :start_date => 20130430, :end_date => 20130708)

#lägger till ägare för project
u1.projects << p1
u2.projects << p2
u3.projects << p3
u4.projects << p4
u1.projects << p4

#ägger till i projects_users
p4.users << u1
p4.users << u2
p4.users << u3
p4.users << u4