class Contract < ApplicationRecord


  def format_upkeep
    case self.upkeep; when 1; "30"; when 2; "20 and 40"; when 3; "20, 40, and 60"; when 6; "10, 20, 30, 40, 50, and 60"; end
  end
end
