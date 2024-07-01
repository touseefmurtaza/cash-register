require_relative '../test_helper'

RSpec.describe ApplyDiscount do
  let(:cart_products) { [double(:product, code: 'P1'), double(:product, code: 'P2'), double(:product, code: 'P1'), double(:product, code: 'P1')] }
  let(:produce_code) { 'P1' }
  let(:discount_rule_1) { double(:discount_rule, product_code: 'P1', applies_to?: true, priority: 1, calculate_discount: 5.00) }
  let(:discount_rule_2) { double(:discount_rule, product_code: 'P1', applies_to?: true, priority: 2, calculate_discount: 3.00) }

  before do
    allow(DiscountRule).to receive(:where).with(product_code: produce_code).and_return([discount_rule_1, discount_rule_2])
  end

  describe "#call" do
    subject { described_class.new(cart_products, produce_code) }

    context "when there are no applicable discounts" do
      before do
        allow(discount_rule_1).to receive(:applies_to?).and_return(false)
        allow(discount_rule_2).to receive(:applies_to?).and_return(false)
      end

      it "returns 0.00" do
        expect(subject.call).to eq(0.00)
      end
    end

    context "when there are applicable discounts" do
      context "when best suited discount has higher priority" do
        it "returns the discount calculated by the best suited discount" do
          expect(subject.call).to eq(5.00)
        end
      end

      context "when another discount has lower priority" do
        let(:discount_rule_1) { double(:discount_rule, product_code: 'P1', applies_to?: true, priority: 2, calculate_discount: 5.00) }
        let(:discount_rule_2) { double(:discount_rule, product_code: 'P1', applies_to?: true, priority: 1, calculate_discount: 3.00) }

        it "returns the discount calculated by the best suited discount" do
          expect(subject.call).to eq(3.00)
        end
      end
    end
  end

  describe "#applicable_discounts" do
    subject { described_class.new(cart_products, produce_code) }

    it "returns the discounts that apply to the cart products" do
      expect(subject.send(:applicable_discounts)).to eq([discount_rule_1, discount_rule_2])
    end
  end

  describe "#best_suited_discount" do
    subject { described_class.new(cart_products, produce_code) }

    it "returns the discount with the highest priority" do
      expect(subject.send(:best_suited_discount)).to eq(discount_rule_1)
    end
  end
end
