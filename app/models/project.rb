class Project < ActiveRecord::Base

  validates_presence_of :name, :description

  belongs_to :user 
end
