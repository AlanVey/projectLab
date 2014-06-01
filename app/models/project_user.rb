class ProjectUser < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :email
end
