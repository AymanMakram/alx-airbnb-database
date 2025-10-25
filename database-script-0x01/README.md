# Database Schema - Airbnb

##  Objective
This task creates the database schema for the Airbnb system using SQL DDL.

##  Files
- `schema.sql` → Contains all CREATE TABLE statements, constraints & indexes.

##  Database Features
  - Entities: Users, Properties, Bookings, Payments, Reviews, Messages  
  - UUID primary keys  
  - Foreign key relationships with cascading rules  
  - ENUM validation using CHECK constraints  
  - Following 3rd Normal Form (3NF)  
  - Indexes for optimized queries on email, FK columns

##  How to run the script
```bash
psql -U <username> -d <database_name> -f schema.sql