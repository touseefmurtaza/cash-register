require_relative '../test_helper'

RSpec.describe BogoDiscount do
  let(:cart_products_quantity) { 2 }
  let(:discount_product_code) { "GR1" }
  let(:other_product_code) { "SR1" }
  let(:product) { Product.find(code: discount_product_code) }
  let(:other_product) { Product.find(code: other_product_code) }
  let(:cart_products) do
    1.upto(cart_products_quantity).map { product }
  end
  let(:buy_quantity) { 1 }
  let(:free_quantity) { 1 }

  subject do
    BogoDiscount.new(
      {
        "buy_quantity" => buy_quantity, "free_quantity" => free_quantity,
        "product_code" => discount_product_code, "applier" => "CEO"
      }
    )
  end

  describe "#applies_to" do
    context "when buy quantity 1 and free quantity is also 1" do
      context "when cart has 2 products" do
        it "returns true" do
          expect(subject.applies_to?(cart_products)).to be true
        end
      end
    end

    context "when cart products are empty" do
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

    context "when buy_quantity is 3" do
      let(:buy_quantity) { 3 }

      context "when discounted_products quantity is 2" do
        let(:cart_products) { [product, other_product, product, other_product] }

        it "returns false" do
          expect(subject.applies_to?(cart_products)).to be false
        end
      end

      context "when discounted_products quantity is 4" do
        let(:cart_products) { [product, other_product, product, other_product, product, product] }
        it "returns true" do
          expect(subject.applies_to?(cart_products)).to be true
        end
      end
    end
  end

  describe "#calculate_discount" do
    context "when buy quantity 1 and free quantity is also 1" do
      context "when cart has 2 products" do
        it "returns price of 1 product" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price)
        end
      end

      context "when cart has 2 of discount products and other products" do
        let(:cart_products) do
          [product, other_product, product, other_product, other_product]
        end

        it "returns price of 1 product" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price)
        end
      end

      context "when cart has 1 products" do
        let(:cart_products_quantity) { 1 }

        it "returns 0" do
          expect(subject.calculate_discount(cart_products)).to eq(0.00)
        end
      end

      context "when cart has 3 products" do
        let(:cart_products_quantity) { 3 }

        it "returns 1 product price" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price)
        end
      end

      context "when cart has 4 discount products" do
        let(:cart_products_quantity) { 4 }

        it "returns price of 2 products" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price * 2)
        end
      end
    end

    context "when buy quantity is 2 and free quanitity is 1" do
      let(:buy_quantity) { 2 }
      let(:free_quantity) { 1 }

      context "when cart has 2 products" do
        it "returns discount as 0.00" do
          expect(subject.calculate_discount(cart_products)).to eq(0.00)
        end
      end

      3.upto(5).each do |cart_quantity|
        context "when cart has #{cart_quantity} products" do
          let(:cart_products_quantity) { cart_quantity }
          it "returns price of 1 product as discount" do
            expect(subject.calculate_discount(cart_products)).to eq(product.price)
          end
        end
      end

      context "when cart has 6 products" do
        let(:cart_products_quantity) { 6 }

        it "returns price of 2 products as discount" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price * 2)
        end
      end
    end

    context "when buy quantity is 2 and free quantity is 2" do
      let(:buy_quantity) { 2 }
      let(:free_quantity) { 2 }

      context "when cart has 2 products" do
        let(:cart_products_quantity) { 2 }

        it "returns discount as 0.00" do
          expect(subject.calculate_discount(cart_products)).to eq(0.00)
        end
      end

      context "when cart has 3 products" do
        let(:cart_products_quantity) { 3 }

        it "returns product price as free price" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price)
        end
      end

      context "when cart has 4 products" do
        let(:cart_products_quantity) { 4 }

        it "returns price of 2 products as discount" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price * 2)
        end
      end

      context "when cart has 8 products" do
        let(:cart_products_quantity) { 8 }

        it "returns price of 4 products as discount" do
          expect(subject.calculate_discount(cart_products)).to eq(product.price * 4)
        end
      end
    end
  end
end
