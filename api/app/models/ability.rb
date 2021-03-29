class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    alias_action :create, :read, :destroy, to: :crd

    user ||= User.new

    if user&.class == User
      can :manage, User, id: user.id
      can :crd, Order, user_id: user.id
      can :read, Dish
    elsif user&.class == Superuser
      can :manage, User
      can :manage, Dish
      can :manage, Order
      can :manage, Superuser
    end
  end
end
