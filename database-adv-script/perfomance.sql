USE airbnb;

-- ============================================================
-- 1 Initial Complex Query (Unoptimized)
-- ============================================================
-- Retrieves all bookings with user details, property details, and payment details

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.payment_method
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC;

-- Notes:
-- • This query joins 4 tables.
-- • It may perform full table scans if indexes are missing on join/filter columns.
-- • Use EXPLAIN ANALYZE to view cost, join type, and rows examined.

-- ============================================================
-- 2 Refactored Optimized Query
-- ============================================================

-- Optimization techniques applied:
--  • Use SELECT with only needed columns.
--  • Ensure indexes on foreign keys: user_id, property_id, booking_id.
--  • Avoid sorting large intermediate results.
--  • Replace LEFT JOIN if payments always exist.

EXPLAIN ANALYZE
SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    p.name AS property_name,
    pay.amount AS payment_amount,
    pay.payment_method
FROM bookings b
INNER JOIN users u USING (user_id)
INNER JOIN properties p USING (property_id)
LEFT JOIN payments pay USING (booking_id)
WHERE b.status IN ('confirmed', 'pending')
ORDER BY b.start_date DESC
LIMIT 100;

-- Notes:
-- • Uses USING() syntax for cleaner joins.
-- • Adds WHERE filter to reduce scanned rows.
-- • Adds LIMIT to prevent unnecessary full table sorting.
-- • Uses pre-created indexes to improve join speed:
--      - idx_bookings_user
--      - idx_bookings_property
--      - idx_bookings_status
-- ============================================================
