class Product
  
  DEFAULT_QUANTITY = 10
  
  attr_accessor :name, :price, :quantity

  def initialize(name, price)
    @name = name
    @price = price
    @quantity = DEFAULT_QUANTITY
  end
  
  # tested
  def self.create_all
    {
      "ABC" => Product.new("Snickers", 1.25),
      "DEF" => Product.new("Granola Bar", 0.75),
      "GHI" => Product.new("Doritos", 1.00),
      "JKL" => Product.new("Potato Chips", 1.00),
      "MNO" => Product.new("Twinkies", 0.95),
      "PQR" => Product.new("Diet Coke", 1.00),
    }
  end
  
  # tested
  def self.restock(products, amount)
    products.each do |product_code, product|
      product.quantity = amount
    end
    puts "Inventory is reset to #{DEFAULT_QUANTITY} for each product"
    puts ""
  end
  
  # not tested; doesn't actually do anything except list data
  def self.list_inventory(products)
    puts "Here is the current product inventory:"
    products.each do |product_code, product|
      puts "  Product Code: #{product_code}"
      puts "  Name: #{product.name}"
      puts "  Amount: #{product.price}"
      puts "  Quantity: #{product.quantity}"
      puts ""
    end
  end

  # tested
  def increase_quantity(amount = 1)
    if quantity > 0
      @quantity = self.quantity + amount
    else
      puts "Problem in increasing quantity -- current quantity = #{self.quantity}"
    end		
  end	
  
  # tested
  def decrease_quantity(amount = 1)
    if quantity > 0
      @quantity = self.quantity - amount
    else
      puts "Problem in decreasing quantity -- current quantity = #{self.quantity}"
    end		
  end
  
  # tested
  def restock(amount = 1)
    @quantity = self.increase_quantity(amount)
  end
end