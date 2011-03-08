# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Terms
current_term = Term.create(:begin => Date.today, :end => Date.today + 1)

# Current Term
CurrentTerm.create(:term => current_term)

# Roles
admin = Role.create(:id => 1, :name => "admin")
applicant = Role.create(:id => 2, :name => "applicant")
campus_admin = Role.create(:id => 3, :name => "campus admin")
campus_reviewer = Role.create(:id => 4, :name => "campus reviewer")

# Organizations
uci = Organization.create(:id => 1, :name => "UC Irvine", :deadline => Date.today + 5)
ucd = Organization.create(:id => 2, :name => "UC Davis", :deadline => Date.today + 4)

# Users
User.create(:email => "a@a.com",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => admin,
  :active => true)

User.create(:email => "admin@uci.edu",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => campus_admin,
  :organization => uci,
  :active => true)

User.create(:email => "admin@ucd.edu",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => campus_admin,
  :organization => ucd,
  :active => true)

student_applicant = User.create(:email => "s@uci.edu",
  :first_name => "Congo",
  :last_name => "Jim",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => applicant,
  :organization => uci,
  :active => true)

# Award categories
faculty_initiative = AwardCategory.create(:id => 1,
  :name => "Faculty Initiative Grant"
)
faculty_research_planning = AwardCategory.create(:id => 2,
  :name => "Faculty Research/Planning Grant"
)
advanced_graduate_research = AwardCategory.create(:id => 3,
  :name => "Advanced Graduate Research"
)
  
# Proposals
Proposal.create(:title => "some fake proposal",
  :user => student_applicant,
  :term => current_term,
  :award_category => faculty_initiative)