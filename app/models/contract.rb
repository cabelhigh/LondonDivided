class Contract < ApplicationRecord

  def format_upkeep
    "#{sprintf "%02d", upkeep/60}:#{sprintf "%02d", upkeep%60}"
  end

end
