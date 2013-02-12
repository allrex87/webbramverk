# coding: utf-8
class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :statuses
  
  attr_accessible :ticket_name, :description, :status_id, :project_id
  
  validates :ticket_name,
  :presence => {:message => 'Du måste ange ett ticketnamn'},
  :length => { :within => 1..40, :message => 'Ticketnamnet måste vara mellan 1-40 tecken' }
  
  
end
