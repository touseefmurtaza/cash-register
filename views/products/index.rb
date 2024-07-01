module Products
  class Index

    def call
      render
      redirect_to_main_menu
    end

    private

    def redirect_to_main_menu
      MainMenu::Index.new.call
    end

    def render
      puts "\n\n"
      puts "---------------------------------------"
      puts "| Product Code | Product Name | Price |"
      puts "| ------------ | ------------ | ----- |"

      Product.all.each do |product|
        puts "| #{product.code} | #{product.name} | #{product.price} |"
      end
    end
  end
end
