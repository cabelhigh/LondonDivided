class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=Admin.new

    if user.has_role? :admin
      can :manage, :all
    else
      can :read, [Team, Item]
      can :update, Item
    end
  end
end
