require "models/product"
require "models/priority"

class DiscountStrategy
  attr_reader :product_code, :applier

  def initialize(product_code, applier)
    @product_code = product_code
    @applier = applier
  end

  def applies_to?(cart_items)
    raise "Not implemented"
  end

  def calculate_discount(cart_items, original_price)
    raise "Not implemented"
  end

  def priority
    @priority ||= Priority.find(applier:)&.priority || Priority::DEFAULT_PRIORITY
  end

  private

  def product
    @product ||= Product.find(code: product_code)
  end
end
