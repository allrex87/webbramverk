# coding: utf-8
class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many :projects
  has_many :tickets

  has_secure_password
 

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
 
  validates :first_name,
    :presence => {:message => 'Du måste ange ett förnamn'},
    :lenght => {:minimum => 1, :maximum => 40, :message => 'Förnamnet måste vara 1-40 tecken'}
   
  validates :last_name,
    :presence => { :message => 'Du måste ange ett efternamn'},
    :length => {:minimum => 1, :maximum => 40, :message => "Förnamnet måste vara 1-40 tecken"}
 
 
  validates :email,
    :presence => { :message => 'Du måste ange en emailadress'},
    :email => true
  
  
  def self.authenticate(email, password)
    find_by_email(:email).try(:authenticate, password)
  end
end
