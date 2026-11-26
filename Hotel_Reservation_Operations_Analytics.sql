CREATE DATABASE Hotel_Reservation_Analytics;
USE hotel_reservation_analytics;
SHOW DATABASES;

CREATE TABLE guests (
    guest_id VARCHAR(20) PRIMARY KEY,
    guest_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    guest_type VARCHAR(20),
    preferred_room_type VARCHAR(20),
    loyalty_tier VARCHAR(20),
    account_since DATE
);

CREATE TABLE hotels (
    hotel_id VARCHAR(20) PRIMARY KEY,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    star_rating INT,
    total_rooms INT,
    opened_date DATE
);

CREATE TABLE staff (
    staff_id VARCHAR(20) PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    hire_date DATE,
    rating DECIMAL(3,2),
    department VARCHAR(30),
    is_active VARCHAR(3)
);

CREATE TABLE rooms (
    room_id VARCHAR(20) PRIMARY KEY,
    hotel_id VARCHAR(20) NOT NULL,
    room_type VARCHAR(30),
    floor_number INT,
    max_occupancy INT,
    price_per_night DECIMAL(10,2),
    is_active VARCHAR(3),

    FOREIGN KEY (hotel_id)
        REFERENCES hotels(hotel_id)
);

CREATE TABLE bookings (
    booking_id VARCHAR(20) PRIMARY KEY,
    guest_id VARCHAR(20) NOT NULL,
    hotel_id VARCHAR(20) NOT NULL,
    booking_date DATE,
    room_type_requested VARCHAR(30),
    booking_channel VARCHAR(30),
    nights_booked INT,
    total_amount DECIMAL(12,2),

    FOREIGN KEY (guest_id)
        REFERENCES guests(guest_id),

    FOREIGN KEY (hotel_id)
        REFERENCES hotels(hotel_id)
);

CREATE TABLE stays (
    stay_id VARCHAR(20) PRIMARY KEY,
    booking_id VARCHAR(20) NOT NULL,
    room_id VARCHAR(20) NOT NULL,
    staff_id VARCHAR(20) NOT NULL,
    check_in_date DATE,
    check_out_date DATE,
    status VARCHAR(20),
    nights_stayed INT,
    service_requests INT,
    stay_duration_hrs INT,

    FOREIGN KEY (booking_id)
        REFERENCES bookings(booking_id),

    FOREIGN KEY (room_id)
        REFERENCES rooms(room_id),

    FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id)
);

CREATE INDEX idx_bookings_date
ON bookings(booking_date);

CREATE INDEX idx_stays_status
ON stays(status);

-- IMPORT CSV FILES HERE in order: guests, hotels, staff, rooms, bookings, stays.
-- Expected counts: 350, 25, 70, 600, 2800, 3200 (total 7045).
USE hotel_reservation_analytics;

SHOW TABLES;

DESCRIBE guests;
DESCRIBE hotels;
DESCRIBE staff;
DESCRIBE rooms;
DESCRIBE bookings;
DESCRIBE stays;

# Verify imported records
SELECT 'guests' AS table_name, COUNT(*) AS records
FROM guests
UNION ALL
SELECT 'hotels', COUNT(*) FROM hotels
UNION ALL
SELECT 'staff', COUNT(*) FROM staff
UNION ALL
SELECT 'rooms', COUNT(*) FROM rooms
UNION ALL
SELECT 'bookings', COUNT(*) FROM bookings
UNION ALL
SELECT 'stays', COUNT(*) FROM stays;

SHOW DATABASES;
show tables;

SELECT COUNT(*) AS total_guests FROM guests;

SELECT COUNT(*) AS total_hotels FROM hotels;

SELECT COUNT(*) AS total_staff FROM staff;

SELECT COUNT(*) AS total_rooms FROM rooms;

SELECT COUNT(*) AS total_bookings FROM bookings;

SELECT COUNT(*) AS total_stays FROM stays;

# ==========================================
# Sprint 3: Basic Analysis / Data Exploration
# ==========================================

#Question 1. What is the total number of guests?
SELECT COUNT(*) AS total_guests
FROM guests;

#Question 2: What is the total number of bookings?
SELECT COUNT(*) AS total_bookings
FROM bookings;

# Question 3: What is the total number of stays?
SELECT COUNT(*) AS total_stays
FROM stays;

