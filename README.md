Data Digger – E-Commerce Store
About
Data Digger is a beginner-friendly MySQL project for practising database tables and SQL queries for an online store.
Tables
- Customers: customer name, email and address.
- Orders: customer, order date and total amount.
- Products: product name, price and available stock.
- OrderDetails: products and quantities included in each order.
SQL topics used
- CREATE TABLE and INSERT
- SELECT, UPDATE and DELETE
- Primary keys and foreign keys
- WHERE, BETWEEN and ORDER BY
- MAX, MIN, AVG, SUM and COUNT
- JOIN, GROUP BY and LIMIT
- Date filtering with CURDATE() and INTERVAL
How to run
1. Open MySQL Workbench or another MySQL client.
2. Open data_digger.sql.
3. Run the script from top to bottom.
The script creates the DataDigger database and recreates its tables each time it runs, so existing tables with these names are dropped first.
Assumptions
- All sample data is fictional.
- OrderDetails.SubTotal stores the total price for that product line.
- “Top 3 most ordered products” means products with the highest total quantity ordered.
- “Times sold” counts the number of order-detail records containing the selected product, not the total quantity.
- The last-30-days query uses the current date, so the results change over time.
- Customer 5 and order 105 are not referenced by other tables when deleted. Product 205 has zero stock and is not referenced by order details, so it can be deleted without breaking foreign keys.
Files
- data_digger.sql – table creation, sample records and required queries.
- README.md – project details and assumptions.
