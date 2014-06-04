class Milestone < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, dependent: :destroy

  @valid = ['Created', 'Started', 'Pending Review', 'Completed']
  
  validates_presence_of :due_date
  validates :status, presence: true, :inclusion=> { :in => @valid }
  validates :name, presence: true, uniqueness: { case_sensitive: false } 
  validate :due_date_cannot_be_in_the_past

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "can't be in the past") if
      !due_date.blank? and due_date < Date.today
  end

end
