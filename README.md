# Cash Register System

This Ruby CLI application is designed to manage a cash register system, handling product management, discounts, and cart calculations. Below are the components and functionalities included in the system:


### Components

1. **Models (`app/models/`)**:

   - **apply_discount.rb**: Applies discounts based on rules. It interacts with `DiscountRule` and various discount strategies (`BogoDiscount`, `PercentageDiscount`, `ReducedPriceDiscount`) to calculate and apply discounts to cart items. This class can be extended by adding new discount types or enhancing existing logic for more complex discount scenarios.

   - **bogo_discount.rb**: Implements "Buy One Get One" discount strategy. This class checks the cart for eligible products and calculates discounts based on specified conditions (`buy_quantity` and `free_quantity`). To extend, additional conditions or variations of BOGO deals could be implemented.

   - **percentage_discount.rb**: Implements percentage-based discount strategy. It calculates discounts based on a percentage of the product price when minimum quantity conditions are met. To extend, support for different discount calculation methods or additional conditions could be added.

   - **reduced_price_discount.rb**: Implements reduced price discount strategy. This class applies a fixed price reduction to products when specific minimum quantity conditions are met. To extend, additional features like dynamic pricing rules or product-specific discounts could be introduced.

   - **discount_rule.rb**: Loads discount rules from `discount_rules.yml` and maps them to corresponding discount strategy classes (`BogoDiscount`, `PercentageDiscount`, `ReducedPriceDiscount`). To extend, support for new discount types or dynamic rule loading could be implemented.

   - **discount_strategy.rb**: Base class for discount strategies (`BogoDiscount`, `PercentageDiscount`, `ReducedPriceDiscount`). It defines common methods and attributes shared by all discount types. To extend, new discount strategies can inherit from this class to implement different types of promotions or incentives.

   - **priority.rb**: Manages priority levels for roles defined in `priority_list.yml`. It provides a way to assign and retrieve priority levels for different roles within the system. To extend, additional features such as role-based access controls or priority-based processing could be incorporated.

   - **product.rb**: Loads product details from `products.yml` including code, name, and price. It provides methods to find products by code and retrieve their details. To extend, features like inventory management, product variants, or pricing rules could be added.

2. **Services (`app/services/`)**:

   - **main_menu/index.rb**: Displays main menu options for product listing and shopping. It interacts with `Products::Index` and `Shoppings::New` to facilitate user navigation and interaction. To extend, additional menu options or user interface enhancements could be implemented.

   - **shoppings/new.rb**: Allows adding products to a cart (`Cart`) and calculating totals. It interacts with `Product` to find products by code and updates the cart accordingly. To extend, features like order processing, payment integration, or promotional code handling could be added.

3. **Views (`app/views/`)**:

   - **main_menu/index.rb**: Displays main menu to interact with CLI.
   - **products/index.rb**: Displays product details fetched from `products.yml`. It interacts with `Product` to fetch and render product information for users. To extend, product sorting, filtering, or pagination features could be implemented for better user experience.
   - **shopping/new.rb**: Displays to get products to be scanned and add to the card.

### Usage

To run the application:

1. Start the application using Docker:

```
docker-compose run --rm cash_register
```

2. Access the main menu to interact with product listing, shopping, and discounts.

### Testing

To run tests (assuming RSpec is configured):

```
docker-compose run --rm cash_register_tests
```
