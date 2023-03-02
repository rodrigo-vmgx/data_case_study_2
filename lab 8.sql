-- Write a query to display for each store its store ID, city, and country.
USE sakila;
SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);

-- Write a query to display how much business, in dollars, each store brought in.
SELECT s.store_id, SUM(p.amount) 
FROM payment p
JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY store_id;

-- Which film categories are longest?
select category.name, avg(length)
from film join film_category using (film_id) join category using (category_id)
group by category.name
having avg(length) > (select avg(length) from film)
order by avg(length) desc;


-- Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(f.title) as rentals from film f 
JOIN 
	(SELECT r.rental_id, i.film_id FROM rental r 
    JOIN 
    inventory i ON i.inventory_id = r.inventory_id) a
    ON a.film_id = f.film_id GROUP BY f.title ORDER BY rentals DESC;

-- List the top five genres in gross revenue in descending order.
SELECT cat.name as category, SUM(d.revenue) as revenue from category cat 
JOIN
    (SELECT catf.category_id, c.revenue FROM film_category catf 
	JOIN 
		(SELECT i.film_id, b.revenue FROM inventory i 
		JOIN 
			(SELECT r.inventory_id, a.revenue from rental r 
			JOIN 
				(SELECT p.rental_id, p.amount as revenue FROM payment p) a 
				ON a.rental_id = r.rental_id) b
			ON b.inventory_id = i.inventory_id) c
		ON c.film_id = catf.film_id) d 
	ON d.category_id = cat.category_id GROUP BY cat.name
  ORDER BY revenue DESC
  LIMIT 5;
  
  
-- Is "Academy Dinosaur" available for rent from Store 1?
select film.film_id, film.title, store.store_id, inventory.inventory_id
from inventory join store using (store_id) join film using (film_id)
where film.title = 'Academy Dinosaur' and store.store_id = 1;

select inventory.inventory_id
from inventory join store using (store_id)
     join film using (film_id)
     join rental using (inventory_id)
where film.title = 'Academy Dinosaur'
      and store.store_id = 1
      and not exists (select * from rental
                      where rental.inventory_id = inventory.inventory_id
                      and rental.return_date is null);

-- Get all pairs of actors that worked together.

-- Get all pairs of customers that have rented the same film more than 3 times.
-- For each film, list actor that has acted in more films.



