# config/initializers/system.rb
Dry::Rails.container do
  auto_register!("app/validations")
end