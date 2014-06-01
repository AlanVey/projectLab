class Project < ActiveRecord::Base
  validates_presence_of :name, :description

  belongs_to :user
  has_many :project_users
end
