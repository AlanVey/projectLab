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

  def set_milestone
    @milestone = Milestone.find(params[:milestone_id])
  end

  def set_task
    @task = Task.find(params[:task_id])
  end

  def set_project_user
    @project_user = ProjectUser.where(project_id: @project.id)
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

  def update_milestone_status
    @statuses = Array.new
    @status = @milestone.status
    @milestone.tasks.each {|task| @statuses << task.status}

    if @statuses.size == 0 or @statuses.count('Created') == @statuses.size
      @milestone.status = 'Created'
    elsif (@statuses.count {|s| s == 'Pending Review' || s == 'Completed'}) != @statuses.size
      @milestone.status = 'Started' 
      if @project.started_at.nil?
        @project.started_at = Date.today
        @project.save
      end
    elsif @statuses.count('Completed') != @statuses.size
      @milestone.status = 'Pending Review'
    elsif @milestone.status != 'Completed'
      @milestone.status = 'Completed'
      @milestone.completion_date = Date.today
    end 

    @milestone.save if @milestone.status != @status 
  end
end
