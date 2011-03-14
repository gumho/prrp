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
anr = Organization.create(:id => 1, :name => "Agriculture and Natural Resources", :deadline => Date.new(2011, 12, 10))
ucb = Organization.create(:id => 2, :name => "UC Berkeley", :deadline => Date.new(2011, 12, 6))
ucd = Organization.create(:id => 3, :name => "UC Davis", :deadline => Date.new(2011, 11, 16))
uci = Organization.create(:id => 4, :name => "UC Irvine", :deadline => Date.new(2011, 12, 3))
ucla = Organization.create(:id => 5, :name => "UC Los Angeles", :deadline => Date.new(2011, 12, 11))
ucm = Organization.create(:id => 6, :name => "UC Merced", :deadline => Date.new(2011, 12, 3))
ucr = Organization.create(:id => 7, :name => "UC Riverside", :deadline => Date.new(2011, 12, 15))
ucsd = Organization.create(:id => 8, :name => "UC San Diego", :deadline => Date.new(2011, 12, 1))
ucsf = Organization.create(:id => 9, :name => "UC San Francisco", :deadline => Date.new(2011, 11, 22))
ucsb = Organization.create(:id => 10, :name => "UC Santa Barbara", :deadline => Date.new(2011, 11, 29))
ucsc = Organization.create(:id => 11, :name => "UC Santa Cruz", :deadline => Date.new(2011, 12, 1))

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