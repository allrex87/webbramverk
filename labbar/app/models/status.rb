class Status < ActiveRecord::Base
  belongs_to :ticket
  
  attr_accessible :status_name
  
end
