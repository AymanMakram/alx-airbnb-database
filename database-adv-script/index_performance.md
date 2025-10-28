#  Airbnb Database & Index Optimization and Performance Analysis

## Objective
Improve SQL query performance by creating indexes on high-usage columns in the **Users**, **Bookings**, and **Properties** tables.  
Measure and compare query execution plans before and after indexing using `EXPLAIN` or `ANALYZE`.

---

## 1 Identifying High-Usage Columns

Based on query analysis and use in previous exercises (joins, filters, sorting), the following columns are frequently accessed:

| Table       | Column(s)                      | Usage Context | Recommended Index |
|--------------|-------------------------------|----------------|-------------------|
| `users`      | `email`, `user_id`            | WHERE, JOIN    | `idx_users_email` |
| `bookings`   | `user_id`, `property_id`, `status` | JOIN, WHERE, ORDER BY | `idx_bookings_user`, `idx_bookings_property`, `idx_bookings_status` |
| `properties` | `host_id`, `location`, `pricepernight` | JOIN, WHERE, ORDER BY | `idx_properties_host`, `idx_properties_location`, `idx_properties_price` |

---
