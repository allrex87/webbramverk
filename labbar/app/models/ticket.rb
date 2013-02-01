class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user, :foreign_key => "owner_id"
  has_many :statuses
end
