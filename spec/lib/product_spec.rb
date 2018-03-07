require 'product'

describe Product do
  it "should create a product with a name, a price and the default quantity" do
    product = Product.new("Snickers", 0.95)
    expect(product.name).to eq "Snickers"
    expect(product.price).to eq 0.95
    expect(product.quantity).to eq 10
  end

  it "should increase the quantity of a product" do
    product = Product.new("Snickers", 0.95)
    expect(product.quantity).to eq 10
    product.increase_quantity(1)
    expect(product.quantity).to eq 11
  end

  it "should decrease the quantity of a product" do
    product = Product.new("Snickers", 0.95)
    expect(product.quantity).to eq 10
    #expect(product).to receive(:puts).with("Incorrect quantity")
    product.decrease_quantity
    expect(product.quantity).to eq 9
  end
  
  it "should restock the product" do 
    product = Product.new("Snickers", 0.95)
    expect(product.quantity).to eq 10
    product.restock
    expect(product.quantity).to eq 11
  end
  
  it "should restock" do 
    products = {}
    product = Product.new("Snickers", 0.95)
    product.quantity = 1
    products["ABC"] = product
    Product.restock(products, Product::DEFAULT_QUANTITY)
    expect(product.quantity).to eq Product::DEFAULT_QUANTITY
  end
  
  it "should create all" do
    products = Product.create_all
    expect(products.size).to eq 6
    expect(products.class).to eq Hash
  end

end