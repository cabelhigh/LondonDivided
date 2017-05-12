class CluesController < ApplicationController
  before_action :set_clue, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!
  load_and_authorize_resource

  # GET /clues
  # GET /clues.json
  def index
    @clues = Clue.all

    unless params["search"].nil?
      case params["search"]
      when "dw"
        @clues=Clue.where(clue_subject: "Dorothy Wimberly")
      when "el"
        @clues=Clue.where(clue_subject: "Erick Lewis")
      when "hu"
        @clues=Clue.where(clue_subject: "London University")
      when "th"
        @clues=Clue.where(clue_subject: "Theodore Humphries")
      when "irene"
        @clues=Clue.where(quest_giver: "Irene")
      when "kyle"
        @clues=Clue.where(quest_giver: "Kyle")
      when "paul"
        @clues=Clue.where(quest_giver: "Paul")
      when "dwight"
        @clues=Clue.where(quest_giver: "Dwight")
      when "1"
        @clues=Clue.where(points: 1)
      when "2"
        @clues=Clue.where(points: 2)
      when "3"
        @clues=Clue.where(points: 3)
      end
    end
  end

  # GET /clues/1
  # GET /clues/1.json
  def show
  end

  # GET /clues/new
  def new
    @clue = Clue.new
  end

  # GET /clues/1/edit
  def edit
  end

  # POST /clues
  # POST /clues.json
  def create
    @clue = Clue.new(clue_params)

    respond_to do |format|
      if @clue.save
        format.html { redirect_to @clue, notice: 'Clue was successfully created.' }
        format.json { render :show, status: :created, location: @clue }
      else
        format.html { render :new }
        format.json { render json: @clue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clues/1
  # PATCH/PUT /clues/1.json
  def update
    respond_to do |format|
      if @clue.update(clue_params)
        format.html { redirect_to @clue, notice: 'Clue was successfully updated.' }
        format.json { render :show, status: :ok, location: @clue }
      else
        format.html { render :edit }
        format.json { render json: @clue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clues/1
  # DELETE /clues/1.json
  def destroy
    @clue.destroy
    respond_to do |format|
      format.html { redirect_to clues_url, notice: 'Clue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clue
      @clue = Clue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def clue_params
      params.require(:clue).permit(:name, :description, :day, :clue_subject, :points, :quest_giver)
    end
end
