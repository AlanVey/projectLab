class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_not_signed_in
    if !user_signed_in? 
      redirect_to '/', notice: "You must log in"
    end
  end

  def user_is_project_owner
    if current_user != Project.find(params[:id]).user
      redirect_to projects_path, notice: 'Only the project owner can make changes.'
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_project_user
    @project_user = ProjectUser.where(project_id: @project.id)
  end
  
end
