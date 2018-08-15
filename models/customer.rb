require('pg')

class Customer

attr_reader :id
attr_accessor :first_name, :last_name

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @first_name = info['first_name']
    @last_name = info['last_name']
  end

  def save()
    db = PG.connect({ dbname: "pizza_shop", host: "localhost"})
    sql = "INSERT INTO customers
      (first_name, last_name)
      VALUES
      ($1, $2) RETURNING *"
    values = [@first_name, @last_name]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({ dbname: "pizza_shop", host: "localhost"})
    sql = "UPDATE customers
    SET
    (first_name, last_name)
    =
    ($1, $2)
    WHERE id = $3"
    values = [@first_name, @last_name, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end


  def Customer.find_by_id(id)
    db = PG.connect({ dbname: "pizza_shop", host: "localhost"})
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    db.prepare("find_by_id", sql)
    result = db.exec_prepared("find_by_id", values)
    db.close()
    if result.count > 0
      return result[0]
    else
      return nil
    end
  end




  def Customer.all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    sql = "SELECT * FROM customers"
    db.prepare("all", sql)
    customers = db.exec_prepared("all")
    db.close()
    return customers.map {|customer| Customer.new(customer)}
  end


  def Customer.delete_all()
    db = PG.connect({ dbname: 'pizza_shop', host: 'localhost'})
    sql = "DELETE FROM customers"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


end
