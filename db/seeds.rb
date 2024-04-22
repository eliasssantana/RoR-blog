# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.where(email: "johdoe123@gmail.com").first_or_initialize
user.update!(
    password: "1234567",
    password_confirmation: "1234567"
)

20.times do |i|
    Post.create!(title: "Aliquam vitae odio neque #{i}", content: "Aliquam vitae odio neque. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nullam lacus dolor, interdum quis rhoncus sit amet, dapibus semper purus. Quisque commodo dolor sodales arcu mattis, sed gravida justo facilisis. Praesent sit amet scelerisque lacus, in mollis felis. Sed molestie sit amet felis accumsan placerat. In leo diam, maximus non pharetra sit amet, euismod eu sapien. Proin elementum ligula non ex posuere, vitae molestie nisi lacinia. Pellentesque commodo risus neque, tempus viverra lectus rutrum interdum.", user_id: user.id )
end
