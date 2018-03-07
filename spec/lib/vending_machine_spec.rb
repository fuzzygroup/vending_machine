require 'vending_machine'

describe VendingMachine do
  before(:each) do
    @products = Product.create_all
    @customer = Customer.new
    @vending_machine = VendingMachine.new
  end
  
  describe "#product_is_available?" do 
    it "should return true when the product is available" do
      expect(@vending_machine.product_is_available?("ABC")).to be_truthy
    end
  
    it "should return false when the product is not available" do
      expect(@vending_machine.product_is_available?("XYZ")).to be_falsey
    end
  end
  
  describe "#product_codes" do
    it "should return an array of product_codes" do
      expect(@vending_machine.product_codes).to eq ["ABC", "DEF", "GHI", "JKL", "MNO", "PQR"]
    end
  end
  
  describe "#get_weather" do
    it "should return a string with a randomized weather setting" do
      expect(@vending_machine.get_weather.class).to eq String
    end
  end
  
  describe "#print_status" do
    it "should receive the right messages" do
      expect(@vending_machine).to receive(:list_inventory)
      @vending_machine.print_status
    end
  end
  
  describe "#take_action" do
    it "should call print_status when look is entered" do
      expect(@vending_machine).to receive(:list_inventory)
      @vending_machine.take_action(:look)
    end

    it "should call print_status when status is entered" do
      expect(@vending_machine).to receive(:list_inventory)
      @vending_machine.take_action(:status)
    end
    
    it "should call buy_unspecific_product when no product code" do
      expect(@vending_machine).to receive(:buy_unspecific_product)
      @vending_machine.take_action(:buy)
    end

    it "should call cancel_product_sale when cancel specified" do
      expect(@vending_machine).to receive(:cancel_product_sale)
      @vending_machine.take_action(:cancel)
    end
    
    it "should call list_inventory when inventory specified" do
      expect(Product).to receive(:list_inventory)
      @vending_machine.take_action(:inventory)
    end

    it "should call restock on Product when restock specified" do
      expect(Product).to receive(:restock)
      @vending_machine.take_action(:restock)
    end
    
    it "should call quit when quit specified" do
      expect(@vending_machine).to receive(:quit)
      @vending_machine.take_action(:quit)
    end
  end
  
  
  
  # it "should create a customer with a wallet with $10 in it " do
  #   customer = Customer.new
  #   expect(customer.wallet).to eq 10.00
  # end
  #
  # it "should return true when the customer has enough funds to buy something" do
  #   customer = Customer.new
  #   expect(customer.can_buy?(1.00)).to be_truthy
  # end
  #
  # it "should return true when the customer has enough funds to buy something" do
  #   customer = Customer.new
  #   customer.wallet = 0.50
  #   expect(customer.can_buy?(1.00)).to be_falsey
  # end
  #
  # it "should return the amount of money in the wallet" do
  #   customer = Customer.new
  #   expect(customer.list_money).to eq 10.00
  # end
end