require 'faker'

# Create Users
5.times do
  user = User.new(
    name:       Faker::Name.name,
    email:      Faker::Internet.email,
    password:   Faker::Lorem.characters(10)
    )
  user.skip_confirmation!
  user.save!  
end
user = User.new(
  name:     'User',
  email:    'user@example.com',
  password: 'helloworld'
  )
user.skip_confirmation!
user.save!

user = User.new(
  name:     'Admin',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'admin'
  )
user.skip_confirmation!
user.save!
users = User.all

# Create Wikis
100.times do
  Wiki.create(
    user:   users.sample,
    title:  Faker::Lorem.sentence,
    body:   Faker::Lorem.paragraph
    )
end
wikis = Wiki.all

def create_user(name, email, password, role='standard')
  user = User.new(
    name: name,
    email: email,
    password: password,
    role: role
    )

end

puts "#{users.count} Users created."
puts "#{wikis.count} Wikis created."