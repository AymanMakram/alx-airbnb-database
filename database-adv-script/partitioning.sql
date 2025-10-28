-- ============================================
-- Airbnb Database Optimization: Table Partitioning
-- ============================================

USE airbnb;

-- Drop existing partitioned table if it exists (for testing)
DROP TABLE IF EXISTS bookings_partitioned;

-- ==================================================
-- Step 1: Create a partitioned version of the bookings table
-- ==================================================

CREATE TABLE bookings_partitioned (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_start_date (start_date),
    FOREIGN KEY (property_id) REFERENCES properties(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
)
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);

-- ==================================================
-- Step 2: Insert sample data for testing
-- ==================================================
INSERT INTO bookings_partitioned (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(UUID(), 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '2023-05-10', '2023-05-12', 150.00, 'confirmed'),
(UUID(), 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '22222222-2222-2222-2222-222222222222', '2024-07-01', '2024-07-03', 300.00, 'confirmed'),
(UUID(), 'ccccccc3-cccc-cccc-cccc-cccccccccccc', '33333333-3333-3333-3333-333333333333', '2025-01-20', '2025-01-22', 220.00, 'pending');

-- ==================================================
-- Step 3: Analyze query performance before partitioning
-- (Compare to original `bookings` table)
-- ==================================================
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- ==================================================
-- Step 4: Analyze query performance after partitioning
-- ==================================================
EXPLAIN ANALYZE
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31';

-- The query should now scan only the partition (p2024) instead of the entire table.
