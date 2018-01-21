USE sakila;

#1a Display the first and last names of all actors from the table actor. 
SELECT first_name, last_name FROM actor;

#1b Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name
SELECT upper(concat(first_name, ' ', last_name)) AS ActorName FROM actor;

#2a You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe
SELECT actor_id, first_name, last_name FROM actor 
WHERE first_name = 'Joe';

#2b  Find all actors whose last name contain the letters GEN:
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%GEN%';

#2c Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name
SELECT first_name, last_name FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

#2d Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China
SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a Add a middle_name column to the table actor. Position it between first_name and last_name.
ALTER TABLE actor
ADD middle_name varchar(255) AFTER first_name;

#3b You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs
ALTER TABLE actor MODIFY COLUMN middle_name blob;

#3c Now delete the middle_name column
ALTER TABLE actor
DROP middle_name;

# 4a List the last names of actors, as well as how many actors have that last name
SELECT last_name, count(last_name) As actor_count FROM actor
GROUP BY last_name;

#4b List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
SELECT last_name, count(last_name) As actor_count FROM actor
GROUP BY last_name
HAVING actor_count >= 2;

#4c Write a query to fix the record Harpo Williams
UPDATE actor set first_name = 'HARPO'
WHERE first_name = 'GROUCHO' and last_name = 'WILLIAMS';

#4d It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. 
UPDATE actor set first_name = 'GROUCHO'
WHERE first_name = 'HARPO' and last_name = 'WILLIAMS';

#5a You cannot locate the schema of the address table. Which query would you use to re-create it?
 ##Do not run##
CREATE TABLE address(
address_id SMALLINT(5),
address varchar(50),
address2 varchar(50),
district varchar(20),
city_id SMALLINT(5),
postal_code varchar(10),
phone varchar(20),
location geometry,
last_update timestamp,
PRIMARY KEY (address_id)
);


#6a Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address
SELECT staff.first_name, staff.last_name, address.address
FROM staff
LEFT OUTER JOIN address ON address.address_id = staff.address_id;

#6b Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment
SELECT staff.staff_id, staff.first_name, staff.last_name, extract(year_month from payment.payment_date) As date, sum(payment.amount) AS total_amount
FROM staff
LEFT OUTER JOIN payment ON payment.staff_id = staff.staff_id
GROUP BY date, staff.staff_id
HAVING date ='200508';

#6c List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join
SELECT film.title, film.film_id,COUNT(film_actor.actor_id) As actor_count FROM film
JOIN film_actor
ON film_actor.film_id = film.film_id
GROUP BY film.film_id;

#6d How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title, film.film_id, count(inventory.inventory_id) as copies FROM film
JOIN inventory
ON film.film_id = inventory.film_id
GROUP BY film.title
HAVING film.title = 'Hunchback Impossible';

# 6e Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer.first_name, customer.last_name, customer.customer_id, sum(payment.amount) AS total_payment FROM customer
lEFT OUTER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;

#7a Use subqueries to display the titles of movies starting with the letters K and Q whose language is English. 
SELECT title FROM film
WHERE title LIKE 'K%' or title LIKE 'Q%'and language_id in
(SELECT language_id FROM language
WHERE name = 'English');

#7b Use subqueries to display all actors who appear in the film Alone Trip
SELECT first_name, last_name FROM actor
WHERE actor_id IN
(
 SELECT actor_id FROM film_actor
 WHERE film_id =
 (
  SELECT film_id FROM film
  WHERE title = 'Alone Trip'
 )
);

#7c You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.
SELECT customer.first_name, customer.last_name, customer.email, country.country FROM customer
LEFT OUTER JOIN address
ON customer.address_id = address.address_id
LEFT OUTER JOIN city
ON address.city_id = city.city_id
lEFT OUTER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Canada'; 

#7d Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
SELECT  category.name, film_text.title FROM film_category
JOIN film_text
ON film_text.film_id = film_category.film_id
JOIN category
ON category.category_id = film_category.category_id
WHERE name = 'Family'; 

#7e Display the most frequently rented movies in descending order.
SELECT film.title, count(film.film_id) AS rent_count FROM inventory
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON film.film_id = inventory.inventory_id
GROUP BY film.film_id
ORDER BY rent_count DESC;

#7f Write a query to display how much business, in dollars, each store brought in.
select city, country, sum(p.amount) as 'total_sales'
from payment p
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join store s on i.store_id = s.store_id
join address a on s.address_id = a.address_id
join city c on a.city_id = c.city_id
join country y on c.country_id = y.country_id
join staff f on s.manager_staff_id = f.staff_id
group by s.store_id
order by y.country, c.city;


#7g Write a query to display for each store its store ID, city, and country.
select store_id, city, country
from store s, address a , city c, country y
where s.address_id = a.address_id
and a.city_id = c.city_id
and c.country_id = y.country_id;

#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
create view v_top_5_genre as 
select name, sum(p.amount) as 'revenue'
from payment p
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by name
order by revenue
limit 5;

#8b. How would you display the view that you created in 8a?
select * from v_top_5_genre;

#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
drop view v_top_5_genre;
