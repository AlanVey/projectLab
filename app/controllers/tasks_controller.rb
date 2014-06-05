class TasksController < ApplicationController
  before_filter :user_not_signed_in
  before_action :set_project
  before_action :set_milestone
  before_action :set_task, except: [:create, :new, :index]

  # GET /tasks
  # GET /tasks.json
  def index
    redirect_to project_milestone_path(@project, @milestone)
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = @milestone.tasks.new(task_params)
    @task.milestone_id = @milestone.id
    @task.status = "Created"
    @task.user_email = current_user.email

    if !Task.find_by(name: @task.name, milestone_id: @task.milestone_id).nil?
      redirect_to new_project_milestone_task_path(@project, @milestone), notice: 'Task already exists'
    else
      respond_to do |format|
        if @task.save
          format.html { redirect_to project_milestone_path(@project, @milestone), notice: 'Task was successfully created.' }
          format.json { render :show, status: :created, location: @task }
        else
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_milestone_task_path(@project, @milestone, @task), notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_milestone_path(@project, @milestone), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def start_status
    @task.status = 'Started'
    @task.owner_email = current_user.email
    @task.save
    redirect_to project_milestone_path(@project, @milestone)
  end

  def review_status
    @task.status = 'Pending Review'
    @task.save
    redirect_to project_milestone_path(@project, @milestone)
  end

  def complete_status
    @task.status = 'Completed'
    @task.save
    redirect_to project_milestone_path(@project, @milestone)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_milestone
      @milestone = Milestone.find(params[:milestone_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :description, :difficulty, :priority)
    end
end
