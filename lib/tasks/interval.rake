namespace :check_time_10 do
  task :run => :environment do
    #Things that update every 10 minutes
    #Properties, outputting INF -- each property has a different interval
    #Contracts, adds money to team, one per team
    owned_properties = OwnedProperty.all

  end
end

namespace :check_time_hour do
    task :run => :environment do
      #Things that update on the hour
      #Property upkeep
    end

  end
