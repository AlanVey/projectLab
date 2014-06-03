class MilestonesController < ApplicationController
  before_filter :user_not_signed_in
  before_action :set_project
  before_action :set_milestone, only: [:show, :edit, :update, :destroy]

  # GET /milestones
  # GET /milestones.json
  def index
    redirect_to @project
  end

  # GET /milestones/1
  # GET /milestones/1.json
  def show
  end

  # GET /milestones/new
  def new
    @milestone = Milestone.new
  end

  # GET /milestones/1/edit
  def edit
  end

  # POST /milestones
  # POST /milestones.json
  def create
    @milestone = @project.milestones.new(milestone_params)
    @milestone.project_id = @project.id
    @milestone.status = "Pending"

    respond_to do |format|
      if @milestone.save
        format.html { redirect_to @project, notice: 'Milestone was successfully created.' }
        format.json { render :show, status: :created, location: @milestone }
      else
        format.html { render :new }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /milestones/1
  # PATCH/PUT /milestones/1.json
  def update
    respond_to do |format|
      if @milestone.update(milestone_params)
        format.html { redirect_to @project, notice: 'Milestone was successfully changed.' }
        format.json { render :show, status: :ok, location: @milestone }
      else
        format.html { render :edit }
        format.json { render json: @milestone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /milestones/1
  # DELETE /milestones/1.json
  def destroy
    @milestone.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Milestone was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def milestone_params
      params.require(:milestone).permit(:due_date, :name)
    end
end
