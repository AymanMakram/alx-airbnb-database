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
