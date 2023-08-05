SELECT
    P.product_id,
    P.name AS product_name,
    V.variant_id,
    V.attribute1,
    V.attribute2,
    SUM(O.quantity) AS total_units_sold
FROM
    Product P
JOIN
    Variant V ON P.product_id = V.product_id
JOIN
    OrderItems O ON V.variant_id = O.variant_id
GROUP BY
    P.product_id,
    V.variant_id
ORDER BY
    total_units_sold DESC
LIMIT 5;
