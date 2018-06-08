class Application

  @@items = ["Apples","Carrots","Pears"]
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
    else
      resp.write "Path Not Found"
    end

    def handle_search(search_term)
      if @@items.include?(search_term)
        return "#{search_term} is one of our items"
      else
        return "Couldn't find #{search_term}"
      end
    end

    def cart
      if @@cart = []
        return "The cart is empty."
      else
        return @@cart.collect do|item|
        "#{item}"
      end
    end
  end
end
