# Normalization — Third Normal Form (3NF)

## Objective
Apply normalization principles so the Airbnb database schema is in Third Normal Form (3NF), removing redundancy and preventing update anomalies.

---

## 1. Schema Review & Findings

We reviewed the current schema (User, Property, Booking, Payment, Review, Message) looking for:
- Non-atomic attributes (1NF)
- Partial dependencies (2NF)
- Transitive dependencies (3NF)

**Findings**
- All tables use single-column UUID primary keys — no partial dependency issues detected.
- Potential transitive dependency risk: duplication of user or property attributes in child tables (Booking, Payment, Review, Message, Property) would violate 3NF. Confirmed final design references other entities by FK only.
- `location` is stored as a single field for simplicity; if address components or geo queries are required, extract an `Address` table later.

---

## 2. Business Rules & Design Decisions

- User data (name, email, phone, role) is stored **only** in `User`. Other tables reference users by `user_id`.
- Property owner is referenced by `host_id` in `Property` which is a FK to `User`.
- Booking stores `user_id` and `property_id` only; `total_price` is a stored snapshot allowed in 3NF (it depends on booking_id).
- Payments are linked to bookings via `booking_id`. Model supports multiple payments per booking (1:N).
- `Review` and `Message` store only FK references to avoid redundancy.
- `role` remains an ENUM in `User` per specification.

---

## 3. Applied Fixes to Achieve 3NF

- Removed any duplicated user/property fields from child tables (if they existed).
- Ensured `Booking` does not store `user_name`, `user_email`, `property_name`, or other derived attributes.
- Ensured `Payment` contains `booking_id`, `amount`, `payment_date`, `payment_method` only.
- Added CHECK constraints and foreign key constraints:
  - `Review.rating` CHECK (rating BETWEEN 1 AND 5)
  - `Booking` CHECK (start_date < end_date)
  - `User.email` UNIQUE
  - FK constraints for all references to enforce referential integrity.

---

## 4. Final 3NF Schema (tables & attributes)

### User
- `user_id` (PK, UUID)  
- `first_name`  
- `last_name`  
- `email` (UNIQUE)  
- `password_hash`  
- `phone_number`  
- `role` (ENUM: guest, host, admin)  
- `created_at` (TIMESTAMP)

### Property
- `property_id` (PK, UUID)  
- `host_id` (FK → User.user_id)  
- `name`  
- `description`  
- `location`  
- `price_per_night`  
- `created_at`  
- `updated_at`

### Booking
- `booking_id` (PK, UUID)  
- `property_id` (FK → Property.property_id)  
- `user_id` (FK → User.user_id)  
- `start_date`  
- `end_date`  
- `total_price`  
- `status` (ENUM: pending, confirmed, canceled)  
- `created_at`

### Payment
- `payment_id` (PK, UUID)  
- `booking_id` (FK → Booking.booking_id)  
- `amount`  
- `payment_date`  
- `payment_method` (ENUM)

### Review
- `review_id` (PK, UUID)  
- `property_id` (FK → Property.property_id)  
- `user_id` (FK → User.user_id)  
- `rating` (INT, 1–5)  
- `comment`  
- `created_at`

### Message
- `message_id` (PK, UUID)  
- `sender_id` (FK → User.user_id)  
- `recipient_id` (FK → User.user_id)  
- `message_body`  
- `sent_at`

---

## 5. Validation Steps (what to test)

1. Confirm no duplicate user/property columns exist in child tables.
2. Attempt to insert invalid FK values and ensure the DB rejects them.
3. Test `Review.rating` constraint by trying invalid ratings.
4. Test `Booking` date constraint by trying `start_date >= end_date`.
5. Test UNIQUE `User.email`.
6. Test creation of multiple payments for a single booking (1:N) if supported.

---
## 6. Conclusion

The schema now meets 1NF, 2NF, and 3NF:
- Atomic attributes, single-column primary keys, and no transitive dependencies.
- Data redundancy removed and referential integrity enforced.
