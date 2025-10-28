# Advanced Join Queries & Airbnb Database

## Objective
Practice complex SQL joins in MySQL using the Airbnb database schema.

---

## Queries Included

### INNER JOIN
Retrieves all bookings and the users who made them.

### LEFT JOIN
Retrieves all properties and their reviews, including properties without reviews.

### FULL OUTER JOIN (MySQL simulation)
Combines LEFT and RIGHT JOIN using UNION to show:
- Users with no bookings
- Bookings not linked to any user
- All valid matching user & booking records

---

Run the queries using:
```sql
SOURCE joins_queries.sql;

---

## Subqueries

## Objective
Practice writing **non-correlated** and **correlated subqueries** in MySQL  
to extract insights from relational data in the Airbnb system.

# Aggregations and Window Functions

## Objective
Apply SQL **aggregation** and **window functions** to analyze booking and property performance data in the Airbnb system.
