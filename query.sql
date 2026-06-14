DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    role VARCHAR(20) CHECK(role IN ('Ticket Manager', 'Football Fan')),
    phone_number VARCHAR(20)  
);
 
CREATE TABLE Matches (
    match_id INT PRIMARY KEY,
    fixture VARCHAR(100) NOT NULL,
    tournament_category VARCHAR(50) NOT NULL,
    base_ticket_price DECIMAL(10, 2) ,
    match_status VARCHAR(20),

    CONSTRAINT CHK_MATCHES_BASE_TICKET_PRICE CHECK(base_ticket_price > 0),
    CONSTRAINT CHK_MATCHES_MATCH_STATUS CHECK(match_status IN ('Available', 'Selling Fast', 'Sold Out', 'Postponed'))
  );

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    match_id INT REFERENCES matches(match_id),
    seat_number VARCHAR(20),
    payment_status VARCHAR(20),
    total_cost DECIMAL(10,2),

    CONSTRAINT CHK_BOOKING_PAYMENT_STATUS CHECK(payment_status IN('Pending', 'Confirmed', 'Cancelled', 'Refunded')),
    CONSTRAINT CHK_BOOKINGS_TOTAL_COST CHECK(total_cost > 0)
);


INSERT INTO Users (user_id, full_name, email, role, phone_number) VALUES
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', NULL);


INSERT INTO Matches (match_id, fixture, tournament_category, base_ticket_price, match_status) VALUES
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

INSERT INTO Bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) VALUES
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, NULL, NULL, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);



-- Query 1
SELECT 
  match_id, 
  fixture, 
  base_ticket_price 
  FROM matches
WHERE tournament_category = 'Champions League'
AND match_status = 'Available';

-- Query 2

SELECT 
  user_id, 
  full_name,
  email
  FROM users
  WHERE full_name LIKE 'Tanvir%'
  OR full_name ILIKE '%haque%';

-- Query 3

SELECT 
  booking_id, 
  user_id, 
  match_id, 
  COALESCE(payment_status, 'Action Required') AS "systematic_status" 
  FROM bookings
  WHERE payment_status IS NULL;

-- Query 4


SELECT 
  b.booking_id, 
  u.full_name,
  m.fixture,
  b.total_cost
  FROM bookings AS b 
  INNER JOIN users AS u  on b.user_id = u.user_id
  INNER JOIN matches AS m on b.match_id= m.match_id;


-- Query 5
SELECT 
  u.user_id,
  u.full_name,
  b.booking_id
  FROM  users AS u
  LEFT JOIN bookings AS b  USING(user_id);


-- Query 6

SELECT
  booking_id,
  match_id,
  total_cost
  FROM bookings WHERE total_cost >(
  SELECT 
  AVG(total_cost) 
  FROM bookings
);

-- Query 7
SELECT 
  match_id, 
  fixture, 
  base_ticket_price 
  FROM matches
  ORDER BY base_ticket_price DESC
  LIMIT 2 offset 1;