# 4. What are the different room types available?
SELECT DISTINCT room_type
FROM rooms;

#5. How many staff members are currently active?
SELECT COUNT(*) AS active_staff
FROM staff
WHERE is_active = 'Yes';

# 6. What are the different booking channels?
SELECT DISTINCT booking_channel
FROM bookings;

# 7. What is the total booking amount across all bookings?
SELECT ROUND(SUM(total_amount), 2) AS total_booking_amount
FROM bookings;

# 8. What is the average nights booked per booking?
SELECT ROUND(AVG(nights_booked), 2) AS avg_nights_booked
FROM bookings;

# ==========================================
# Sprint 4: Objective-Based Analysis
# ==========================================
# 4.1 Understand Booking Demand
# Q1. Which hotels receive the highest number of bookings?
SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(b.booking_id) AS total_bookings
FROM hotels h
LEFT JOIN bookings b
    ON h.hotel_id = b.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY total_bookings DESC;

# Q2. Which booking channel generates the highest number of bookings?
SELECT
    booking_channel,
    COUNT(booking_id) AS total_bookings
FROM bookings
GROUP BY booking_channel
ORDER BY total_bookings DESC;

# Q3. Which room type has the highest booking demand?
SELECT
    room_type_requested,
    COUNT(booking_id) AS total_bookings
FROM bookings
GROUP BY room_type_requested
ORDER BY total_bookings DESC;

# Q4. How does booking volume change over time?
SELECT
    DATE_FORMAT(booking_date, '%Y-%m') AS booking_month,
    COUNT(booking_id) AS total_bookings
FROM bookings
GROUP BY booking_month
ORDER BY booking_month ASC;

# Q5. Which hotels generate the highest total booking amount?
SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(b.booking_id) AS total_bookings,
    ROUND(SUM(b.total_amount), 2) AS total_booking_amount
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY total_booking_amount DESC;

# ==========================================
# 4.2 Understand Guest Booking Behaviour
# ==========================================
# Q1. Which guests make the highest number of bookings?

SELECT
    g.guest_id,
    COUNT(b.booking_id) AS total_bookings
FROM guests g
LEFT JOIN bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_id
ORDER BY total_bookings DESC;

# Q2. Which guests have the highest total booking amount?

SELECT
    g.guest_id,
    COUNT(b.booking_id) AS total_bookings,
    ROUND(SUM(b.total_amount), 2) AS total_booking_amount
FROM guests g
JOIN bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_id
ORDER BY total_booking_amount DESC;

# Q3. How does guest booking activity vary across different hotels?

SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(DISTINCT b.guest_id) AS unique_guests,
    COUNT(b.booking_id) AS total_bookings
FROM hotels h
LEFT JOIN bookings b
    ON h.hotel_id = b.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY unique_guests DESC;

# Q4. Compare booking behaviour between Individual and Corporate guests.

SELECT
    g.guest_type,
    COUNT(DISTINCT g.guest_id) AS total_guests,
    COUNT(b.booking_id) AS total_bookings,
    ROUND(SUM(b.total_amount), 2) AS total_booking_amount,
    ROUND(AVG(b.total_amount), 2) AS avg_booking_amount,
    ROUND(AVG(b.nights_booked), 2) AS avg_nights_booked
FROM guests g
JOIN bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_type
ORDER BY total_bookings DESC;

# Q5. How do guest booking patterns change over time?

SELECT
    DATE_FORMAT(booking_date, '%Y-%m') AS booking_month,
    COUNT(DISTINCT guest_id) AS unique_guests,
    COUNT(booking_id) AS total_bookings,
    ROUND(SUM(total_amount), 2) AS total_booking_amount
FROM bookings
GROUP BY booking_month
ORDER BY booking_month ASC;

# ==========================================
# 4.3 Evaluate Stay Performance
# ==========================================

# Q1. What is the distribution of stays across different stay statuses?

SELECT
    status,
    COUNT(*) AS total_stays,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM stays), 2) AS percentage
FROM stays
GROUP BY status
ORDER BY total_stays DESC;

# Q2. How do stay outcomes vary across different hotels?

SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Checked-out'
        THEN 1 ELSE 0 END) AS checked_out,
    SUM(CASE WHEN s.status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show,
    SUM(CASE WHEN s.status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled,
    SUM(CASE WHEN s.status = 'In-progress'
        THEN 1 ELSE 0 END) AS in_progress
FROM hotels h
LEFT JOIN bookings b
    ON h.hotel_id = b.hotel_id
LEFT JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY total_stays DESC;

# Q3. What is the average stay duration across different hotels?

SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(s.stay_id) AS completed_stays,
    ROUND(AVG(DATEDIFF(s.check_out_date,
        s.check_in_date)), 2) AS avg_stay_duration
FROM hotels h
JOIN bookings b
    ON h.hotel_id = b.hotel_id
JOIN stays s
    ON b.booking_id = s.booking_id
WHERE s.status = 'Checked-out'
    AND s.check_out_date >= s.check_in_date
GROUP BY h.hotel_id, h.hotel_name
ORDER BY avg_stay_duration DESC;

# Q4. Which hotels have higher booking activity or poorer stay outcomes?
SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(DISTINCT b.booking_id) AS total_bookings,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Checked-out'
        THEN 1 ELSE 0 END) AS completed_stays,
    SUM(CASE WHEN s.status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show_stays,
    SUM(CASE WHEN s.status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled_stays,
    ROUND(
        SUM(CASE WHEN s.status IN ('No-show', 'Cancelled')
            THEN 1 ELSE 0 END) * 100.0 /
        NULLIF(COUNT(s.stay_id), 0), 2
    ) AS problem_rate
FROM hotels h
LEFT JOIN bookings b
    ON h.hotel_id = b.hotel_id
LEFT JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY problem_rate DESC, total_bookings DESC;

# Q5. How does stay performance change over time?
SELECT
    DATE_FORMAT(b.booking_date, '%Y-%m') AS booking_month,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Checked-out'
        THEN 1 ELSE 0 END) AS completed_stays,
    SUM(CASE WHEN s.status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show_stays,
    SUM(CASE WHEN s.status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled_stays,
    SUM(CASE WHEN s.status = 'In-progress'
        THEN 1 ELSE 0 END) AS in_progress_stays,
    ROUND(
        SUM(CASE WHEN s.status = 'Checked-out'
            THEN 1 ELSE 0 END) * 100.0 /
        COUNT(s.stay_id), 2
    ) AS completion_rate
FROM bookings b
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY booking_month
ORDER BY booking_month ASC;

# ==========================================
# 4.4 Understand Staff and Room Performance
# ==========================================
# Q1. Which staff members have handled the highest and lowest number of stays?
SELECT
    st.staff_id,
    COUNT(s.stay_id) AS total_stays_handled
FROM staff st
LEFT JOIN stays s
    ON st.staff_id = s.staff_id
GROUP BY st.staff_id
ORDER BY total_stays_handled DESC;

# Q2. How does staff performance vary across different stay outcomes?

SELECT
    st.staff_id,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Checked-out'
        THEN 1 ELSE 0 END) AS checked_out,
    SUM(CASE WHEN s.status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show,
    SUM(CASE WHEN s.status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled,
    SUM(CASE WHEN s.status = 'In-progress'
        THEN 1 ELSE 0 END) AS in_progress
FROM staff st
LEFT JOIN stays s
    ON st.staff_id = s.staff_id
GROUP BY st.staff_id
ORDER BY checked_out DESC;

# Q3. What is the average completed stay duration handled by each staff member?

SELECT
    st.staff_id,
    COUNT(s.stay_id) AS completed_stays,
    ROUND(AVG(DATEDIFF(s.check_out_date,
        s.check_in_date)), 2) AS avg_stay_duration
FROM staff st
JOIN stays s
    ON st.staff_id = s.staff_id
WHERE s.status = 'Checked-out'
    AND s.check_out_date >= s.check_in_date
GROUP BY st.staff_id
ORDER BY avg_stay_duration DESC;

# Q4. Which room types are most utilized based on stay activity?

SELECT
    r.room_type,
    COUNT(DISTINCT r.room_id) AS total_rooms,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Checked-out'
        THEN 1 ELSE 0 END) AS completed_stays,
    ROUND(
        COUNT(s.stay_id) * 1.0 /
        COUNT(DISTINCT r.room_id), 2
    ) AS avg_stays_per_room
FROM rooms r
LEFT JOIN stays s
    ON r.room_id = s.room_id
GROUP BY r.room_type
ORDER BY avg_stays_per_room DESC;

# Q5. How does stay performance vary across different rooms?

SELECT
    r.room_id,
    r.room_type,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Checked-out'
        THEN 1 ELSE 0 END) AS completed_stays,
    SUM(CASE WHEN s.status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show_stays,
    SUM(CASE WHEN s.status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled_stays,
    SUM(CASE WHEN s.status = 'In-progress'
        THEN 1 ELSE 0 END) AS in_progress_stays,
    ROUND(
        SUM(CASE WHEN s.status = 'Checked-out'
            THEN 1 ELSE 0 END) * 100.0 /
        NULLIF(COUNT(s.stay_id), 0), 2
    ) AS completion_rate
FROM rooms r
LEFT JOIN stays s
    ON r.room_id = s.room_id
GROUP BY r.room_id, r.room_type
ORDER BY completion_rate DESC;

# ==========================================
# 4.5 Identify Booking and Stay Problems
# ==========================================

# Q1. Which bookings resulted in cancellations or no-shows?

SELECT
    b.booking_id,
    b.guest_id,
    h.hotel_name,
    b.booking_channel,
    b.booking_date,
    b.total_amount,
    s.stay_id,
    s.status
FROM bookings b
JOIN stays s
    ON b.booking_id = s.booking_id
JOIN hotels h
    ON b.hotel_id = h.hotel_id
WHERE s.status IN ('Cancelled', 'No-show')
ORDER BY b.total_amount DESC;

# Q2. What are the common stay statuses and problem patterns across different booking channels?

SELECT
    b.booking_channel,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Checked-out'
        THEN 1 ELSE 0 END) AS completed_stays,
    SUM(CASE WHEN s.status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show_stays,
    SUM(CASE WHEN s.status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled_stays,
    SUM(CASE WHEN s.status = 'In-progress'
        THEN 1 ELSE 0 END) AS in_progress_stays,
    ROUND(
        SUM(CASE WHEN s.status IN ('Cancelled', 'No-show')
            THEN 1 ELSE 0 END) * 100.0 /
        COUNT(s.stay_id), 2
    ) AS problem_rate
FROM bookings b
JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY b.booking_channel
ORDER BY problem_rate DESC;

# Q3. How do high service request counts relate to stay performance?

SELECT
    CASE
        WHEN service_requests = 0 THEN 'No Requests'
        WHEN service_requests BETWEEN 1 AND 3 THEN 'Low Requests'
        WHEN service_requests >= 4 THEN 'High Requests'
        ELSE 'Unknown'
    END AS request_category,
    COUNT(stay_id) AS total_stays,
    SUM(CASE WHEN status = 'Checked-out'
        THEN 1 ELSE 0 END) AS completed_stays,
    SUM(CASE WHEN status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled_stays,
    SUM(CASE WHEN status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show_stays,
    SUM(CASE WHEN status = 'In-progress'
        THEN 1 ELSE 0 END) AS in_progress_stays,
    ROUND(
        SUM(CASE WHEN status = 'Checked-out'
            THEN 1 ELSE 0 END) * 100.0 /
        COUNT(stay_id), 2
    ) AS completion_rate
FROM stays
GROUP BY request_category
ORDER BY completion_rate DESC;

# Q4. Which hotels experience the highest number and percentage of booking problems?

SELECT
    h.hotel_id,
    h.hotel_name,
    COUNT(s.stay_id) AS total_stays,
    SUM(CASE WHEN s.status = 'Cancelled'
        THEN 1 ELSE 0 END) AS cancelled_stays,
    SUM(CASE WHEN s.status = 'No-show'
        THEN 1 ELSE 0 END) AS no_show_stays,
    SUM(CASE WHEN s.status IN ('Cancelled', 'No-show')
        THEN 1 ELSE 0 END) AS total_problem_stays,
    ROUND(
        SUM(CASE WHEN s.status IN ('Cancelled', 'No-show')
            THEN 1 ELSE 0 END) * 100.0 /
        NULLIF(COUNT(s.stay_id), 0), 2
    ) AS problem_rate
FROM hotels h
LEFT JOIN bookings b
    ON h.hotel_id = b.hotel_id
LEFT JOIN stays s
    ON b.booking_id = s.booking_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY problem_rate DESC, total_problem_stays DESC;
