require 'customer'
require 'product'

describe Customer do
  describe ".initialize" do
    it "should create a customer with a wallet with $10 in it " do
      customer = Customer.new
      expect(customer.wallet).to eq 10.00
    end
  end

  describe "#can_buy?" do 
    it "should return true when the customer has enough funds to buy something" do
      customer = Customer.new
      expect(customer.can_buy?(1.00)).to be_truthy
    end

    it "should return true when the customer has enough funds to buy something" do
      customer = Customer.new
      customer.wallet = 0.50
      expect(customer.can_buy?(1.00)).to be_falsey
    end
  end

  describe "#list_money" do
    it "should return the amount of money in the wallet" do
      customer = Customer.new
      expect(customer.list_money).to eq 10.00
    end
  end
  
  describe "#pay" do
    it "should decrement the wallet by the amount of the product" do
      products = Product.create_all
      customer = Customer.new
      customer.pay(products["ABC"])
      expect(customer.wallet).to eq 8.75
    end
  end
  
  describe "#refund" do 
    it "should remove from the wallet the amount of the specified product" do
      products = Product.create_all
      customer = Customer.new
      customer.refund(products["ABC"])
      expect(customer.wallet).to eq 11.25
    end
  end
end