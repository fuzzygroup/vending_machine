Dir["lib/**.*"].each {|file| require_relative file}


class VendingMachine
  ACTIONS = [:buy, :pay, :refund, :cancel, :look, :status, :inventory, :stock, :restock, :quit]
  
  attr_accessor :products
  
  def initialize
    #
    # Create a customer 
    #
    @customer = Customer.new
    
    # 
    # Create a hash of products
    #
    @products = {
      "ABC" => Product.new("Snickers", 1.25),
      "DEF" => Product.new("Granola Bar", 0.75),
      "GHI" => Product.new("Doritos", 1.00),
      "JKL" => Product.new("Potato Chips", 1.00),
      "MNO" => Product.new("Twinkies", 0.95),
      "PQR" => Product.new("Diet Coke", 1.00),
    }
    
    #
    # Start the actual vending machine
    #
    start_machine
  end

  #
  # Return back an array of product_codes that can be used to check for inclusion
  #
  def product_codes
    codes = []
    @products.each do |product_code, product|
      codes << k
    end
    codes
  end
  
  #
  # Check if we are sold out of a given product
  #
  def product_is_available?(product_code)
    return true if @products[product_code].quantity > 0
    return false
  end
  
  def sell(product_code)
    selected_product = @products[product_code]
    
    if product_is_available?(product_code) && @customer.wallet > selected_product.price
      puts "Success!  You have purchased the desired product"
      
      # Decrement the product to indicate we sold something
      selected_product.decrease_quantity
      
      # Decrement the wallet
      @customer.wallet = @customer.wallet - selected_product.price
    
      
      # Restock the product; Assume a just in time inventory approach so we re-order every time we sell something
      selected_product.restock
      
    else
    end
  end
    
  def list_inventory
    puts "\n"
    self.products.each do |product_code,product|
      puts "#{product_code}: #{product.name} - $#{product.price}"
    end
    puts "\n"
    nil
  end
  
  def list_commands
    commands = ACTIONS.map(&:to_s)
    puts "Commands: #{commands.join(' ')}"
  end
  
  def start_machine
    while true
      print_status
      action = take_customer_input
      next unless ACTIONS.include?(action)
      take_action(action)
    end    
  end

  def take_customer_input
    print "What do you want to do?"
    gets.chomp.to_sym
  end
  
  def get_weather
    ["sunny", "cloudy", "rainy", "stormy", "snowy", "hot", "cold"].sample
  end
  
  def print_status
    puts "As a weary adventurer, you find yourself in a #{get_weather} forest.  In front of you stands a gleaming vending machine filled with tasty treats."
    puts "Things you can buy include:"
    list_inventory
    list_commands
    puts "You have: $#{@customer.list_money} to spend."
    @customer.list_money
  end
  
  def take_action(action)
    case action
    when :look, :status
      print_status
    when :buy
      
    when :pay
      
    when :refund
      
    when :cancel
      
    when :inventory
      
    when :stock
      
    when :restock
      
    when :quit
      quit
    end
  end
  
  def quit
    puts "\n\nThanks for trying this out; I can be reached at fuzzygroup@gmail.com or 317 531 4853 if you want to take the next step"
    exit
  end
  
end


VendingMachine.new