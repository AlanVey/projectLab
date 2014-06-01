class ProjectUsersController < ApplicationController
  before_filter :user_not_signed_in
  before_action :set_project
  before_action :set_project_user, only: [:show, :edit, :update, :destroy]

  # GET /project_users
  # GET /project_users.json
  def index
    redirect_to @project
  end

  # GET /project_users/1
  # GET /project_users/1.json
  def show
    redirect_to @project
  end

  # GET /project_users/new
  def new
    @project_user = ProjectUser.new
  end

  # POST /project_users
  # POST /project_users.json
  def create
    @project_user = @project.project_users.new(project_user_params)

    respond_to do |format|
      if @project_user.save
        format.html { redirect_to project_project_user_path(@project, @project_user), notice: 'Project user was successfully created.' }
        format.json { render :show, status: :created, location: @project_user }
      else
        format.html { render :new }
        format.json { render json: @project_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_users/1
  # DELETE /project_users/1.json
  def destroy
    @project_user.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Project user was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_user
      @project_user = ProjectUser.where(project_id: @project.id)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_user_params
      params.require(:project_user).permit(:email, :project_id)
    end
end
