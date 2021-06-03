# Vlipco Back End Dev Test

This test is intended to evaluate various aspects of back end development, like code
clarity, API / endpoints definition, design simplicity, test coverage or correct use of
the HTTP protocol, in a real-life like scenario.
You are in charge of:
The overall design of the API and information architecture (DB schema, folder
structure, etc)
Deciding what data should be requested/responded on each endpoint
Deciding what validations each endpoint should perform, thinking of real-life
situations that could arise
Safely handling sensitive data.

## The story
In this test you must build a JSON RESTful API, for a small ride-hailing service, that
will use the Wompi API (https://docs.wompi.co/docs/en-us/inicio-rapido) for
monetary transactions. For starters, you must:
Create an account at https://comercios.wompi.co • You can use your own
personal information
Make sure you use the Sandbox environment. That means, there's NO need for
any real money transactions, in the context of this test.
The API you create must have 2 different types of users, rider and driver. They must
perform different types of requests, listed below:

## Rider:
Create a payment method for a rider: Using a PREVIOUSLY tokenized card
(something out of the scope of this test; you can tokenize one manually
beforehand), and thus creating a Payment Source
(https://docs.wompi.co/docs/en-us/fuentes-de-pago) in order to make multiple
transactions in the future, so that the rider doesn't have to input credit card data
every time (like in real-world apps where you input card data just once). Please

NEVER request credit card information in your API, this is a risky and potentially
illegal thing to do.
Request a ride: Sending the user's current location (latitude, longitude), among
other data you consider necessary. The API must immediately:
1. Assign a driver (unlike real-world situations where the driver is assigned
moments later)
2. Start a ride

## Driver:
Finish a ride: Given its ID and final location (assume the ride is a straight line in
the map). It must immediately:
Calculate the total amount to be paid, given these fees:
COP $1000 for each km
COP $200 for every minute elapsed
COP $3500 base fee, added always
Create a transaction, using the Wompi API and charging the user the total
amount

## General considerations:
You CANNOT USE Ruby on Rails. We recommend using other frameworks like
Grape or Sinatra.
Business logic must NOT be handled within the routing / controller layer, but on
a separate layer

You must use the Dry Validation gem (https://dry-rb.org/gems/dry-
validation/1.4/) for performing validations on all endpoints. Hint: Do NOT validate

data on the routing/transport layer of the API (Grape validations are a no go, for
example)
You can use any type of database. We recommend using PostgreSQL, as Heroku
supports it.
You can use any type of ORM and serialization library. We recommend using
Sequel.
The database must be seeded with dummy Drivers, with their current location
(so that there are drivers to choose from whenever a rider requests a ride), and
Riders. There's NO need for an endpoint to create new drivers or riders.

Your code must have unit and integration tests, written in your library of choice
(RSpec, minitest, etc.)
You must push your code to Github as a public repository. Other services such
as BitBucket, etc. are NOT allowed. Please do NOT use words like “Vlipco”
(company name), in your repository.
You must write a README file (in english) with instructions for:
Running the code locally
Running the tests
You must deploy your app using Heroku.

## Expected time of completion:
We expect you to dedicate a maximum of 25 working hours to complete this test.

# Ruby version 2.7.3
# Rails version >= 6.1.3.2

## Getting started

1. clone or download the project first
```bash
git clone git@github.com:jackmaf/back_end_dev_test_senior_rails_07.git
```
2. locate yourself in the project back_end_dev_test_senior_rails_07
```bash
cd back_end_dev_test_senior_rails_07
```
3. install ruby on rails with:
[RVM](https://rvm.io/)
or
[RBENV](https://gorails.com/setup/osx/11.0-big-sur)

4. install gems
```bash
bundle install
```
5. change configurations the connect to  postgresqlcambiar configuraciones de conexion de postgresql on /config/database.yml

6. create database and migrations
```bash
rake db:create db:migrate
```
7. run seed data
```bash
rake db:seed
```
8. run webserver(Puma)
```bash
rails server
```
9. login to admin through your browser
```bash
http://localhost:3000
```
10. admin login data
```bash
admin_user:      admin@example.com
admin_password:  password
```

## Usage
### 1. Begin Trip
1.1 look for the id in the administration of a driver
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/search_driver.png)
1.2 look for the id in the administration of a river
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/search_rider.png)
1.3 find a latitude and longitude in google maps
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/maps.png)
1.4 create trip with next data example:
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/create_trip.png)
1.5 look for the id in the administration of a trip
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/search_trip.png)

### 2. End Trip
2.1 look for the id in the administration of a trip
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/search_trip.png)
2.2 find a latitude and longitude in google maps
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/maps.png)
2.3 update trip with next data example:
Note: minutes are lapse of time imaginary that its take the trip
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/update_trip.png)
2.4 look for the id in the administration of a trip
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/search_trip.png)

### 3. to pay the trip
3.1 look for the id in the administration of a trip
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/search_trip.png)
3.2 create payment with next data example:
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/create_payment.png)
3.3 check the payment in the admin
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/admin_payments.png)
3.4 check the payment in wompi
![I1](https://github.com/jackmaf/back_end_dev_test_senior_rails_07/doc/guide_readme_images/wompi.png)

### 4. Testing with Rspec

## Thanks

Thanks for checking my code :D


## Contributing

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)