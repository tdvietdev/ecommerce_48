Role.create! name: "User"
Role.create! name: "Super Admin"
User.create!(
  name:  "Super Admin",
  email: "tdviet.dev@gmail.com",
  password: "12345678",
  password_confirmation: "12345678",
  phone: "01234567899",
  address: "Ha Noi, Viet Nam",
  role_id: 2)

20.times do |n|
  name  = Faker::Name.name
  email = "user#{n+1}@user.com"
  password = "12345678"
  phone = "012345679#{n+1}"
  address =  "Ha Noi#{n+1}, Viet Nam"
  User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    phone: phone,
    role_id: 1,
    address: address)
end
Category.create!(name: "Linh kiện khác", code: "00", parent_code: "0")
