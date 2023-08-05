SELECT 
    customer_id,
    AVG(total_order_amount) AS average_order_amount
FROM Customer
    (
        SELECT
            customer_id,
            order_id,
            SUM(price * quantity) AS total_order_amount,
            MAX(order_date) AS latest_order_date
        FROM
            Orders
        JOIN
            OrderItems ON Orders.order_id = OrderItems.order_id
        WHERE
            order_date >= DATE('now', '-6 months')
        GROUP BY
            customer_id,
            order_id
    ) AS order_summary
GROUP BY
    customer_id
ORDER BY
    average_order_amount DESC
LIMIT 5;

