class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :user
  has_many :tickets
  
  attr_accessible :project_name, :description, :start_date, :end_date
  
  #simle validation kollar om den har ett värde
  validates_presence_of :project_name
  
  #validates_precene_of :first_name, :message => "Du måste fylla i ett namn"
  #validates_length_of ser till att en sträng har en viss längd
  #validates_numericality_of ser till att det är ett nummer
  #validates_format_fo reguljära uttryck
  #validates_acceptane_of checkbox som måste checkas i
  #validates_confirmation_of används när manska upprepa t ex lösenord
  
  #validates   :first_name,
  # =>         :precsence => { :message => "Du måste ange..."}
  # =>         :lenght => {:minimum => 2, :maximum => 30, :message => "Måsta vara mellan..."}
  
end
