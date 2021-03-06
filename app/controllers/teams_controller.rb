class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :payout, :buy_property, :get_clue, :send_message]
  before_action :authenticate_admin!, except: [:new, :create]
  load_and_authorize_resource

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all

    @r_points = gen_team_points "Rosarian"
    @l_points = gen_team_points "Lamplighter"

  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    if current_admin.has_role? :vendor
      @quests = []
      @quests = Quest.find(@team.recieved_quests.map(&:quest_id)).where(quest_type: "Item") if  !Quest.find(@team.recieved_quests.map(&:quest_id)).empty?
      render 'show_vendor.html.erb'
    else
      account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
      auth_token = "953bb0be1b63e1d1736e1b2030419da7"
      client = Twilio::REST::Client.new account_sid, auth_token
      @messages = client.account.messages.list.map{|m| m.body.tr('+','') if m.body.first == "+" && m.body.tr('+','').split(":").first==@team.phone_num}.compact
    end
  end

  #Putting this on ice for now until we can sort out the weird Twilio message-sending bug

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
    @team.save
    redirect_to @team
  end

  def get_contract
    result = @team.get_contract params["team"]["owned_contracts"]
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

  def recieve_quest
    result = @team.recieve_quest Quest.find_by_quest_name(params["team"]["recieved_quests"]).id
    respond_to do |format|
      if @team.save && result!=-1
        format.html { redirect_to @team, notice: 'Quest successfully received.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { redirect_to @team, notice: 'Team already has that quest.' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_clue
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

  def send_message
    account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
    auth_token = "953bb0be1b63e1d1736e1b2030419da7"
    client = Twilio::REST::Client.new account_sid, auth_token
    @team.send_message(client, params["message"])
  end

  def send_rosarians_message
    @r_teams = Team.where(faction: "Rosarian")
    account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
    auth_token = "953bb0be1b63e1d1736e1b2030419da7"
    client = Twilio::REST::Client.new account_sid, auth_token
    @r_teams.each{|t| t.send_message(client, params["message"])}
  end

  def send_lamplighters_message
    @l_teams = Team.where(faction: "Lamplighter")
    account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
    auth_token = "953bb0be1b63e1d1736e1b2030419da7"
    client = Twilio::REST::Client.new account_sid, auth_token
    @l_teams.each{|t| t.send_message(client, params["message"])}
  end

  def pick_random_rosarian
    session[:random_team]=Team.where(faction: "Rosarian").order("RANDOM()").first
    redirect_to :action => "index"
  end

  def pick_random_lamplighter
    session[:random_team]=Team.where(faction: "Lamplighter").order("RANDOM()").first
    redirect_to :action => "index"
  end

  def text_teams_at_hour
    @teams = Team.all
    account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
    auth_token = "953bb0be1b63e1d1736e1b2030419da7"
    client = Twilio::REST::Client.new account_sid, auth_token
    @teams.each{ |t| t.send_hour_message client }
  end

  def generate_sms_log
    account_sid = "AC9e9bfc18bbe241dbce81a0874e809d12"
    auth_token = "953bb0be1b63e1d1736e1b2030419da7"
    client = Twilio::REST::Client.new account_sid, auth_token
    @messages = client.account.messages.list.map{|m| "#{m.body.tr('+','')} -- #{(Time.parse(m.date_updated)-7.hours).strftime("%m/%d/%Y %I:%M %p")}"  if m.body.first == "+" && !Team.find_by_phone_num(m.body.tr('+','').split(":").first).nil?}.compact
    render 'sms_log.html.erb'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:phone_num, :id, :guild_name, :money, :blue_info, :red_info, :green_info, :orange_info, :owned_properties, team_attributes: [:owned_properties, :recieved_clues, :recieved_quests, :owned_contracts])
    end

    def gen_team_points faction
      total_points = 0
      @teams.each do |t|
        if t.faction == faction
          total_points+=t.owned_properties.count
          total_points+=Clue.find(t.recieved_clues.map(&:clue_id)).map(&:points).sum
        end
      end
      total_points
    end
end
