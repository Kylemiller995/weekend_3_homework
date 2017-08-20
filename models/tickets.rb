require_relative("../db/sql_runner")
require_relative("./customers.rb")
require_relative("./films.rb")

class Tickets

  attr_reader :id
  attr_accessor :Customer_id, :film_id

  def initialize( options )
    @id = options['id'].to_i
    @customers_id = options['user_id'].to_i
    @films_id = options['location_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customers_id,
      films_id,
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customers_id, @films_id,]
    ticket = SqlRunner.run( sql,values ).first
    @id = ticket['id'].to_i
  end

  def Tickets.all()
    sql = "SELECT * FROM tickets"
    values = []
    ticket_data = SqlRunner.run(sql, values)
    return Tickets.map_items(ticket_data)
  end

  def Tickets.delete_all()
   sql = "DELETE FROM tickets"
   values = []
   SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT *
    FROM customers
    WHERE id = $1"
    values = [@customers_id]
    user = SqlRunner.run(sql, values).first
    return Customers.new(user)
  end

  def films()
    sql = "SELECT *
    FROM films
    WHERE id = $1"
    values = [@films_id]
    film = SqlRunner.run(sql, values).first
    return Films.new(film)
  end

  def Tickets.map_items(ticket_data)
    result = ticket_data.map { |ticket| Tickets.new( ticket ) }
    return result
  end

end
