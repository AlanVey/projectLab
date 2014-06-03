class Milestone < ActiveRecord::Base
  validates_presence_of :name, :status, :due_date
  belongs_to :project
end
