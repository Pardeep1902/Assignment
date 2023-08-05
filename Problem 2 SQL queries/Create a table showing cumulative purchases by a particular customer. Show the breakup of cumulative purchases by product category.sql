CREATE VIEW CumulativePurchase AS
SELECT
    O.customer_id,
    C.name AS customer_name,
    O.order_date,
    O.product_id,
    P.name AS product_name,
    SUM(O.price * O.quantity) OVER (PARTITION BY O.customer_id ORDER BY O.order_date) AS cumulative_purchase_amount
FROM
    Orders O
JOIN
    OrderItems ON O.order_id = OrderItems.order_id
JOIN
    Product P ON O.product_id = P.product_id
JOIN
    Customer C ON O.customer_id = C.customer_id;

	