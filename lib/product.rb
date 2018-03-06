class Product
  
  attr_accessor :name, :price, :quantity

  def initialize(name, price)
    @name = name
    @price = price
    @quantity = 10
  end

  def increase_quantity(amount = 1)
    if quantity > 0
      @quantity = self.quantity + amount
    else
      puts "Problem in increasing quantity -- current quantity = #{self.quantity}"
    end		
  end	
  
  def decrease_quantity(amount = 1)
    if quantity > 0
      @quantity = self.quantity - amount
    else
      puts "Problem in decreasing quantity -- current quantity = #{self.quantity}"
    end		
  end
  
  def restock(amount = 1)
    @quantity = self.increase_quantity(amount)
  end
  
  
end