# Airbnb Database — Query Optimization Report

## Objective
Improve the performance of a complex query joining multiple tables (Bookings, Users, Properties, Payments) by:
- Identifying inefficiencies using `EXPLAIN ANALYZE`
- Applying indexing and query refactoring
- Comparing before/after execution plans

---

## 1 Original Query Analysis

### Query Summary
The initial query joined four major tables:
```sql
SELECT b.*, u.*, p.*, pay.*
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
ORDER BY b.start_date DESC;
