# Database Performance Monitoring and Optimization Report

## Overview
To ensure consistent and efficient database performance, we continuously monitored and analyzed query execution using **EXPLAIN ANALYZE** and **SHOW PROFILE**.  
Our goal was to identify slow queries, analyze their execution plans, and make informed schema or index optimizations.

---

## 1 Tools Used

### EXPLAIN / EXPLAIN ANALYZE
Used to visualize query execution plans, identify table scans, and detect inefficient joins or missing indexes.

```sql
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.start_date, b.total_price
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-12-31';
