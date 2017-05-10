# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dummy_teams = Team.create([{phone_num: "1234567890"}, {phone_num: "897-123-0987"}, {phone_num: "222-555-1111"}])

dummy_properties = Property.create([{price: 2, money_output: 1, info_output: 1, district: 0}, {price: 5, money_output: 2, info_output: 3, district: 1}, {price: 4, money_output: 3, info_output: 0, district: 2}, {price: 7, money_output: 3, info_output: 3, district: 3}])

dummy_clues = Clue.create({name: "A new clue", day:1, faction:1, points:2, description: "I heard they found marks on her skin -- marks! No bruises or nothing...only long, deep gashes and hundreds of small pinpricks."})
