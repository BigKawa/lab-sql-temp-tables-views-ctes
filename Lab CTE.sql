USE sakila;

# Create a VIEW

CREATE VIEW rental_summary AS 
SELECT customer_id,first_name, last_name, email, COUNT(rental_id) AS total_rentals
FROM customer
INNER JOIN rental
USING (customer_id)
GROUP BY customer_id;

SELECT * FROM test;
# CREATE CTE
with payment_summary as (
SELECT customer_id, SUM(payment.amount) AS total_paid
FROM rental_summary
INNER JOIN payment
USING (customer_id)
GROUP BY customer_id)

SELECT * FROM test2;


-- Step 3: Create a CTE to join the rental summary view with the payment summary CTE
with customer_summary AS (
    SELECT 
        rs.customer_id,
        rs.first_name,
        rs.last_name,
        rs.email,
        rs.rental_count,
        ps.total_paid,
        (ps.tota∑l_paid / rs.rental_count) AS average_payment_per_rental
    FROM rental_summary rs
    INNER JOIN payment_summary ps ON rs.customer_id = ps.customer_id
)

-- Step 4: Generate the final customer summary report
SELECT 
    first_name,
    last_name,
    email,
    rental_count,
    total_paid,
    average_payment_per_rental
FROM customer_summary;