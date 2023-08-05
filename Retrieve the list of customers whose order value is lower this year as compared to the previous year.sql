SELECT
    customer_id
FROM
    (
        SELECT
            customer_id,
            strftime('%Y', order_date) AS year,
            SUM(price * quantity) AS total_order_amount
        FROM
            Orders
        JOIN
            OrderItems ON Orders.order_id = OrderItems.order_id
        GROUP BY
            customer_id,
            strftime('%Y', order_date)
    ) AS order_summary
GROUP BY
    customer_id
HAVING
    MAX(CASE WHEN year = strftime('%Y', DATE('now', 'start of year')) THEN total_order_amount END) <
    MAX(CASE WHEN year = strftime('%Y', DATE('now', 'start of year', '-1 year')) THEN total_order_amount END);
