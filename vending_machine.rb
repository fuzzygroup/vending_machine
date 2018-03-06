Dir["lib/**.*"].each {|file| require_relative file}


class VendingMachine
  ACTIONS = [:buy, :pay, :refund, :cancel, :look, :status, :inventory, :stock, :restock]
  
  def initialize
    @customer = Customer.new    
    start_machine
  end
  
  private
  
  def list_inventory
    Inventory.list.join(", ")
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
    print "What do you want to buy?"
    gets.chomp.to_sym
  end
  
  def get_weather
    ["sunny", "cloudy", "rainy", "stormy", "snowy", "hot", "cold"].sample
  end
  
  def print_status
    puts "As a weary adventurer, you find yourself in a #{get_weather} forest.  In front of you stands a gleaming vending machine filled with tasty treats."
    puts "Things you can buy include: #{list_inventory}"
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
      
    end
  end
  
end


VendingMachine.new