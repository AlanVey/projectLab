class Task < ActiveRecord::Base
  belongs_to :project

  @valid = ['Created', 'Started', 'Pending Review', 'Completed']

  validates_presence_of :name, :description, :priority, :user_email, :milestone_id, :status
  validates :difficulty, presence: true, :inclusion=> { :in => 1..4 }
  validates :status, :inclusion=> { :in => @valid }
end
