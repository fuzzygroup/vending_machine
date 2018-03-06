class Customer
  
  attr_accessor :wallet
  
  def initialize
    self.wallet = 10.00
  end
  
  def buy?(amount)
    return true if self.wallet > amount
    return false
  end
  
  def list_money
    return self.wallet
  end
end