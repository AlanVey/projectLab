class Etherpad < ActiveRecord::Base
  belongs_to :project

  validates_presence_of :creator, :project_id
  validates :file, presence: true, uniqueness: { case_sensitive: true } 
  validates :name, presence: true, uniqueness: { case_sensitive: false } 
end
