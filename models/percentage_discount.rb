require 'models/discount_strategy'
# Buy X Get Y discount strategy (multiple products with quantity requirement)
class PercentageDiscount < DiscountStrategy
  def initialize(discount_rule_attrs)
    super(discount_rule_attrs["product_code"], discount_rule_attrs["applier"])
    @minimum_quantity = discount_rule_attrs["minimum_quantity"]
    @discount_percentage = discount_rule_attrs["discount_percentage"]
  end

  def applies_to?(cart_products)
    cart_produce_quantity(cart_products) >= @minimum_quantity
  end

  def calculate_discount(cart_products)
    product_count = cart_produce_quantity(cart_products)
    product.price * @discount_percentage * product_count
  end

  private

  def cart_produce_quantity(cart_products)
    cart_products.count { |cart_product| cart_product.code == product_code }
  end
end
