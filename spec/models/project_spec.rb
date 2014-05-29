require 'spec_helper'

describe Project do

  before { @project = FactoryGirl.build(:project) }
  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:user) }

  describe "when name is not present" do
    before { @project.name = "" }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { @project.description = "" }
    it { should_not be_valid }
  end

end