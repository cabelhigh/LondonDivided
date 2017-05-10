class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :payout, :buy_property, :get_clue]
  before_action :authenticate_admin!, except: [:new, :create]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @public_view = true
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @public_view = true
    respond_to do |format|
      if @team.save
        format.html { render "thank_you.html.erb" }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    @team.outstanding_payout = @team.payout_properties
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def payout
    @team.store_payout
    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Payout successfully collected.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def buy_property
    result = @team.buy_property params["team"]["owned_properties"]
    respond_to do |format|
      if @team.save && result!=-1
        format.html { redirect_to @team, notice: 'Property successfully bought.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { redirect_to @team, notice: 'Team already owns that property.' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_clue
    debugger
    result = @team.get_clue Clue.find_by_name(params["team"]["recieved_clues"]).id
    respond_to do |format|
      if @team.save && result!=-1
        format.html { redirect_to @team, notice: 'Clue successfully received.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { redirect_to @team, notice: 'Team already has that clue.' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def text_teams_at_hour
    @teams = Team.all
    account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
    auth_token = "953bb0be1b63e1d1736e1b2030419da7"
    client = Twilio::REST::Client.new account_sid, auth_token
    @teams.each{ |t| t.send_hour_message client }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:phone_num, :guild_name, :money, :blue_info, :red_info, :green_info, :orange_info, :owned_properties, team_attributes: [:owned_properties, :recieved_clues, :recieved_quests, :owned_contracts])
    end
end
