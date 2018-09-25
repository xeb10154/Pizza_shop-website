require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )
require_relative("./models/pizza_order")
also_reload("./models/*") # Reload all files in models folder


get "/" do
  erb(:HomePage)
end

# Index - all the pizzas
get "/pizza-orders" do
  @orders = PizzaOrder.all()
  erb(:index)
end

# Create a pizza (this route will clash with the one below if it is placed below the :id)
get "/pizza-orders/new" do
  erb(:new)
end

# show - show one pizza
get "/pizza-orders/:id" do
  @order = PizzaOrder.find(params[:id])
  erb(:show)
end

get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

# Create - make a pizza_order
post '/pizza-orders' do
  @order = PizzaOrder.new(params) # Params passes in all the input which comes in a hash format.
  @order.save()
  erb(:create)
end

post '/pizza-orders/:id/edit' do
  @order = PizzaOrder.new(params) # New object required to update
  @order.update()
  redirect "/pizza-orders"
end

post '/pizza-orders/:id/delete' do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  redirect "/pizza-orders"
end
