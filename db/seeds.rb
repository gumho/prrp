# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# Roles
admin = Role.create(:id => 1, :name => "admin")
applicant = Role.create(:id => 2, :name => "applicant")
campus_admin = Role.create(:id => 3, :name => "campus admin")


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

User.create(:email => "stu@ucd.edu",
  :password => "pppp", 
  :password_confirmation => "pppp", 
  :role => applicant,
  :organization => ucd,
  :active => true)