USE Sakila;

SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

-- How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT SUM(inventory_id) AS total_copies
FROM inventory
WHERE film_id = (
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
);

-- List all films whose length is longer than the average of all the films.
SELECT title, length
FROM film
WHERE length > (
    SELECT AVG(length)
    FROM film
);

-- Use subqueries to display all actors who appear in the film Alone Trip

SELECT actor.first_name, actor.last_name
FROM actor
JOIN (
    SELECT film_id
    FROM film
    WHERE title = 'Alone Trip'
) AS film_info ON actor.actor_id IN (
    SELECT actor_id
    FROM film_actor
    WHERE film_actor.film_id = film_info.film_id
);

-- Sales have been lagging among young families, and you wish to target all 
-- family movies for a promotion. Identify all movies categorized as family films.

SELECT film.title
FROM film
JOIN (
    SELECT category_id
    FROM category
    WHERE name = 'Family'
) AS family_category ON film.film_id IN (
    SELECT film_id
    FROM film_category
    WHERE film_category.category_id = family_category.category_id
);

-- Get name and email from customers from Canada using subqueries. 
-- Do the same with joins. Note that to create a join, you will have to 
-- identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.

-- using subqueries

SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
    SELECT address_id
    FROM address
    WHERE city_id IN (
        SELECT city_id
        FROM city
        WHERE country_id IN (
            SELECT country_id
            FROM country
            WHERE country = 'Canada'
        )
    )
);


-- using joins

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE country.country = 'Canada';

-- Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

SELECT film.title
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
WHERE film_actor.actor_id = (
  SELECT actor_id
  FROM (
    SELECT actor_id, COUNT(*) AS film_count
    FROM film_actor
    GROUP BY actor_id
    ORDER BY film_count DESC
    LIMIT 1
  ) AS actor_counts
);

-- Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

SELECT film.title
FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN customer ON rental.customer_id = customer.customer_id
WHERE customer.customer_id = (
  SELECT payment.customer_id
  FROM payment
  GROUP BY payment.customer_id
  ORDER BY SUM(payment.amount) DESC
  LIMIT 1
);

-- Customers who spent more than the average payments

SELECT customer.first_name, customer.last_name, SUM(payment.amount) as total_payments
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
WHERE payment.amount > (
  SELECT AVG(amount)
  FROM payment
)
GROUP BY customer.customer_id;





