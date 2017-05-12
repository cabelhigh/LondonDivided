namespace :check_time_10 do
  task :run => :environment do
    #Things that update every 10 minutes
    #Properties, outputting INF -- each property has a different interval
    #Contracts, adds money to team, one per team
    # 1 == 30, 2 == 20/40, 3 == 20/40/60, 6 == 10/20/30/40/50/60
    owned_properties = OwnedProperty.all
    owned_contracts = OwnedContract.all
    one_and_six = Property.where(num_times_hour: [1, 6]).map(&:id)
    two_three_and_six = Property.where(num_times_hour: [2, 3, 6]).map(&:id)
    three_and_six = Property.where(num_times_hour: [3, 6]).map(&:id)
    six = Property.where(num_times_hour: 6).map(&:id)
    c_one_and_six = Contract.where(upkeep: [1, 6]).map(&:id)
    c_two_three_and_six = Contract.where(upkeep: [2, 3, 6]).map(&:id)
    c_three_and_six = Contract.where(upkeep: [3, 6]).map(&:id)
    c_six = Contract.where(upkeep: 6).map(&:id)
    current_minutes = Time.now.strftime("%M").to_i

    owned_properties.each do |op|
      debugger
      t = Team.find(op.team_id)
      if current_minutes==0
        t.add_to_payout(Property.find(op.property_id).info_output, 1) if three_and_six.include? op.property_id
      end
      if current_minutes==10
        t.add_to_payout(Property.find(op.property_id).info_output, 1) if six.include? op.property_id
      end
      if current_minutes==20
        t.add_to_payout(Property.find(op.property_id).info_output, 1) if two_three_and_six.include? op.property_id
      end
      if current_minutes==30
        t.add_to_payout(Property.find(op.property_id).info_output, 1) if three_and_six.include? op.property_id
      end
      if current_minutes==40
        t.add_to_payout(Property.find(op.property_id).info_output, 1) if two_three_and_six.include? op.property_id
      end
      if current_minutes==50
        t.add_to_payout(Property.find(op.property_id).info_output, 1) if six.include? op.property_id
      end
      t.save
    end

    owned_contracts.each do |oc|
      t = Team.find(oc.team_id)
      if current_minutes==0
        t.add_to_payout(0, Contract.find(oc.contract_id).money_output) if c_three_and_six.include? op.contract_id
      end
      if current_minutes==10
        t = Team.find(oc.team_id).add_to_payout(0, Contract.find(oc.contract_id).money_output) if c_six.include? op.contract_id
      end
      if current_minutes==20
        t.add_to_payout(0, Contract.find(oc.contract_id).money_output) if c_two_three_and_six.include? op.contract_id
      end
      if current_minutes==30
        t.add_to_payout(0, Contract.find(oc.contract_id).money_output) if c_three_and_six.include? op.contract_id
      end
      if current_minutes==40
        t.add_to_payout(0, Contract.find(oc.contract_id).money_output) if c_two_three_and_six.include? op.contract_id
      end
      if current_minutes==50
        t.add_to_payout(0, Contract.find(oc.contract_id).money_output) if c_six.include? op.contract_id
      end
      t.save
    end
  end
end

namespace :check_time_hour do
    task :run => :environment do
      #Things that update on the hour
      #Property upkeep
      owned_properties = OwnedProperty.all
      owned_properties.each do |op|
        t = Team.find(op.team_id)
        t.pay_rent(Property.find(op.property_id).price)
        t.save
      end
    end

  end
