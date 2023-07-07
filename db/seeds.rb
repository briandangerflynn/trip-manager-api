# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([
  { firstname: "Brian", lastname: "Flynn", email: "bdflynny@gmail.com" },
  { firstname: "Michael", lastname: "Scott", email: "michael@dm.com" },
  { firstname: "Dwight", lastname: "Schrute", email: "dwight@dm.com" },
  { firstname: "Jim", lastname: "Halpert", email: "jim@dm.com" },
  { firstname: "Pam", lastname: "Beesly", email: "pam@dm.com" }
])

Trip.create({
  status: "Not Started",
  owner: User.first,
  owner_name: "#{User.first.firstname} #{User.first.lastname}",
  assignee: User.second,
  assignee_name: "#{User.second.firstname} #{User.second.lastname}",
  location: "New York City",
  eta: Time.zone.now + 1.week,
  etc: Time.zone.now + 2.weeks,
  description: "Exploring the Big Apple",
  start_time: nil,
  end_time: nil
})
