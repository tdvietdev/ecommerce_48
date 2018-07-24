class Ability
  include CanCan::Ability

  def initialize user
    if user.role.super_admin?
      can :manage, :all
    else
      user.role.permissions.map do |permission|
        can :manage, permission.subject_class.to_sym
      end
    end
  end
end
