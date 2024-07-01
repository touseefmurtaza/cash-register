require_relative '../test_helper'

RSpec.describe TotalPriceCalculator do
  let(:strawberry) { double(:product, code: 'SR1', price: 5.00) }
  let(:green_tea) { double(:product, code: 'GR1', price: 3.11) }
  let(:coffee) { double(:product, code: 'CF1', price: 11.23) }
  let(:all_products) { [strawberry, green_tea, coffee] }

  let(:ceo_discount) { BogoDiscount.new("free_quantity" => 1, "product_code" => "GR1", "buy_quantity" => 1, "applier" => "CEO" ) }
  let(:coo_discount) { ReducedPriceDiscount.new("new_price" => 4.50, "product_code" => "SR1", "minimum_quantity" => 3, "applier" => "COO" ) }
  let(:vp_discount) { PercentageDiscount.new("discount_percentage" => 0.3333334, "product_code" => "CF1", "minimum_quantity" => 3, "applier" => "VP" ) }
  let(:all_discount_rules) { [ceo_discount, coo_discount, vp_discount] }

  let(:cart) { Cart.new }

  subject do
    TotalPriceCalculator.new(cart)
  end

  before do
    allow(Product).to receive(:all).and_return(all_products)
    allow(DiscountRule).to receive(:all).and_return(all_discount_rules)
  end

  context "when cart has 2 green teas" do
    before do
      2.times { cart.add_product green_tea }
    end

    it "returns total price as 3.11" do
      expect(subject.call).to be_within(0.001).of(3.11)
    end
  end

  context "when cart has 3 strawnerries and 1 greentea" do
    before do
      cart.add_product strawberry
      cart.add_product strawberry
      cart.add_product green_tea
      cart.add_product strawberry
    end

    it "returns total price as 16.61" do
      expect(subject.call).to be_within(0.001).of(16.61)
    end
  end

  context "when cart has 3 coffees, 1 greentea, and 1 strawberry" do
    before do
      cart.add_product green_tea
      cart.add_product coffee
      cart.add_product strawberry
      cart.add_product coffee
      cart.add_product coffee

    end

    it "returns total price as 30.57" do
      expect(subject.call).to be_within(0.001).of(30.57)
    end
  end

  context "when cart has 3 coffees, 2 greentea, and 2 strawberry" do
    before do
      2.times { cart.add_product green_tea }
      3.times { cart.add_product strawberry }
      3.times { cart.add_product coffee }
    end

    it "returns total price as 39.07" do
      expect(subject.call).to be_within(0.001).of(39.07)
    end
  end
end
