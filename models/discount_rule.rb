require "models/bogo_discount"
require "models/percentage_discount"
require "models/reduced_price_discount"

class DiscountRule
  DISCOUNT_TYPE_MAPPER = {
    "BogoDiscount" => BogoDiscount,
    "PercentageDiscount" => PercentageDiscount,
    "ReducedPriceDiscount" => ReducedPriceDiscount
  }.freeze

  def self.all
    YAML.load_file("discount_rules.yaml").map do |rule_attrs|
      DISCOUNT_TYPE_MAPPER[rule_attrs["type"]].new(rule_attrs)
    end
  end

  def self.where(product_code:)
    all.select { |x| x.product_code == product_code }
  end
end
