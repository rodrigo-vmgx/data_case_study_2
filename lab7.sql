-- How many films are there for each of the categories in the category table. Use appropriate join to write this query.
USE sakila;
SELECT category.name, COUNT(film_category.film_id) AS num_films
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.name;

-- Display the total amount rung up by each staff member in August of 2005.
USE sakila;
SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS total_amount
FROM staff
INNER JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date BETWEEN '2005-08-01' AND '2005-08-31'
GROUP BY staff.staff_id;

-- Which actor has appeared in the most films?
USE sakila;
SELECT actor.actor_id, actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS num_films
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id
ORDER BY num_films DESC
LIMIT 1;

-- Most active customer (the customer that has rented the most number of films)
USE sakila;
SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.rental_id) AS num_rentals
FROM customer
INNER JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY num_rentals DESC
LIMIT 1;

-- Display the first and last names, as well as the address, of each staff member.
USE sakila;
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON staff.address_id = address.address_id;


-- List each film and the number of actors who are listed for that film.
USE sakila;
SELECT film.title, COUNT(film_actor.actor_id) AS num_actors
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id
ORDER BY num_actors DESC;


-- Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
USE sakila;
SELECT customer.last_name, customer.first_name, SUM(payment.amount) AS total_paid
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name ASC;


-- List number of films per category.
USE sakila;
SELECT category.name, COUNT(film_category.film_id) AS num_films
FROM category
INNER JOIN film_category ON category.category_id = film_category.category_id
GROUP BY category.category_id;


