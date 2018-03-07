class Customer
  
  attr_accessor :wallet
  
  def initialize
    self.wallet = 10.00
  end
  
  # tested
  def can_buy?(amount)
    return true if self.wallet > amount
    return false
  end
  
  def list_money
    return self.wallet
  end
  
  def pay(product)
    # Decrement the wallet; this automatically handles payment and is cleaner than a separate pay action
    # also no need to make change (think credit card based )
    self.wallet = self.wallet - product.price
  end
  
  def refund(product)
    self.wallet = self.wallet + product.price
  end
  
end