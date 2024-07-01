require "models/discount_rule"

class ApplyDiscount
  def initialize(cart_products, product_code)
    @cart_products = cart_products
    @product_code = product_code
  end

  def call
    return 0.00 if applicable_discounts.empty?

    best_suited_discount.calculate_discount(@cart_products)
  end

  private

  def applicable_discounts
    @applicable_discounts ||= DiscountRule.where(product_code: @product_code).select do |discount_rule|
      discount_rule.applies_to?(@cart_products)
    end
  end

  def best_suited_discount
    applicable_discounts.sort_by { |x| x.priority }.first
  end
end
