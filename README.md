# Pizza-Sales-Analysis

# Overview

The Pizza Sales Analysis project is designed to provide insights into the sales performance of a fictional pizza chain. This project utilizes SQL to query and analyze a structured database containing information about orders, customers, products, and transactions. It highlights essential sales trends, customer preferences, and performance metrics to aid data-driven decision-making.

# Features

Query-based data extraction and manipulation

Analysis of sales trends and patterns

Identification of top-performing pizzas and categories

Customer behavior analysis

Insights into revenue and profitability

# Data Source and Structure

I got this dataset from Kaggle, the data contains the 4 table namely; 

•	order_details

•	orders

•	pizza_types

•	pizzas

**order_details** contains columns namely; order_details_id, order_id, pizza_id, and quantity.

**orders** contains columns namely; order_id, order_date, and order_time.

**pizza_types** contains columns namely; pizza_type_id, name, category, and ingredients.

**pizzas contains** columns namely; pizza_id, pizza_type_id, size, and price.

# Data Dictionary

The data dictionary provides detailed insights into the meaning and structure of the dataset. This pizza sales dataset consists of 12 key features:

•	order_id: Unique identifier for each order placed by a table

•	order_details_id: Unique identifier for each pizza placed within each order (pizzas of the same type and size are kept in the same row, and the quantity increases)

•	pizza_id: Unique key identifier that ties the pizza ordered to its details, like size and price

•	quantity: Quantity ordered for each pizza of the same type and size

•	order_date: Date the order was placed (entered into the system prior to cooking & serving)

•	order_time: Time the order was placed (entered into the system prior to cooking & serving)

•	price: Price of the pizza in USD

•	pizza_size: Size of the pizza (Small, Medium, Large, X Large, or XX Large)

•	pizza_category: Unique key identifier that ties the pizza ordered to its details, like size and price

•	pizza_ingredients: ingredients used in the pizza as shown in the menu (they all include Mozzarella Cheese, even if not specified; and they all include Tomato Sauce, unless another sauce is specified)

•	pizza_name: Name of the pizza as shown in the menu

# Findings

•	The dataset comprises a total of 21,350 unique orders, with an average order value of $ 38.31, contributing to a total revenue of $817,860.

•	The Total quantity of pizza sold as derived from this dataset is 49,574.

•	The day of the week with the most orders is Friday with 3538 total orders.

•	July stands out as the month with the highest number of orders, totaling 1935 and most orders are at the beginning of the year.

•	The best-selling pizza is The Classic Deluxe Pizza, with 2,453 orders, while The Brie Carrie Pizza ranks as the worst-selling pizza, with only 490 orders.

•	Classic and Supreme categories are the pizza categories with the contribution of 26.91% and 25.46% of total sales respectively.




