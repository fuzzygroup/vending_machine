require_relative 'product'
require_relative 'customer'


class VendingMachine
  ACTIONS = [:look, :status, :buy, :pay, :cancel, :inventory, :restock, :quit]
  
  
  attr_accessor :products
  
  
  def initialize
    #
    # Create a customer 
    #
    @customer = Customer.new
    
    # 
    # Create a hash of all products
    #
    @products = Product.create_all
    
    #
    # A variable for saving the last product purchased so it can be cancelled
    #
    @last_product = nil
    @last_product_code = nil
    
    #
    # Start the actual vending machine
    #
    start_machine
  end
  
  
  #
  # This is the actual vending machine itself; this and take_action are the key routines
  # No test coverage; see note below
  #
  def start_machine
    #
    # This is an ugly hack to abort the start_machine routine which gets in the way of the 
    # normal spec functionality
    # This allows testing of the routines that aren't start_machine
    #
    return if ARGV[0] =~ /spec/
    
    
    while true
      print_status
      action = take_customer_input
      #raise action.inspect
      #raise (action.to_s =~ /buy [A-Z][A-Z][A-Z]/i).inspect
      next unless ACTIONS.include?(action) || action.to_s =~ /buy [A-Z][A-Z][A-Z]/i
      #next unless action.to_s =~ /buy [A-Z][A-Z][A-Z]/i
      take_action(action)
    end    
  end
  
  
  #
  # Note the if / elsif is inelegant when compared to a case statement but it is 
  # more flexible allowing for the buy ABC command structure needed
  #
  def take_action(action)
    if action == :look || action == :status
      print_status
    elsif action == :buy
      buy_unspecific_product
    elsif action.to_s =~ /buy ([A-Z][A-Z][A-Z])/i
      buy_specific_product($1)
    elsif action == :pay
      @customer.pay(@last_product) 
    elsif action == :cancel
      cancel_product_sale
    elsif action == :inventory
      Product.list_inventory(@products)      
    elsif action == :restock
      Product.restock(@products, Product::DEFAULT_QUANTITY)      
    elsif action == :quit
      quit
    end
  end  
  
  
  #
  # A routine to display output a little better than normal
  #
  def pretty_puts(str)
    puts ""
    puts "*** #{str} ***"
    puts ""
  end


  #
  # Return back an array of product_codes that can be used to check for inclusion
  # Note this could be reduced to a 1 liner with a functional expression; left this way for clarity
  # tested
  #
  def product_codes
    codes = []
    @products.each do |product_code, product|
      codes << product_code
    end
    codes
  end
  
  #
  # Check if we are sold out of a given product
  # tested
  # 
  def product_is_available?(product_code)
    product = @products[product_code]
    return true if product && product.quantity > 0
    return false
  end
  
  
  def sell(product_code)
    selected_product = @products[product_code]
    
    if product_is_available?(product_code) && @customer.wallet > selected_product.price
      pretty_puts "Success!  You have purchased the desired product"
      
      # Decrement the product to indicate we sold something
      selected_product.decrease_quantity
      
      # Restock the product; Assume a just in time inventory approach so we re-order every time we sell something
      selected_product.restock   
      
      @last_product = selected_product
      @last_product_code = product_code   
    elsif !product_is_available?(product_code)
      #
      # Note due to the .restock call above this shouldn't be possible but it should be handled
      #
      pretty_puts "The product you requested isn't available"
    elsif @customer.wallet < selected_product.price
      #
      # Note - could have been handled by an else clause but wanted the logic to be explicity
      #
      pretty_puts "You don't have enough money to purchase the product"
    end
  end
    
    
  #
  # Lists out the inventory
  # No test coverage; doesn't actually do anything
  #
  def list_inventory
    puts "\n"
    self.products.each do |product_code,product|
      puts "#{product_code}: #{product.name} - $#{product.price}"
    end
    puts "\n"
    nil
  end


  #
  # Lists out the commands
  # No test coverage; doesn't actually do anything
  #
  def list_commands
    puts "Commands: #{ACTIONS.map(&:to_s).join(' ')}"
    puts "  If you want to buy something then enter buy ABC where ABC means the product you want to buy"
  end
  
  


  #
  # Gets the customer input and passes it back to start_machine
  # No test coverage; not the type of thing that RSpec does well
  #
  def take_customer_input
    print "What do you want to do?  "
    gets.chomp.to_sym
  end
  
  
  #
  # Return a randomized weather string to bring a little variety to this
  #
  def get_weather
    ["sunny", "cloudy", "rainy", "stormy", "snowy", "hot", "cold"].sample
  end
  
  
  #
  # Master status dispaly
  # No test coverage; doesn't really do anything
  #
  def print_status
    puts "As a weary adventurer, you find yourself in a #{get_weather} forest.  In front of you stands a gleaming vending machine filled with tasty treats."
    puts "Things you can buy include:"
    list_inventory
    list_commands
    puts "You have: $#{@customer.list_money} to spend."
    @customer.list_money
  end
  
  #
  # Handle the case of someone typing buy without giving a product code
  #
  def buy_unspecific_product
    pretty_puts "You didn't specify the product you want to buy.  Please enter your command like buy ABC where ABC is the code for what you want to buy."
  end
  
  #
  # Handle buying a specific product; really just a wrapper on top of sell
  # Here mostly because having it normalizes the command grammar 
  #
  def buy_specific_product(product_code)
    # handle lowercase product codes just in case
    product_code.upcase! if product_code =~ /[a-z]/
    
    sell(product_code)
  end
  
  
  def cancel_product_sale
    if @last_product.nil?
      pretty_puts "You never purchased anything so you aren't eligible to cancel a product for a refund"
      return
    end
    # need to put the money back in the wallet
    @customer.refund(@last_product)
    
    # need to add it back to inventory
    @last_product.increase_quantity(1)
    
    # TODO no real way to deal wtih the restocking that has already happened
  end
  
  
  def quit
    pretty_puts "Thanks for trying this out; I can be reached at fuzzygroup@gmail.com or 317 531 4853 if you want to take the next step"
    exit
  end
  
end


VendingMachine.new