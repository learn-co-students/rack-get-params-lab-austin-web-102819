class Application

  @@items = ["Figs", "Oranges"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
#new route called /cart
#responds with "Your cart is empty" if the cart is empty
    elsif req.path.match(/cart/)
      if @@cart.size == 0
        resp.write "Your cart is empty"
#responds w/ cart list if items in cart
      else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end 
    end 
#create new routh called /add
#takes in GET param w/ key item
  elsif req.path.match(/add/)
    add_item = req.params["item"]
#if item is in @@item, then add to cart
#w/ messsage added (item)
    if @@items.include?(add_item)
      @@cart << add_item
      resp.write "added #{add_item}"
    else
#will not add item to cart if not in the @@item list
#message will say "we dont have that item"
      resp.write "We don't have that item"
    end 
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
