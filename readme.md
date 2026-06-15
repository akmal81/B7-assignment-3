# Assignment 3
ERD diagram Link : https://lucid.app/lucidchart/7354ab36-25b1-419a-8460-6a552f10930c/edit?viewport_loc=79%2C217%2C3667%2C2208%2C0_0&invitationId=inv_99a17b90-4cba-4196-b78c-f98679f86db2
GitHub link : https://github.com/akmal81/B7-assignment-3.git
Interview Video Link : https://drive.google.com/drive/folders/14AWeaG5eGZEx65X6-8ykdMS-rDzX2u4I?usp=sharing

# ⚽ Football Ticket Booking System

Football Ticket Booking System is a relational database system designed to manage sports match fixtures, track user registrations, and handle seamless ticket booking operations. This repository contains the complete PostgreSQL database schema, strict data constraints, dummy datasets, and analytical queries.

---

## 📊 Database Schema & Table Explanations

The system is built on a structured relational model consisting of **3 core tables** designed for optimal data integrity.

### 👥 1. `Users` Table
Stores data for all registered entities and fans within the ecosystem.
*   🆔 **`user_id` (INT, Primary Key):** A unique identifier for each user.
*   👤 **`full_name` (VARCHAR):** The complete name of the user *(Enforced: `NOT NULL`)*.
*   📧 **`email` (VARCHAR, Unique):** The user's email address, guaranteed to be globally unique.
*   🔑 **`role` (VARCHAR):** Privilege level. A `CHECK` constraint limits this strictly to either `'Ticket Manager'` or `'Football Fan'`.
*   📞 **`phone_number` (VARCHAR):** The contact number of the user *(Optional)*.

### 🏟️ 2. `Matches` Table
Manages the scheduled sports fixtures and tracks active ticketing tiers.
*   🆔 **`match_id` (INT, Primary Key):** A unique identifier for each match.
*   ⚔️ **`fixture` (VARCHAR):** The competing teams (e.g., `'Real Madrid vs Barcelona'`).
*   🏆 **`tournament_category` (VARCHAR):** The league or tournament name (e.g., `'Champions League'`, `'Serie A'`).
*   💵 **`base_ticket_price` (DECIMAL):** The standard cost of a ticket. Regulated by a `CHECK` constraint to ensure prices are always $> 0$.
*   📌 **`match_status` (VARCHAR):** Current booking availability. Enforced via a `CHECK` constraint to accept only: `'Available'`, `'Selling Fast'`, `'Sold Out'`, or `'Postponed'`.

### 🎟️ 3. `Bookings` Table
Maps the relational transactional flow between individual fans and specific match events.
*   🆔 **`booking_id` (INT, Primary Key):** A unique identifier for each ticket transaction.
*   👤 **`user_id` (INT, Foreign Key):** References the `Users` table to identify the purchaser.
*   ⚽ **`match_id` (INT, Foreign Key):** References the `Matches` table to pinpoint the targeted event.
*   💺 **`seat_number` (VARCHAR):** The designated stadium seat allocated to the fan.
*   💳 **`payment_status` (VARCHAR):** Tracks transaction state. Regulated via a `CHECK` constraint to accept only: `'Pending'`, `'Confirmed'`, `'Cancelled'`, or `'Refunded'`.
*   💰 **`total_cost` (DECIMAL):** The final transactional cost, strictly enforced via checks to be $> 0$.

---

## 🚀 How to Use the SQL Code

Follow these quick steps to set up and populate this database environment locally:

1. **Open your Database Tool:** Fire up your preferred SQL client or terminal manager (such as *pgAdmin*, *Beekeeper*, or the standard CLI *psql*).
2. **Target a Database:** Connect to your desired server instance and open a fresh SQL editor page.
3. **Load the Script:** Open the [`query.sql`](https://github.com/akmal81/B7-assignment-3/blob/main/query.sql) file from this repository and copy the entire script contents.
4. **Execute:** Run the query script to construct your database environment.

> ⚠️ **Important Warning:** The script includes destructive `DROP TABLE IF EXISTS` cascading logic at the top. Running the script will completely wipe any pre-existing instances of these tables before rebuilding them and injecting fresh seed datasets.

---

## 🔍 SQL Queries Explanation

The database script comes pre-configured with **7 tailored analytical queries** designed to demonstrate data retrieval, pattern matching, data formatting, and relational joining:

| Query ID | Operational Category | Business Logic & Objective |
| :--- | :--- | :--- |
| **`Q 1`** | **Conditional Filtering** | Isolates active matches belonging specifically to the **'Champions League'** where the ticket availability is flagged as **'Available'**. |
| **`Q 2`** | **Pattern Matching** | Uses case-insensitive regex lookups (`ILIKE`) to fetch user accounts whose names either start explicitly with **'Tanvir'** or conclude with **'Haque'**. |
| **`Q 3`** | **Null Value Handling** | Employs the `COALESCE` function to scan booking logs. If a transaction contains an unassigned payment status (`NULL`), it elegantly outputs a fallback string: `'Action Required'`. |
| **`Q 4`** | **Inner Join Relational Merge** | Combines rows across `Bookings`, `Users`, and `Matches` using shared key variables (`USING(user_id, match_id)`) to output a unified sales receipt containing booking IDs, fan names, fixtures, and total expenditures. |
| **`Q 5`** | **Full Outer Join** | Executes a comprehensive `FULL JOIN` between `Users` and `Bookings`. This maps all existing users alongside booking references, preserving rows for fans who have not placed a booking order yet. |
| **`Q 6`** | **Sub-query & Aggregation** | Isolates premium transactions by computing a live database-wide average ticket cost (`AVG`) and returning only rows whose individual `total_cost` exceeds that baseline. |
| **`Q 7`** | **Sorting & Pagination** | Sorts all match events from highest to lowest price using `ORDER BY DESC`. It then combines `LIMIT 2 OFFSET 1` to bypass the top record and isolate the **2nd and 3rd most expensive fixtures** in the ledger. |

---