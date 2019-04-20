use sakila;
-- 1A 
select first_name, last_name from actor;
-- 1B
select concat(actor.first_name, " ", actor.last_name) as "Actor Name"
from actor;
-- 2A
select actor_id, first_name, last_name from actor
Where first_name = "JOE";
-- 2B 
select first_name, last_name from actor
Where last_name like "%GEN%";
-- 2C
select first_name, last_name from actor
Where last_name like "%LI%"
Order by last_name, first_name;
-- 2D
select country_id, country from country
where country IN ('Afghanistan', 'Bangladesh', 'China');
-- 3A
alter table actor
add column desription BLOB;
-- 3B
alter table actor 
drop column desription;
-- 4A
select actor.last_name, count(actor.last_name) as "Total"
from actor
Group By last_name;
-- 4B
select actor.last_name, count(actor.last_name) as "Total"
from actor
Group By last_name
having count(actor.last_name) >=2 ;
-- 4C
update actor
set actor.first_name = "HARPO"
where actor.last_name = "Williams" and actor.first_name = "Groucho";
-- 4D
update actor
set actor.first_name = "Groucho"
where actor.first_name = "HARPO";
-- 5A
show create table address;
-- 6A
select staff.first_name, staff.last_name, address.address
from staff
Join address on address.address_id = staff.address_id;
-- 6B
select staff.first_name, staff.last_name, sum(payment.amount) as "Total Payments In August 2005"
from staff
Join payment on payment.staff_id = staff.staff_id
where payment.payment_date between '2005-7-31' and '2005-9-1'
group by staff.last_name;
-- 6C
select film.title, count(film_actor.actor_id) as "Number of Actors"
from film
Join film_actor on film_actor.film_id = film.film_id
group by film.title;
-- 6D
select film.title, count(inventory.film_id) as "Total Copies" 
from film
join inventory on inventory.film_id = film.film_id
where film.title = "Hunchback Impossible";
-- 6E
select customer.first_name, customer.last_name, sum(payment.amount) as "Total Paid" 
from customer
join payment on payment.customer_id = customer.customer_id
group by customer.last_name
order by customer.last_name ASC;
-- 7A
select title from film
where title like "k%" or "q%";
-- 7B 
select actor.first_name, actor.last_name
from actor
join film_actor on film_actor.actor_id = actor.actor_id
where film_actor.film_id in (select film.film_id from film where film.title = "Alone Trip");
-- 7C
select customer.first_name, customer.last_name, customer.email
from customer
join address on address.address_id = customer.address_id
join city on city.city_id = address.city_id
where city.country_id IN (select country.country_id from country where country = "Canada")
Group By customer.last_name;
-- 7D
select film.title
from film
join film_category on film_category.film_id = film.film_id
join category on category.category_id = film_category.category_id
where category.name like "%family%";
-- 7E
select film.title, count(rental.rental_id)
from film
join inventory on inventory.film_id = film.film_id
join rental on rental.inventory_id = inventory.inventory_id
Group by film.title
Order by count(rental.rental_id) desc;
-- 7F
select store.store_id, format(sum(payment.amount), "Money") as "Total Business" 
from store
join staff on staff.store_id = store.store_id
join payment on payment.staff_id = staff.staff_id
Group by store.store_id;
-- 7G
Select store.store_id, city.city, country.country
from store
join address on address.address_id = store.address_id
join city on city.city_id = address.city_id
join country on country.country_id = city.country_id
group by store.store_id;
-- 7H
select category.name, format(sum(payment.amount), 'Currency') as "Gross"
from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by category.name
order by sum(payment.amount) desc;
-- 8A
Create view top_five_genres
AS select category.name, format(sum(payment.amount), 'Currency') as "Gross"
from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by category.name
order by sum(payment.amount) desc
limit 5;
-- 8B
select * from top_five_genres;
-- 8C
drop view top_five_genres;

