# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

u = User.create(:username => "AdminUser", :firstname => "Admin", :lastname => "User", :email => "admin@example.com", :password => "password")

Post.create(:title => "Sample blog", :body => "This blog will reset every Sunday at 00.00 CET", :user_id => u.id)
