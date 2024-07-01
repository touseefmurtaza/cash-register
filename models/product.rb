require "yaml"

class Product
  attr_reader :code, :name, :price

  def self.all
    YAML.load_file("products.yaml").map do |product_attrs|
      new(code: product_attrs["code"], name: product_attrs["name"], price: product_attrs["price"])
    end
  end

  def self.find(code:)
    all.find { |x| x.code == code }
  end

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end
end
