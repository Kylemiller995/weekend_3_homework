require_relative("../db/sql_runner")

class Films

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO locations
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def Film.all()
    sql = "SELECT * FROM films"
    values = []
    film_data = SqlRunner.run(sql, values)
    return Films.map_items(film_data)
  end

  def Film.delete_all()
   sql = "DELETE FROM films"
   values = []
   SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customer.id
    WHERE film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return Customers.map_items(customer_data)
  end

  def Films.map_items(film_data)
    result = film_data.map { |location| Films.new( film ) }
    return result
  end

end
