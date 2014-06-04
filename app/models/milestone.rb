class Milestone < ActiveRecord::Base
  belongs_to :project

  @valid = ['Created', 'Started', 'Pending Review', 'Completed']
  
  validates_presence_of :status, :due_date
  validates :status, :inclusion=> { :in => @valid }
  validates :name, presence: true, uniqueness: { case_sensitive: false } 
  validate :due_date_cannot_be_in_the_past

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if
      !due_date.blank? and due_date < Date.today
  end

end
