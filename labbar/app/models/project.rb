class Project < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :user
  has_many :tickets
end
