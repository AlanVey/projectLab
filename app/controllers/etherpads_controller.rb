class EtherpadsController < ApplicationController
  require 'securerandom'
  before_filter :user_not_signed_in
  before_action :set_project
  before_filter :user_is_project_user_or_owner
  before_action :set_etherpad, only: [:show, :edit, :update, :destroy]

  # GET /etherpads
  # GET /etherpads.json
  def index
    redirect_to :back
  end

  # GET /etherpads/1
  # GET /etherpads/1.json
  def show
  end

  # GET /etherpads/new
  def new
    @etherpad = Etherpad.new
  end

  # GET /etherpads/1/edit
  def edit
  end

  # POST /etherpads
  # POST /etherpads.json
  def create
    @etherpad = @project.etherpads.new(etherpad_params)
    @etherpad.creator = current_user.email
    @etherpad.file = "https://beta.etherpad.org/" + SecureRandom.hex

    respond_to do |format|
      if @etherpad.save
        format.html { redirect_to @project, notice: 'Etherpad was successfully created.' }
        format.json { render :show, status: :created, location: @etherpad }
      else
        format.html { render :new }
        format.json { render json: @etherpad.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /etherpads/1
  # PATCH/PUT /etherpads/1.json
  def update
    respond_to do |format|
      if @etherpad.update(etherpad_params)
        format.html { redirect_to @project, notice: 'Etherpad was successfully updated.' }
        format.json { render :show, status: :ok, location: @etherpad }
      else
        format.html { render :edit }
        format.json { render json: @etherpad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /etherpads/1
  # DELETE /etherpads/1.json
  def destroy
    @etherpad.destroy
    respond_to do |format|
      format.html { redirect_to @project, notice: 'Etherpad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_etherpad
      @etherpad = Etherpad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def etherpad_params
      params.require(:etherpad).permit(:name, :file, :creator)
    end
end
