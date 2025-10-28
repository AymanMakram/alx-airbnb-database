-- Use the correct database
USE airbnb;

-- ============================================================
-- 1 Non-Correlated Subquery
-- Find all properties where the average rating is greater than 4.0
-- ============================================================

SELECT 
    p.property_id,
    p.name AS property_name,
    p.location
FROM properties p
WHERE p.property_id IN (
    SELECT 
        r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.name ASC;

-- Explanation:
-- The subquery calculates the average rating per property.
-- The main query selects only properties whose average rating > 4.0.

-- ============================================================
-- 2 Correlated Subquery
-- Find users who have made more than 3 bookings.
-- ============================================================

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3
ORDER BY u.last_name ASC, u.first_name ASC;

-- Explanation:
-- This is a correlated subquery since the inner query depends
-- on each row from the outer query (users).
-- It counts bookings for each user and filters those with > 3.
