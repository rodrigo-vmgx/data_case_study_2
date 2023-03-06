USE sakila;
ALTER TABLE staff
DROP COLUMN picture;

INSERT INTO customer (store_id,address_id,first_name, last_name)
VALUES ('1','606', 'Tammy', 'Sanders');

SELECT customer_id FROM sakila.customer
WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER';

SELECT i.inventory_id, i.film_id FROM sakila.inventory i
JOIN sakila.film f ON i.film_id = f.film_id
WHERE f.title = 'Academy Dinosaur' AND i.store_id = 1 AND i.store_id = 'Available'
LIMIT 1;

SELECT staff_id FROM sakila.staff
WHERE first_name = 'MIKE' AND last_name = 'HILLYER';

INSERT INTO sakila.rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (CURRENT_TIMESTAMP, 1, 333, 1);




