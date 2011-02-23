class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role.name == "admin"
      can :manage, :all
    elsif user.role.name == "applicant"
      can :apply, :proposal
    elsif user.role.name == "campus admin"
      can :administer, :campus_controls
      can :review, :proposals
    end
  end
end
