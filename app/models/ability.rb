class Ability
  include CanCan::Ability

  # :manage :all - Do everything
  # :manage :users - Add/See Users
  # :apply  :proposal - Apply proposals
  # :review :proposals - 
  # :elect  :proposals -
  # :assign :proposals - Assign

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == nil
      can :do, :nothing
    else
      if user.role.name == 'admin'
        can :manage, :all
        can :manage, :users
      elsif user.role.name == 'applicant'
        can :apply, :proposal
      elsif user.role.name == 'campus admin'
        can :administer, :campus_controls
        can :manage, :users
        can :review, :proposals
        can :elect, :proposals
      elsif user.role.name == 'campus reviewer'
        can :review, :proposals
      elsif user.role.name == 'prrp admin'
        can :manage, :letters
        can :manage, :terms
        can :assign, :proposals
        can :pick, :winners
      elsif user.role.name == 'prrp reviewer'
        can :review, :proposals
      else
        can :do, :nothing
      end
    end
  end
end
