class TotalPriceCalculator
  def initialize(cart)
    @cart = cart
  end

  def call
    count_per_product.map do |product_code, count|
      calculate_total_without_discount(product_code, count) - calculate_discount(product_code)
    end.sum
  end

  private

  def calculate_discount(product_code)
    ApplyDiscount.new(@cart.scanned_products, product_code).call
  end

  def calculate_total_without_discount(product_code, count)
    Product.find(code: product_code).price * count
  end

  def count_per_product
    @cart.scanned_products.group_by(&:code).transform_values(&:count)
  end
end
