-- ============================================================
-- File: database_index.sql
-- Project: Airbnb Database — Index Optimization
-- Author: Ayman Makram
-- ============================================================

USE airbnb;

-- ============================================================
-- Users Table Indexes
-- ============================================================
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

-- ============================================================
-- Bookings Table Indexes
-- ============================================================
CREATE INDEX idx_bookings_user ON bookings(user_id);
CREATE INDEX idx_bookings_property ON bookings(property_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_date ON bookings(start_date, end_date);

-- ============================================================
-- Properties Table Indexes
-- ============================================================
CREATE INDEX idx_properties_host ON properties(host_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(pricepernight);

EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.email,
    p.name AS property_name,
    b.status,
    b.start_date
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE b.status = 'confirmed'
ORDER BY b.start_date DESC;

-- ============================================================
-- Explanation:
--  • EXPLAIN ANALYZE provides a detailed execution plan with timing.
--  • Run this query both before and after creating indexes to observe:
--      - Reduced query cost
--      - Faster execution time
--      - Change from "ALL" scan type to "ref" or "range"
-- ============================================================