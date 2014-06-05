class ProjectsController < ApplicationController
  before_filter :user_not_signed_in
  before_filter :user_is_project_owner, only: [:edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_project_user, only: :show
  before_filter :user_is_project_user_or_owner, only: :show

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.where(user: current_user)
    ProjectUser.where(user_id: current_user).each do |pjuser|
      Project.where(id: pjuser.project_id).each { |pj| @projects << pj }
    end 
    
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @milestones = Milestone.where(project_id: @project.id)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description)
    end

    def user_is_project_user_or_owner
      @project_user_or_owner = false

      if current_user.email == @project.user.email
        @project_user_or_owner = true
      else  
        @project.project_users.each {|pjuser| @project_user_or_owner = true if pjuser.user_id == current_user.id}
      end

      redirect_to projects_path if !@project_user_or_owner
    end

end
