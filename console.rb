require("pry-byebug")
require_relative("models/pizza_order")
require_relative("models/customer")

# # PizzaOrder.delete_all()
#
#
  customer1 = Customer.new({
    "first_name" => "Darth",
    "last_name" => "Vader"
    })

#
# order1  = PizzaOrder.new({
#   "first_name" => "Luke",
#   "last_name" => "Skywalker",
#   "quantity" => "1",
#   "topping" => "Napoli"
#   })
#
# order2 = PizzaOrder.new({
#   "first_name" => "Darth",
#   "last_name" => "Vader",
#   "quantity" => "1",
#   "topping" => "Qauttro Formaggi"
#   })
#
# #EVIL ORDER
# # order3 = PizzaOrder.new({
# #   "first_name" => "Darth",
# #   "last_name" => "Vader",
# #   "quantity" => "1",
# #   "topping" => "); DELETE FROM pizza_orders;--"
# #   })
#

customer1.save()



# # orders = PizzaOrder.all()
#
binding.pry
nil
