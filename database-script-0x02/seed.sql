-- Ensure database is selected
\c airbnb_db;

-- Enable UUID auto-generation support (required for PostgreSQL)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- =========================
-- Insert Users
-- =========================
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
(uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_pw1', '1234567890', 'guest'),
(uuid_generate_v4(), 'Bob', 'Smith', 'bob@example.com', 'hashed_pw2', '9876543210', 'host'),
(uuid_generate_v4(), 'Charlie', 'Brown', 'charlie@example.com', 'hashed_pw3', NULL, 'guest')
RETURNING user_id;

-- Save generated IDs for FK relationships
-- Copy returned UUIDs manually if needed
-- For simplicity, use static IDs for FKs below

-- =========================
-- Insert Properties
-- =========================
INSERT INTO properties (property_id, host_id, name, description, location, pricepernight)
VALUES
(uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', 'City Apartment', 'Nice apartment in the center of the city', 'New York, USA', 120.00),
(uuid_generate_v4(), '22222222-2222-2222-2222-222222222222', 'Cozy Cottage', 'Quiet cottage in the countryside', 'Kentucky, USA', 85.50);

-- =========================
-- Insert Bookings
-- =========================
INSERT INTO bookings (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
(uuid_generate_v4(), 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', '2025-11-01', '2025-11-05', 480.00, 'confirmed'),
(uuid_generate_v4(), 'bbbbbbb2-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '33333333-3333-3333-3333-333333333333', '2025-12-10', '2025-12-12', 171.00, 'pending');

-- =========================
-- Insert Payments
-- =========================
INSERT INTO payments (payment_id, booking_id, amount, payment_method)
VALUES
(uuid_generate_v4(), 'bbbb1111-b111-b111-b111-bbbbbbbbb111', 480.00, 'credit_card');

-- =========================
-- Insert Reviews
-- =========================
INSERT INTO reviews (review_id, property_id, user_id, rating, comment)
VALUES
(uuid_generate_v4(), 'aaaaaaa1-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 5, 'Amazing stay! Very clean and comfortable!');

-- =========================
-- Insert Messages
-- =========================
INSERT INTO messages (message_id, sender_id, recipient_id, message_body)
VALUES
(uuid_generate_v4(), '11111111-1111-1111-1111-111111111111', '22222222-2222-2222-2222-222222222222', 'Hello, is the apartment available for earlier dates?');
