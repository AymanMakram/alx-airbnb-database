-- Use the correct database
USE airbnb;

-- ============================================================
-- 1 Aggregation Query
-- Find the total number of bookings made by each user
-- ============================================================

SELECT 
    u.user_id,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, user_name
ORDER BY total_bookings DESC, user_name ASC;

-- Explanation:
-- COUNT(b.booking_id) counts how many bookings each user has made.
-- LEFT JOIN ensures users with 0 bookings still appear.
-- GROUP BY aggregates results per user.

-- ============================================================
-- 2 Window Function Query
-- Rank properties based on the total number of bookings they have received
-- ============================================================

SELECT
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_row_number
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY total_bookings DESC, property_name ASC;

-- Explanation:
-- COUNT() aggregates bookings per property.
-- RANK() assigns ranking with ties (same count = same rank).
-- ROW_NUMBER() assigns a unique number per row.
-- Window functions operate *after* aggregation, providing analytical insight.
