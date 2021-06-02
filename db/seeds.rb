# rake db:seed
require 'faker'

# Se coloca un numero maximo de usuarios para probar en el servidor
puts Rails.env
puts "Ambiente de trabajo: #{Rails.env}"

# case "#{Rails.env}"
#   when "development"
#     limit = 10
#   else
#     limit = 50
# end

# puts limit

# Autor: Jackson Edward Flórez Jiménez
#
# Fecha creacion: 01-06-2021
#
# Autor actualizacion:
#
# Fecha actualizacion:
#
# Semilla para Drivers y Riders
puts "Empezando Divers y Riders..."
50.times do |aux|
  Driver.create(
  	name: "#{Faker::Name.name} #{Faker::Name.last_name } #{Faker::Name.last_name }",
  	plate_vehicle: Faker::Vehicle.license_plate
  )

  Rider.create(
    name: "#{Faker::Name.name} #{Faker::Name.last_name } #{Faker::Name.last_name }",
    email: Faker::Internet.email,
    phone_number: Random.rand(3000000000..3229999999)
  )
end
puts "Finalizando Divers y Riders..."

# Autor: Jackson Edward Flórez Jiménez
#
# Fecha creacion: 01-06-2021
#
# Autor actualizacion:
#
# Fecha actualizacion:
#
# Semilla para Drivers y Riders
puts "Empezando Trips..."
10.times do |aux|
  Trip.create(
    rider_id: Rider.order('RANDOM()').first.id,
    driver_id: Driver.order('RANDOM()').first.id,
    lat_ini: Faker::Address.latitude,
    lng_ini: Faker::Address.longitude,
    lat_end: Faker::Address.latitude,
    lng_end: Faker::Address.longitude
  )
end
puts "Finalizando Trips..."

# Autor: Jackson Edward Flórez Jiménez
#
# Fecha creacion: 01-06-2021
#
# Autor actualizacion:
#
# Fecha actualizacion:
#
# Creacion de administradores
puts "Empezando los super admins..."
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')# if Rails.env.development?
#AdminUser.create!(email: 'jackmaf0@gmail.com', password: '12345678', password_confirmation: '12345678')
puts "Finalizando los super admins..."