module Shoppings
  class New
    def initialize
      @cart = Cart.new
    end

    def call
      render
      take_user_input
    end

    def render
      puts "\n\n"
      puts "---------------------------------------"
      puts "Enter Product code to add new product"
      puts "Enter 0 any time to go back to main menu"
    end

    private

    def take_user_input
      loop do
        print "Please enter product code to add to cart or 0 to go back to main menu: "
        choice = gets.chomp

        if choice == "0"
          MainMenu::Index.new.call
          break;
        end

        product = Product.find(code: choice)
        if product
          add_product_cart_and_print_total(product)
        else
          show_invalid_input_error
        end
      end
    end

    def add_product_cart_and_print_total(product)
      @cart.add_product product
      puts "Cart products: #{@cart.scanned_products.map(&:code).join(", ")}"
      puts "Total: #{@cart.total_price}"
    end

    def show_invalid_input_error
      puts "Could not find the product with the given code, please try again"
    end
  end
end
