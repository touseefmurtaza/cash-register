require 'models/discount_strategy'
# Reduced price discount strategy
class ReducedPriceDiscount < DiscountStrategy
  def initialize(discount_rule_attrs)
    super(discount_rule_attrs["product_code"], discount_rule_attrs["applier"])
    @minimum_quantity = discount_rule_attrs["minimum_quantity"]
    @new_price = discount_rule_attrs["new_price"]
  end

  def applies_to?(cart_products)
    cart_produce_quantity(cart_products) >= @minimum_quantity
  end

  def calculate_discount(cart_products)
    product_count = cart_produce_quantity(cart_products)
    product_count * (product.price - @new_price)
  end

  private

  def cart_produce_quantity(cart_products)
    cart_products.count { |cart_product| cart_product.code == product_code }
  end
end
