# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Terms
current_term = Term.create(:begin => Date.today - 75, :end => Date.today + 23, :active => true)

# Roles
admin = Role.create(:id => 1, :name => "admin")
applicant = Role.create(:id => 2, :name => "applicant")
campus_admin = Role.create(:id => 3, :name => "campus admin")
campus_reviewer = Role.create(:id => 4, :name => "campus reviewer")
prrp_admin = Role.create(:id => 5, :name => "prrp admin")
prrp_reviewer = Role.create(:id => 6, :name => "prrp reviewer")

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

User.create(:email => "a@prrp.org",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => prrp_admin,
  :organization => ucd,
  :active => true)

pr_a = User.create(:email => "ra@prrp.org",
  :first_name => "Barnes",
  :last_name => "Lang",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :organization => uci,
  :role => prrp_reviewer,
  :active => true)

pr_b = User.create(:email => "rb@prrp.org",
  :first_name => "Rod",
  :last_name => "Danger",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :organization => uci,
  :role => prrp_reviewer,
  :active => true)

pr_c = User.create(:email => "rc@prrp.org",
  :first_name => "Cor",
  :last_name => "Roa",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :organization => ucd,
  :role => prrp_reviewer,
  :active => true)
  
sa_a = User.create(:email => "sa@uci.edu",
  :first_name => "Congo",
  :last_name => "Jim",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => applicant,
  :organization => uci,
  :active => true)

sa_b = User.create(:email => "sb@uci.edu",
  :first_name => "Renee",
  :last_name => "Forge",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => applicant,
  :organization => ucd,
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
p_a = Proposal.create(:title => "Deep Earth Mining in Chile",
  :user => sa_a,
  :term => current_term,
  :award_category => faculty_initiative)
  
p_b = Proposal.create(:title => "Video Game Culture in Asia",
  :user => sa_b,
  :term => current_term,
  :award_category => faculty_initiative)
  
Assignment.create(:term => current_term,
  :user => pr_a,
  :proposal => p_a
)