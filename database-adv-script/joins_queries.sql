-- =========================================
-- Airbnb Complex Join Queries
-- =========================================

CREATE DATABASE IF NOT EXISTS airbnb;
USE airbnb;
-- 1 INNER JOIN: Retrieve all bookings and the respective users
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings b
INNER JOIN users u
    ON b.user_id = u.user_id;

-- 2 LEFT JOIN: Retrieve all properties and their reviews (include those with no reviews)
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM properties p
LEFT JOIN reviews r
    ON p.property_id = r.property_id;

-- 3 FULL OUTER JOIN simulation: All users and all bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM users u
LEFT JOIN bookings b
    ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM users u
RIGHT JOIN bookings b
    ON u.user_id = b.user_id;
