require("pg")
require_relative("customer")

class PizzaOrder
  attr_reader :id, :customer_id
  attr_accessor :quantity, :topping

  def initialize (options)
    @id = options["id"].to_i if options["id"]
    @quantity = options["quantity"].to_i
    @topping = options["topping"]
    @customer_id = options["customer_id"].to_i if options["customer_id"]

  end

  def save()
    db = PG.connect({ dbname: "pizza_shop", host: "localhost"})
    sql = "INSERT INTO pizza_orders
        (quantity, topping, customer_id)
        VALUES
        ($1, $2, $3) RETURNING *"
    values = [@quantity, @topping, @customer_id]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def delete()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    sql = "DELETE FROM pizza_orders
    WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    sql = "UPDATE pizza_orders
    SET
    (quantity, topping, customer_id)
    =
    ($1,$2,$4)
    WHERE id = $3"
    values = [@quantity, @topping, @id, @customer_id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def customer
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    sql = "SELECT * FROM customers
           WHERE customer_id = $1"
    values = [@customer_id]
    db.prepare("customer", sql)
    result = db.exec_prepared("customer", values)
    db.close()
    return result[0]
  end






#using self also works to avoid writting class name.
  def PizzaOrder.all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    sql = "SELECT * FROM pizza_orders"
    db.prepare("all", sql)
    orders = db.exec_prepared("all")
    db.close()
    return orders.map {|order| PizzaOrder.new(order)}
  end

  def PizzaOrder.delete_all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    sql = "DELETE FROM pizza_orders"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


end
