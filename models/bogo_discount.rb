require 'models/discount_strategy'
# Buy X Get Y discount strategy (multiple products with quantity requirement)
class BogoDiscount < DiscountStrategy
  def initialize(discount_rule_attrs)
    super(discount_rule_attrs["product_code"], discount_rule_attrs["applier"])
    @buy_quantity = discount_rule_attrs["buy_quantity"]
    @free_quantity = discount_rule_attrs["free_quantity"]
  end

  def applies_to?(cart_products)
    cart_products.count { |cart_product| cart_product.code == product_code } >= @buy_quantity
  end

  def calculate_discount(cart_products)
    product_count = cart_products.count { |cart_product| cart_product.code == product_code }
    full_offers = product_count / (@buy_quantity + @free_quantity)
    remaining_products = product_count % (@buy_quantity + @free_quantity)

    free_count = full_offers * @free_quantity
    free_count += remaining_products - @buy_quantity if remaining_products > @buy_quantity

    free_count * product.price
  end
end
