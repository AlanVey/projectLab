class CommentsController < ApplicationController
  before_filter :user_not_signed_in
  before_action :set_project
  before_action :set_milestone
  before_action :set_task
  before_action :set_comment, only: :destroy

  # GET /comments
  # GET /comments.json
  def index
    redirect_to project_milestone_task_path(@project, @milestone, @task)
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @task.comments.new(comment_params)
    @comment.creator_email = current_user.email

    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_milestone_task_path(@project, @milestone, @task), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to project_milestone_task_path(@project, @milestone, @task), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :task_id, :creator_email)
    end
end
