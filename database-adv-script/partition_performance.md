# Partitioning Performance Report

## Overview
The `bookings` table was identified as a performance bottleneck due to its large size.  
To optimize query execution, we implemented **table partitioning** by `start_date` using **RANGE partitioning by year**.

---

## Implementation Details
A new table `bookings_partitioned` was created:
```sql
PARTITION BY RANGE (YEAR(start_date)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION pmax  VALUES LESS THAN MAXVALUE
);
