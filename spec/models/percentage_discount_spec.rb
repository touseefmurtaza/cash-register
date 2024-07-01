require_relative '../test_helper'

RSpec.describe PercentageDiscount do
  let(:cart_products_quantity) { 3 }
  let(:discount_product_code) { "SR1" }
  let(:other_product_code) { "GR1" }
  let(:product) { Product.find(code: discount_product_code) }
  let(:other_product) { Product.find(code: other_product_code) }
  let(:cart_products) do
    1.upto(cart_products_quantity).map { product }
  end
  let(:minimum_quantity) { 3 }
  let(:discount_percentage) { 0.3333334 }

  subject do
    PercentageDiscount.new(
      {
        "discount_percentage" => discount_percentage, "minimum_quantity" => minimum_quantity,
        "product_code" => discount_product_code, "applier" => "CEO"
      }
    )
  end

  describe "#applies_to" do
    context "when cart is empty" do
      let(:cart_products) { [] }

      it "returns false" do
        expect(subject.applies_to?(cart_products)).to be false
      end
    end

    context "when cart has other products only" do
      let(:cart_products) { [other_product, other_product] }

      it "returns false" do
        expect(subject.applies_to?(cart_products)).to be false
      end
    end

    context "when discount product quantity 1" do
      let(:cart_products_quantity) { 1 }

      it "returns false" do
        expect(subject.applies_to?(cart_products)).to be false
      end
    end

    context "when discount product quantity 1 and cart has other products as well" do
      let(:cart_products) { [product, other_product, other_product, other_product] }

      it "returns false" do
        expect(subject.applies_to?(cart_products)).to be false
      end
    end

    context "when discount product quantity 1" do
      let(:cart_products_quantity) { 2 }

      it "returns false" do
        expect(subject.applies_to?(cart_products)).to be false
      end
    end

    context "when discount product quantity 1 and cart has other products as well" do
      let(:cart_products) { [product, other_product, other_product, other_product, product] }

      it "returns false" do
        expect(subject.applies_to?(cart_products)).to be false
      end
    end

    (3..4).to_a.each do |cart_quantity|
      context "when discounted products quantity #{cart_quantity}" do
        let(:cart_products_quantity) { cart_quantity }

        it "returns false" do
          expect(subject.applies_to?(cart_products)).to be true
        end
      end
    end

    context "when discounted products quantity 3 and it cart has other products as well" do
      let(:cart_products) { [other_product, other_product, product, product, other_product, product] }

      it "returns false" do
        expect(subject.applies_to?(cart_products)).to be true
      end
    end
  end

  describe "#calculate_discount" do
    (3..4).to_a.each do |cart_quantity|
      context "when discounted products quantity #{cart_quantity}" do
        let(:cart_products_quantity) { cart_quantity }

        it "returns false" do
          expect(subject.calculate_discount(cart_products)).to be_within(0.01).of(product.price * cart_products_quantity * discount_percentage)
        end
      end
    end

    context "when discounted products quantity 3 and it cart has other products as well" do
      let(:cart_products) { [other_product, other_product, product, product, other_product, product] }

      it "returns total products percentage" do
        expect(subject.calculate_discount(cart_products)).to be_within(0.01).of(product.price * 3 * discount_percentage)
      end
    end
  end
end
