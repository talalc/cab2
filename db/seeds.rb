# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.new
admin.email = "admin@admin.com"
admin.nick = "admin"
admin.password = "abcd1234"
admin.password_confirmation = "abcd1234"
admin.admin = true
admin.save

user = User.new
user.email = "user@user.com"
user.nick = "user"
user.password = "password"
user.password_confirmation = "password"
user.save


