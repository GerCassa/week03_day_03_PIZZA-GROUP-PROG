# Adding Customers to the Pizza Shop

Our pizza shop database currently has a limitation. It wouldn't be easy to find all the orders for a particular customer. 

If we think back to our ```characters``` and ```lightsabers``` exercise, how could we similarly model our pizza orders and customers? Is it a one-to-many relationship? Perhaps we need to separate the orders and the customers. This is known as ```normalising``` a database.

Your task is to: 

1. Modify the database by adding a ```customers``` table and removing the extraneous columns from the pizza_orders table.
2. Create a model (Ruby class) for customers with CRUD methods
3. Implement a ```customer``` method in the PizzaOrder class that returns a Customer object for that order.
4. Implement a ```pizza_orders``` method in the Customer class that returns all the orders for a Customer.

Your goal is to be able to do the following...

```ruby
order1 # is a PizzaOrder object
order1.customer # gets us a Customer object from our PizzaOrder object
order1.customer.pizza_orders # gets us an array of PizzaOrder objects
order1.customer.pizza_orders[0] # gets us just the first PizzaOrder object
order1.customer.pizza_orders[0].customer # gets us the same Customer object back again
```  

**NOTE:** When you're done, try refactoring your code. You'll notice that there is a lot of repeated code when it comes to executing the SQL. We can extract this into a separate class called SqlRunner which has a method that looks something like...

```ruby
def self.run(sql, values = [])
  # Connect to the DB
  # Prepare the SQL
  # Executre the SQL
  # Close the db connection
  # Return the results
end
```