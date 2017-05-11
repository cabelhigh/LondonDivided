class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=Admin.new

    if user.has_role? :admin
      can :manage, :all
    else
      can [:read, :get_clue, :buy_property], [Team, Quest, Clue]
    end
  end
end
