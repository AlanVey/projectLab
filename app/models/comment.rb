class Comment < ActiveRecord::Base
  belongs_to :task

  validates_presence_of :comment, :task_id, :creator_email
end
