class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role == 0
      can :manage, Tournament
      can :read, User
    elsif user.role == 1
      can :read, Tournament
      can :create, Registration
      cannot :create, Tournament
      cannot :update, Tournament
    else
      cannot :read, :all
    end
  end
end
