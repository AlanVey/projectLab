class Project < ActiveRecord::Base
  validates_presence_of :name, :description

  belongs_to :user
  has_many :project_users, dependent: :destroy
  has_many :milestones, dependent: :destroy

  searchable do
    text :name
    string :description
  end

end
