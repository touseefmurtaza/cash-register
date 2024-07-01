require "lib/total_price_calculator"

class Cart
  attr_reader :scanned_products

  def initialize
    @scanned_products = []
  end

  def add_product(product)
    @scanned_products << product
  end

  def total_price
    (TotalPriceCalculator.new(self).call || 0.00).round(2)
  end
end
