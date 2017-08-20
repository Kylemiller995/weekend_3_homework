require_relative( '../models/customers.rb' )
require_relative( '../models/films.rb' )
require_relative( '../models/tickets.rb' )

require( 'pry-byebug' )

Tickets.delete_all()
Films.delete_all()
Customers.delete_all()

customer1 = Customers.new({ 'name' => 'kyle', 'funds' => 5 })
customer1.save()
customer2 = Customers.new({ 'name' => 'bob', 'funds' => 10 })
customer2.save()

film1 = Films.new({ 'title' => 'dunkirk', 'price' => 11})
film1.save()
film2 = Films.new({ 'title' => 'atomic blonde', 'price' => 16})
film2.save()

ticket1 = Tickets.new({ 'customers_id' => customer1.id, 'films_id' => film1.id,})
ticket1.save()
ticket2 = Tickets.new({ 'customers_id' => customer2.id, 'films_id' => film2.id,})
ticket2.save()
ticket3 = Tickets.new({ 'customers_id' => customer1.id, 'films_id' => film2.id,})
ticket3.save()

binding.pry
nil
