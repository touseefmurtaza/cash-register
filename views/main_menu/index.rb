require_relative "../products/index"
require_relative "../shoppings/new"

module MainMenu
  class Index

    OPTIONS_MAP = {
      "1" => Products::Index,
      "2" => Shoppings::New
    }.freeze


    def call
      render_options
      take_user_input
    end

    private

    def render_options
      puts "\n\n"
      puts "---------------------------------------"
      puts "Enter 1 to print products"
      puts "Enter 2 for shopping"
      puts "Enter 0 to exit"
    end

    def take_user_input
      print "Please enter your choice: "
      choice = gets.chomp

      if choice == "0"
        puts "Exiting the program. Goodbye!"
        return
      end

      if OPTIONS_MAP.keys.include? choice
        redirect_to_new_page(choice)
        return
      end


      puts "Invalid input. Please enter a valid option."
      take_user_input
    end

    def redirect_to_new_page(choice)
      OPTIONS_MAP[choice].new.call
    end
  end
end
