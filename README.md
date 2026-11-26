# Hotel Reservation Operations Analytics using MySQL

## Project Overview

This project demonstrates how MySQL can be used to analyse hotel reservation data and solve practical business problems.

The analysis focuses on understanding booking demand, guest behaviour, stay performance, staff workload, room utilization and operational challenges at StayPoint Hospitality.

The project involves 7,045 records across six interconnected tables and 32 analytical SQL queries.

---

## Project Objectives

- Understand booking demand across hotels and booking channels.
- Analyse guest booking behaviour and spending patterns.
- Evaluate stay outcomes and stay duration.
- Analyse staff performance and workload distribution.
- Understand room usage across different room types.
- Identify cancellations, no-shows and operational challenges.
- Provide data-driven business recommendations.

---

## Tools & Technologies

- MySQL
- MySQL Workbench
- SQL
- CSV Datasets
- Microsoft Word
- Microsoft PowerPoint

---

## Dataset Description

The project consists of six relational datasets.

| Dataset  | Records | Columns |
|----------|--------:|--------:|
| Guests   | 350     | 7       |
| Hotels   | 25      | 6       |
| Rooms    | 600     | 7       |
| Bookings | 2,800   | 8       |
| Stays    | 3,200   | 10      |
| Staff    | 70      | 6       |
| Total    | 7,045   |         |

The datasets contain information related to guest profiles, hotel properties, room types, reservations, stay outcomes and staff performance.

---

## Database Design

Database Name: hotel_reservation_analytics

The database was designed using an Entity Relationship (ER) Diagram.

### Database Relationships

- Guests → Bookings
- Hotels → Bookings
- Hotels → Rooms
- Bookings → Stays
- Rooms → Stays
- Staff → Stays

Primary keys and foreign keys were used to establish relationships and maintain referential integrity.

---

## SQL Concepts Used

- CREATE DATABASE
- CREATE TABLE
- Primary Keys
- Foreign Keys
- Constraints
- SELECT
- WHERE
- DISTINCT
- GROUP BY
- ORDER BY
- HAVING
- INNER JOIN
- LEFT JOIN
- Aggregate Functions
- CASE Statements
- Subqueries
- Date Functions
- Database Indexing

---

## Data Cleaning and Validation

The following data preparation and validation activities were performed:

- Studied the structure of all six datasets.
- Identified appropriate data types.
- Defined primary and foreign keys.
- Imported CSV files into MySQL.
- Verified table structures.
- Validated record counts.
- Examined missing values and duplicate records.
- Reviewed relationships between tables.

---

## Project Workflow

### Sprint 1: Business and Data Understanding

- Understood the business requirements.
- Studied the ER diagram.
- Identified tables, columns and relationships.
- Developed logical solutions for 10 business scenarios.

### Sprint 2: Database Setup

- Created the MySQL database.
- Created six relational tables.
- Defined primary and foreign keys.
- Imported and validated 7,045 records.

### Sprint 3: Exploratory Data Analysis (EDA)

Performed basic SQL analysis to understand the dataset and identify important business metrics.

### Sprint 4: Objective-Based Analysis

Developed analytical SQL queries to address five major business objectives.

---

## Business Questions

### Sprint 3: Basic Data Analysis

1. What is the total number of guests?
2. What is the total number of bookings?
3. What is the total number of stays?
4. What are the different room types available?
5. How many staff members are currently active?
6. What are the different booking channels?
7. What is the total booking amount across all bookings?
8. What is the average number of nights booked per booking?

---

### 4.1 Booking Demand Analysis

1. Which hotels receive the highest number of bookings?
2. Which booking channel generates the highest number of bookings?
3. Which room type has the highest booking demand?
4. How does booking volume change over time?
5. Which hotels generate the highest total booking amount?

---

### 4.2 Guest Booking Behaviour

1. Which guests have made the highest number of bookings?
2. Which guests contribute the highest total booking amount?
3. How does guest booking activity vary across hotels?
4. How does booking behaviour differ between Individual and Corporate guests?
5. How do guest booking patterns change over time?

---

### 4.3 Stay Performance Analysis

1. What is the distribution of different stay statuses?
2. How do stay outcomes vary across hotels?
3. What is the average duration of completed stays?
4. Which hotels have higher booking activity and problem rates?
5. How does stay performance change over time?

---

### 4.4 Staff and Room Performance

1. How many stays are handled by each staff member?
2. How do stay outcomes vary across staff members?
3. What is the average completed stay duration handled by each staff member?
4. How does room usage vary across different room types?
5. Which rooms have higher stay completion rates?

---

### 4.5 Booking and Stay Problem Analysis

1. Which bookings resulted in cancellations or no-shows?
2. How do booking problems vary across booking channels?
3. How do stay outcomes vary based on service request counts?
4. Which hotels experience higher booking and stay problem rates?

---

## Key Performance Indicators

| KPI                   | Result        |
|-----------------------|--------------:|
| Total Guests          | 350           |
| Total Hotels          | 25            |
| Total Rooms           | 600           |
| Total Bookings        | 2,800         |
| Total Stays           | 3,200         |
| Total Staff           | 70            |
| Active Staff          | 63            |
| Inactive Staff        | 7             |
| Total Booking Amount  | 45,823,178.73 |
| Average Nights Booked | 3.32          |
| Booking Channels      | 5             |
| Room Types            | 4             |

---

## Key Findings

- Kolkata Residency recorded the highest booking demand with 129 bookings.
- Website was the leading booking channel with 984 bookings.
- Mobile App generated 875 bookings.
- Website and Mobile App contributed approximately 66.4% of total bookings.
- 2,117 stay records were successfully checked out.
- 542 stay records were marked as no-show.
- 480 stay records were cancelled.
- 61 stay records were in progress.
- Approximately 66.16% of stay records resulted in completed check-outs.
- Cancellations and no-shows accounted for approximately 31.94% of stay records.
- 63 out of 70 staff members were active.
- The average booked duration was 3.32 nights.

---

## Business Value

This analysis helps hospitality businesses:

- Understand booking demand and customer behaviour.
- Identify high-performing hotels and booking channels.
- Improve customer retention and guest experience.
- Reduce cancellations and no-shows.
- Improve staff and room resource planning.
- Identify operational improvement opportunities.
- Support data-driven business decisions.

---

## Project Deliverables

- Database Design and ER Diagram
- Six CSV Datasets
- MySQL Database Setup
- Data Validation Queries
- 32 Analytical SQL Queries
- Business Findings and Recommendations
- Project Documentation
- Project Presentation

---

## Conclusion

This project demonstrates how SQL and MySQL can be used to transform raw hotel reservation data into meaningful business insights.

The analysis provides a better understanding of booking demand, guest behaviour, stay outcomes, staff performance and operational challenges.

Through this project, I strengthened my skills in SQL, relational database design, exploratory data analysis, analytical thinking and business problem-solving.

The findings and recommendations can support hospitality businesses in improving operational efficiency, guest satisfaction and data-driven decision-making.

---

## Author

Kalpana Vallepu
