# coding: utf-8
class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :user
  has_many :tickets, :dependent => :destroy
 
  attr_accessible :project_name, :description, :start_date, :end_date
  
  validates :project_name,
  :presence => {:message => 'Du måste ange ett projektnamn'},
  :length => { :within => 1..40, :message => 'Projektnamnet måste vara mellan 1-40 tecken' }
  
  validates :description,
  :presence => {:message => 'Du måste ange en beskrivning'}
  
  validates :start_date,
  :presence => {:message => 'Du måste ange ett startdatum'},
  :format => { :with => /^\d{4}-\d{2}-\d{2}/, :message => "Startdatatumet är i fel format (år/månad/dag)"}
  
  validates :end_date,
  :presence => {:message => 'Du måste ett slutdatum'},
  :format => { :with => /^\d{4}-\d{2}-\d{2}/, :message => "Slutdatatumet är i fel format (år/månad/dag)"}
  
  def self.search(search)
    search_condition = "%" + search + "%"
    return find(:all, :conditions => ['project_name LIKE ? OR description LIKE ?', search_condition, search_condition])
  end
end
