# coding: utf-8
require 'bcrypt'
class User < ActiveRecord::Base
  has_and_belongs_to_many :projects
  has_many :projects
  has_many :tickets

  before_save :encrypt_password

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  attr_accessor :password, :password_confirmation
 
  validates :first_name,
    :presence => {:message => 'Du måste ange ett förnamn'},
    :length => { :within => 1..20, :message => 'Förnamnet måste vara 1-20 tecken' }
   
  validates :last_name,
    :presence => { :message => 'Du måste ange ett efternamn'},
    :length => { :within => 1..40, :message => 'Efternamnet måste vara 1-40 tecken' }
 
  validates :email,
    :presence => { :message => 'Du måste ange en emailadress'},
    :format => { :with => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i, :message => "Emailadressen är inte giltig" },
    :uniqueness => { :case_sensitive => false , :message => "Emailadressen är redan registrerad"}
    
    
  
 def self.authenticate(email_try, password_try)
    user = find_by_email(email_try)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password_try, user.password_salt)
      return user
    else
      return nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
