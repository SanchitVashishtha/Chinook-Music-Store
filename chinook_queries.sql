use chinook;

DESCRIBE album;
DESCRIBE artist;
DESCRIBE customer;
DESCRIBE employee;
DESCRIBE genre;
DESCRIBE invoice;
DESCRIBE invoice_line;
DESCRIBE media_type;
DESCRIBE playlist;
DESCRIBE playlist_track;
DESCRIBE track;


SELECT * FROM album;
SELECT * FROM artist;
SELECT * FROM customer;
SELECT * FROM employee;
SELECT * FROM genre;
SELECT * FROM invoice;
SELECT * FROM invoice_line;
SELECT * FROM media_type;
SELECT * FROM playlist;
SELECT * FROM playlist_track;
SELECT * FROM track;

-- The SQL script defines a total of eleven (11) tables for the Chinook database, but it lacks foreign key constraints. 
-- To create foreign keys for connecting the tables, we need to identify the relationships between the tables. Based on the table definitions provided, here are the most likely relationships:

-- Adding foreign key constraints

ALTER TABLE `album`
ADD CONSTRAINT `fk_album_artist`
FOREIGN KEY (`artist_id`) REFERENCES `artist`(`artist_id`);

ALTER TABLE `customer`
ADD CONSTRAINT `fk_customer_support_rep`
FOREIGN KEY (`support_rep_id`) REFERENCES `employee`(`employee_id`);

ALTER TABLE `invoice`
ADD CONSTRAINT `fk_invoice_customer`
FOREIGN KEY (`customer_id`) REFERENCES `customer`(`customer_id`);

ALTER TABLE `invoice_line`
ADD CONSTRAINT `fk_invoice_line_invoice`
FOREIGN KEY (`invoice_id`) REFERENCES `invoice`(`invoice_id`),
ADD CONSTRAINT `fk_invoice_line_track`
FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`);

ALTER TABLE `track`
ADD CONSTRAINT `fk_track_album`
FOREIGN KEY (`album_id`) REFERENCES `album`(`album_id`),
ADD CONSTRAINT `fk_track_media_type`
FOREIGN KEY (`media_type_id`) REFERENCES `media_type`(`media_type_id`),
ADD CONSTRAINT `fk_track_genre`
FOREIGN KEY (`genre_id`) REFERENCES `genre`(`genre_id`);

ALTER TABLE `playlist_track`
ADD CONSTRAINT `fk_playlist_track_playlist`
FOREIGN KEY (`playlist_id`) REFERENCES `playlist`(`playlist_id`),
ADD CONSTRAINT `fk_playlist_track_track`
FOREIGN KEY (`track_id`) REFERENCES `track`(`track_id`);

ALTER TABLE `employee`
ADD CONSTRAINT `fk_employee_reports_to`
FOREIGN KEY (`reports_to`) REFERENCES `employee`(`employee_id`);


-- OBJECTIVE QUESTIONS
-- 1.	Does any table have missing values or duplicates? If yes, how would you handle it?
-- --- Handling Missing Values 

-- To check for missing values in the album table
SELECT
    SUM(CASE WHEN album_id IS NULL THEN 1 ELSE 0 END) AS Missing_album_id,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS Missing_title,
    SUM(CASE WHEN artist_id IS NULL THEN 1 ELSE 0 END) AS Missing_artist_id
FROM album;

-- To check for missing values in the artist table
SELECT
    SUM(CASE WHEN artist_id IS NULL THEN 1 ELSE 0 END) AS Missing_artist_id,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS Missing_name
FROM artist;

-- To check for missing values in the customer table
SELECT
	
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS Missing_customer_id,
    SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS Missing_first_name,
    SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS Missing_last_name,
    SUM(CASE WHEN company IS NULL THEN 1 ELSE 0 END) AS Missing_company,
    SUM(CASE WHEN address IS NULL THEN 1 ELSE 0 END) AS Missing_address,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS Missing_city,
    SUM(CASE WHEN postal_code IS NULL THEN 1 ELSE 0 END) AS Missing_postal_code,
    SUM(CASE WHEN phone IS NULL THEN 1 ELSE 0 END) AS Missing_phone,
    SUM(CASE WHEN fax IS NULL THEN 1 ELSE 0 END) AS Missing_fax,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS Missing_email,
    SUM(CASE WHEN support_rep_id IS NULL THEN 1 ELSE 0 END) AS Missing_support_rep_id
FROM customer;
-- one missing phone number found, to give 'unknown' as default value
-- Marking records
SET SQL_SAFE_UPDATES = 0;
UPDATE customer
SET phone = 'unknown'
WHERE phone IS NULL;
SET SQL_SAFE_UPDATES = 1;

-- To check for missing values in the employee table
SELECT
    SUM(CASE WHEN employee_id IS NULL THEN 1 ELSE 0 END) AS Missing_employee_id,
    SUM(CASE WHEN last_name IS NULL THEN 1 ELSE 0 END) AS Missing_last_name,
    SUM(CASE WHEN first_name IS NULL THEN 1 ELSE 0 END) AS Missing_first_name,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS Missing_title,
    SUM(CASE WHEN reports_to IS NULL THEN 1 ELSE 0 END) AS Missing_reports_to,
    SUM(CASE WHEN birthdate IS NULL THEN 1 ELSE 0 END) AS Missing_birthdate,
    SUM(CASE WHEN hire_date IS NULL THEN 1 ELSE 0 END) AS Missing_hire_date,
    SUM(CASE WHEN address IS NULL THEN 1 ELSE 0 END) AS Missing_address,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS Missing_city,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS Missing_state,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS Missing_country,
    SUM(CASE WHEN postal_code IS NULL THEN 1 ELSE 0 END) AS Missing_postal_code,
    SUM(CASE WHEN phone IS NULL THEN 1 ELSE 0 END) AS Missing_phone,
    SUM(CASE WHEN fax IS NULL THEN 1 ELSE 0 END) AS Missing_fax,
    SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END) AS Missing_email
FROM employee;

-- to check NULL value in 'report_to' column
SELECT *
FROM employee
WHERE reports_to IS NULL;

-- To check for missing values in the genre table
SELECT
    SUM(CASE WHEN genre_id IS NULL THEN 1 ELSE 0 END) AS Missing_genre_id,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS Missing_name
FROM genre;

-- To check for missing values in the invoice table
SELECT
    SUM(CASE WHEN invoice_id IS NULL THEN 1 ELSE 0 END) AS Missing_invoice_id,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS Missing_customer_id,
    SUM(CASE WHEN invoice_date IS NULL THEN 1 ELSE 0 END) AS Missing_invoice_date,
    SUM(CASE WHEN billing_address IS NULL THEN 1 ELSE 0 END) AS Missing_billing_address,
    SUM(CASE WHEN billing_city IS NULL THEN 1 ELSE 0 END) AS Missing_billing_city,
    SUM(CASE WHEN billing_state IS NULL THEN 1 ELSE 0 END) AS Missing_state,
    SUM(CASE WHEN billing_country IS NULL THEN 1 ELSE 0 END) AS Missing_billing_country,
    SUM(CASE WHEN billing_postal_code IS NULL THEN 1 ELSE 0 END) AS Missing_billing_postal_code,
    SUM(CASE WHEN total IS NULL THEN 1 ELSE 0 END) AS Missing_total
FROM invoice;

-- To check for missing values in the invoice_line table
SELECT
    SUM(CASE WHEN invoice_line_id IS NULL THEN 1 ELSE 0 END) AS Missing_invoice_line_id,
    SUM(CASE WHEN invoice_id IS NULL THEN 1 ELSE 0 END) AS Missing_invoice_id,
    SUM(CASE WHEN track_id IS NULL THEN 1 ELSE 0 END) AS Missing_track_id,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS Missing_unit_price,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS Missing_quantity
FROM invoice_line;

-- To check for missing values in the media_type table
SELECT
    SUM(CASE WHEN media_type_id IS NULL THEN 1 ELSE 0 END) AS Missing_media_type_id,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS Missing_name
FROM media_type;

-- To check for missing values in the playlist table
SELECT
    SUM(CASE WHEN playlist_id IS NULL THEN 1 ELSE 0 END) AS Missing_playlist_id,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS Missing_name
FROM playlist;

-- To check for missing values in the playlist_track table
SELECT
    SUM(CASE WHEN playlist_id IS NULL THEN 1 ELSE 0 END) AS Missing_playlist_id,
    SUM(CASE WHEN track_id IS NULL THEN 1 ELSE 0 END) AS Missing_track_id
FROM playlist_track;

-- To check for missing values in the track table
SELECT
	SUM(CASE WHEN track_id IS NULL THEN 1 ELSE 0 END) AS Missing_track_id,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS Missing_name,
    SUM(CASE WHEN album_id IS NULL THEN 1 ELSE 0 END) AS Missing_album_id,
    SUM(CASE WHEN media_type_id IS NULL THEN 1 ELSE 0 END) AS Missing_media_type_id,
	SUM(CASE WHEN genre_id IS NULL THEN 1 ELSE 0 END) AS Missing_genre_id,
    SUM(CASE WHEN composer IS NULL THEN 1 ELSE 0 END) AS Missing_composer,
	SUM(CASE WHEN milliseconds IS NULL THEN 1 ELSE 0 END) AS Missing_milliseconds,
	SUM(CASE WHEN bytes IS NULL THEN 1 ELSE 0 END) AS Missing_bytes,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS Missing_unit_price
FROM track;

-- 978 missing composer records found, to give 'unknown' as default value
-- Marking records
SET SQL_SAFE_UPDATES = 0;
UPDATE track
SET composer = 'Unknown'
WHERE composer IS NULL;
SET SQL_SAFE_UPDATES = 1;

SELECT *
FROM track
WHERE composer = 'unknown';

SELECT *
FROM customer
WHERE phone IS NULL;


-- Handling Missing values = identifying and removing duplicates from all the tables

-- 1. Albums Table
-- Identify Duplicates:

WITH CTE_Albums AS (
    SELECT 
        album_id,
        ROW_NUMBER() OVER (PARTITION BY title, artist_id ORDER BY album_id) AS RowNum
    FROM album
)
SELECT * 
FROM CTE_Albums
WHERE RowNum > 1;

-- 2. artist Table
-- Identify Duplicates:

WITH CTE_Artists AS (
    SELECT 
        artist_id,
        ROW_NUMBER() OVER (PARTITION BY Name ORDER BY artist_id) AS RowNum
    FROM artist
)
SELECT * 
FROM CTE_Artists
WHERE RowNum > 1;

-- 3. Customers Table
-- Identify Duplicates:
WITH CTE_Customers AS (
    SELECT 
        customer_id,
        ROW_NUMBER() OVER (PARTITION BY first_name, last_name, email ORDER BY customer_id) AS RowNum
    FROM customer
)
SELECT * 
FROM CTE_Customers
WHERE RowNum > 1;

-- 4. Employees Table
-- Identify Duplicates:
WITH CTE_Employees AS (
    SELECT 
        employee_id,
        ROW_NUMBER() OVER (PARTITION BY first_name, last_name, email ORDER BY employee_id) AS RowNum
    FROM employee
)
SELECT * 
FROM CTE_Employees
WHERE RowNum > 1;

-- 5. Genres Table
-- Identify Duplicates:

WITH CTE_Genres AS (
    SELECT 
        genre_id,
        ROW_NUMBER() OVER (PARTITION BY Name ORDER BY genre_id) AS RowNum
    FROM genre
)
SELECT * 
FROM CTE_Genres
WHERE RowNum > 1;

-- 6. Invoices Table
-- Identify Duplicates:

WITH CTE_Invoices AS (
    SELECT 
        invoice_id,
        ROW_NUMBER() OVER (PARTITION BY invoice_id ORDER BY invoice_id) AS RowNum
    FROM invoice
)
SELECT * 
FROM CTE_Invoices
WHERE RowNum > 1;

-- 7. Invoice Line Table
-- Identify Duplicates:

WITH CTE_InvoiceItems AS (
    SELECT 
        invoice_line_id,
        ROW_NUMBER() OVER (PARTITION BY invoice_line_id ORDER BY invoice_line_id) AS RowNum
    FROM invoice_line
)
SELECT * 
FROM CTE_InvoiceItems
WHERE RowNum > 1;

-- 8. Media Type Table
-- Identify Duplicates:

WITH CTE_MediaTypes AS (
    SELECT 
        media_type_id,
        ROW_NUMBER() OVER (PARTITION BY Name ORDER BY media_type_id) AS RowNum
    FROM media_type
)
SELECT * 
FROM CTE_MediaTypes
WHERE RowNum > 1;

-- 9. Playlists Table
-- Identify Duplicates:

WITH CTE_Playlists AS (
    SELECT 
        playlist_id,
        ROW_NUMBER() OVER (PARTITION BY playlist_id ORDER BY playlist_id) AS RowNum
    FROM playlist
)
SELECT * 
FROM CTE_Playlists
WHERE RowNum > 1;

-- 10. Playlist Track Table
-- Identify Duplicates:

WITH CTE_PlaylistTrack AS (
    SELECT 
        playlist_id, 
        track_id,
        ROW_NUMBER() OVER (PARTITION BY playlist_id, track_id ORDER BY playlist_id, track_id) AS RowNum
    FROM playlist_track
)
SELECT * 
FROM CTE_PlaylistTrack
WHERE RowNum > 1;

-- 11. Tracks Table
-- Identify Duplicates:

WITH CTE_Tracks AS (
    SELECT 
        track_id,
        ROW_NUMBER() OVER (PARTITION BY track_id, genre_id ORDER BY track_id) AS RowNum
    FROM track
)
SELECT * 
FROM CTE_Tracks
WHERE RowNum > 1;

-- -- no duplicates found in any of the table


-- Objective Q2 Find the top-selling tracks and top artist in the USA and identify their most famous genres.
-- Top-selling tracks in the USA

SELECT 
    t.name AS TrackName, 
    ar.name AS ArtistName, 
    g.name AS GenreName, 
    SUM(il.quantity) AS TotalSales 
FROM invoice_line il 
JOIN track t ON il.track_id = t.track_id 
JOIN album al ON t.album_id = al.album_id 
JOIN artist ar ON al.artist_id = ar.artist_id 
JOIN invoice i ON il.invoice_id = i.invoice_id 
JOIN genre g ON t.genre_id = g.genre_id 
WHERE i.billing_country = 'USA' 
GROUP BY t.name, ar.name, g.name 
ORDER BY TotalSales DESC 
LIMIT 10;


-- Top artist in the USA and their most famous genres
SELECT 
    a.artist_id, 
    a.name AS artist_name, 
    g.name AS genre_name, 
    SUM(il.quantity) AS TotalSales
FROM 
    invoice AS i
JOIN invoice_line AS il ON i.invoice_id = il.invoice_id
JOIN track AS t ON il.track_id = t.track_id
JOIN album AS al ON t.album_id = al.album_id
JOIN artist AS a ON al.artist_id = a.artist_id
JOIN genre AS g ON t.genre_id = g.genre_id
WHERE 
    i.billing_country = 'USA'
GROUP BY 
    a.artist_id, a.Name, g.Name
ORDER BY 
    TotalSales DESC
LIMIT 10;

-- Q3 Customer demographic breakdown by country
SELECT 
    c.country,
    COUNT(*) AS CustomerCount
FROM 
    customer AS c
GROUP BY 
    c.country
ORDER BY 
    CustomerCount DESC;

-- Customer demographic breakdown by country, state & city
SELECT 
    c.country,
    c.state,
    c.city,
    COUNT(*) AS CustomerCount
FROM 
    customer AS c
GROUP BY 
    c.country, c.state, c.city
ORDER BY 
    c.country DESC;
    
    
-- Customer demographic breakdown by city
SELECT 
    c.city,
    COUNT(*) AS CustomerCount
FROM 
    customer AS c
GROUP BY 
    c.city
ORDER BY 
    CustomerCount DESC;


-- Q4.	Calculate the total revenue and number of invoices for each country, state, and city:

SELECT 
	i.billing_country, 
    i.billing_state, 
    i.billing_city,
    SUM(i.total) AS TotalRevenue, 
    COUNT(i.invoice_id) AS NumberOfInvoices
FROM invoice i
GROUP BY 
	i.billing_country, 
    i.billing_state, 
    i.billing_city
ORDER BY 
	i.billing_country, 
	SUM(i.total) DESC;
    
-- Q5 Find the top 5 customers by total revenue in each country

WITH CustomerRevenue AS (
    SELECT c.customer_id, c.first_name, c.last_name, c.country, SUM(i.total) AS TotalRevenue
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.country
)
SELECT *
FROM (
    SELECT customer_id, first_name, last_name, country, TotalRevenue,
           ROW_NUMBER() OVER (PARTITION BY country ORDER BY TotalRevenue DESC) AS `rank`
    FROM CustomerRevenue
) AS ranked
WHERE `rank`<= 5;

-- 6. Top-Selling Track for Each Customer

WITH CustomerTrackSales AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, " ", c.last_name) AS customer_name,
        t.name AS track_name,
        SUM(il.quantity) AS total_sales
    FROM
        customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name, t.name
),
RankedTracks AS (
    SELECT
        customer_id,
        customer_name,
        track_name,
        total_sales,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY total_sales DESC) AS `rank`
    FROM
        CustomerTrackSales
)
SELECT
    customer_id,
    customer_name,
    track_name AS top_track,
    total_sales
FROM
    RankedTracks
WHERE
    `rank` = 1
ORDER BY
    customer_id;


-- 7. Customer Purchasing Behavior Patterns

SELECT 
    c.country, 
    c.city, 
    c.customer_id, 
    COUNT(i.invoice_id) AS NumberOfPurchases, 
    ROUND(AVG(i.total), 2) AS AverageOrderValue 
FROM 
    customer c 
JOIN 
    invoice i ON c.customer_id = i.customer_id 
GROUP BY 
    c.country, c.city, c.customer_id 
ORDER BY 
    c.country, c.city, NumberOfPurchases DESC;

-- 8. Customer Churn Rate

WITH LastPurchase AS (
    SELECT c.customer_id, MAX(i.invoice_date) AS last_purchase_date
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.customer_id
),
TotalCustomers AS (
    SELECT COUNT(DISTINCT customer_id) AS total_customers
    FROM customer
),
ChurnedCustomers AS (
    SELECT COUNT(DISTINCT customer_id) AS churned_customers
    FROM LastPurchase
    WHERE last_purchase_date < DATE_SUB('2020-12-31', INTERVAL 6 MONTH)
)
SELECT
    tc.total_customers,
    cc.churned_customers,
    ROUND((cc.churned_customers / tc.total_customers) * 100,2) AS churned_percentage
FROM
    TotalCustomers tc,
    ChurnedCustomers cc;


-- 9. Percentage of Total Sales by Genre in the USA

-- best selling genres
SELECT g.name AS Genre, SUM(il.quantity) AS TotalSales,
       ROUND((SUM(il.quantity) * 100.0 / (SELECT SUM(il2.quantity)
                                    FROM invoice_line il2
                                    JOIN invoice i2 ON il2.invoice_id = i2.invoice_id
                                    WHERE i2.billing_country = 'USA')),2) AS PercentageOfTotalSales
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
JOIN invoice i ON il.invoice_id = i.invoice_id
WHERE i.billing_country = 'USA'
GROUP BY g.name
ORDER BY TotalSales DESC;

-- best selling genres & artists

WITH GenreSales AS (
    SELECT 
        g.name AS Genre, 
        ar.name AS Artist, 
        SUM(il.quantity) AS TotalSales, 
        ROUND((SUM(il.quantity) * 100.0 / 
              (SELECT SUM(il2.quantity) 
               FROM invoice_line il2 
               JOIN invoice i2 ON il2.invoice_id = i2.invoice_id 
               WHERE i2.billing_country = 'USA')), 2) AS PercentageOfTotalSales 
    FROM 
        invoice_line il 
    JOIN 
        track t ON il.track_id = t.track_id 
    JOIN 
        genre g ON t.genre_id = g.genre_id 
    JOIN 
        album al ON t.album_id = al.album_id 
    JOIN 
        artist ar ON al.artist_id = ar.artist_id 
    JOIN 
        invoice i ON il.invoice_id = i.invoice_id 
    WHERE 
        i.billing_country = 'USA' 
    GROUP BY 
        g.name, ar.name 
)
SELECT 
    Genre, 
    Artist, 
    TotalSales, 
    PercentageOfTotalSales 
FROM 
    GenreSales 
ORDER BY 
    TotalSales DESC;


-- 10. Customers Who Purchased Tracks from At Least 3 Different Genres

SELECT c.customer_id, CONCAT(c.first_name," ", c.last_name) AS customer_name, COUNT(DISTINCT g.genre_id) AS GenreCount
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
GROUP BY c.customer_id
HAVING GenreCount >= 3;


-- 11. Rank Genres Based on Sales Performance in the USA

SELECT g.name AS Genre, SUM(il.quantity) AS TotalSales,
		RANK() OVER (ORDER BY SUM(il.quantity) DESC) AS GenreRank
FROM invoice_line il
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
JOIN invoice i ON il.invoice_id = i.invoice_id
WHERE i.billing_country = 'USA'
GROUP BY g.name
ORDER BY GenreRank


-- 12. Customers Who Have Not Made a Purchase in the Last 3 Months

SELECT c.customer_id, CONCAT(c.first_name," ", c.last_name) AS customer_name, MAX(i.invoice_date) AS LastPurchaseDate
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id
HAVING LastPurchaseDate < DATE_SUB('2020-12-31', INTERVAL 3 MONTH);


-- SUBJECTIVE QUESTIONS

-- 1. Recommend the Three Albums from the New Record Label for Advertising in the USA

WITH usa_genre_sales AS (
  SELECT 
    g.name AS genre, 
    SUM(il.unit_price * il.quantity) AS total_sales
  FROM 
    customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
  WHERE 
    c.country = 'USA'
  GROUP BY 
    g.name
),
album_sales AS (
  SELECT 
    a.title AS album, 
    g.name AS genre, 
    SUM(il.unit_price * il.quantity) AS total_sales
  FROM 
    invoice_line il
    JOIN track t ON il.track_id = t.track_id
    JOIN album a ON t.album_id = a.album_id
    JOIN genre g ON t.genre_id = g.genre_id
    JOIN invoice i ON il.invoice_id = i.invoice_id
    JOIN customer c ON i.customer_id = c.customer_id
  WHERE 
    c.country = 'USA'
  GROUP BY 
    a.title, g.name
),
ranked_album_sales AS (
  SELECT 
    album, 
    genre, 
    total_sales, 
    DENSE_RANK() OVER (ORDER BY total_sales DESC) AS `rank`
  FROM 
    album_sales
)
SELECT 
  album, 
  genre, 
  total_sales,
  `rank`
FROM 
  ranked_album_sales
WHERE 
  'rank' <= 3
ORDER BY 
  `rank`, album
LIMIT 5;


WITH album_sales AS ( 
  SELECT  
    a.title AS album, 
    g.name AS genre, 
    SUM(il.unit_price * il.quantity) AS total_sales 
  FROM invoice_line il 
    JOIN track t ON il.track_id = t.track_id 
    JOIN album a ON t.album_id = a.album_id 
    JOIN genre g ON t.genre_id = g.genre_id 
    JOIN invoice i ON il.invoice_id = i.invoice_id 
    JOIN customer c ON i.customer_id = c.customer_id 
  WHERE c.country = 'USA' 
  GROUP BY a.title, g.name 
), 
ranked_album_sales AS ( 
  SELECT album, genre, total_sales, DENSE_RANK() OVER (PARTITION BY genre ORDER BY total_sales DESC) AS `rank` 
  FROM album_sales 
) 
SELECT album, genre, total_sales 
FROM ranked_album_sales 
WHERE `rank` <= 3 
ORDER BY genre, `rank`, album;


-- 2. Top selling genres in countries other than USA

-- To rank the most common genres across all countries outside the USA, and their frequency of occurrence 


WITH TopGenresByCountry AS (
    SELECT c.country, g.name AS genre, 
           SUM(il.unit_price * il.quantity) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY c.country ORDER BY SUM(il.unit_price * il.quantity) DESC) AS genre_rank
    FROM invoice_line il
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    JOIN invoice i ON il.invoice_id = i.invoice_id
    JOIN customer c ON i.customer_id = c.customer_id
    WHERE c.country <> 'USA'
    GROUP BY c.country, g.name
),

Top3GenresByCountry AS (
    SELECT country, genre, total_sales
    FROM TopGenresByCountry
    WHERE genre_rank <= 3
),

GenreFrequency AS (
    SELECT genre, COUNT(*) AS frequency
    FROM Top3GenresByCountry
    GROUP BY genre
)
SELECT genre, frequency, RANK() OVER (ORDER BY frequency DESC) AS genre_rank
FROM GenreFrequency
ORDER BY genre_rank;

-- most popular genre (country specific - outside USA)

WITH TopGenresByCountry AS (
    SELECT c.country, g.name AS genre, 
           SUM(il.unit_price * il.quantity) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY c.country ORDER BY SUM(il.unit_price * il.quantity) DESC) AS genre_rank
    FROM invoice_line il
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    JOIN invoice i ON il.invoice_id = i.invoice_id
    JOIN customer c ON i.customer_id = c.customer_id
    WHERE c.country <> 'USA'
    GROUP BY c.country, g.name
)
, Top3GenresByCountry AS (
    SELECT country, genre, total_sales
    FROM TopGenresByCountry
    WHERE genre_rank <= 3
)
SELECT country, genre, total_sales
FROM Top3GenresByCountry
ORDER BY country, total_sales DESC;

-- 3.	Customer Purchasing Behavior Analysis

WITH customer_purchases AS (
  SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MIN(i.invoice_date) AS first_purchase_date,
    COUNT(i.invoice_id) AS purchase_frequency,
    ROUND(AVG(i.total),2) AS average_spending,
    SUM(i.total) AS total_spending
  FROM
    customer c
    JOIN invoice i ON c.customer_id = i.customer_id
  GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
)
SELECT
  customer_id,
  first_name,
  last_name,
  purchase_frequency,
  average_spending,
  total_spending,
  CASE
    WHEN YEAR(first_purchase_date) = 2019 THEN 'New Customer'
    ELSE 'Long-term Customer'
  END AS customer_type
FROM
  customer_purchases
ORDER BY
    total_spending DESC,
    customer_type;
  
-- 4. product affinity analysis 

WITH customer_purchases AS (
    SELECT
        il.invoice_id,
        il.track_id,
        t.album_id,
        t.genre_id,
        a.title AS album_title,
        g.name AS genre_name,
        ar.name AS artist_name,
        i.customer_id
    FROM invoice_line il
    JOIN track t ON il.track_id = t.track_id
    JOIN album a ON t.album_id = a.album_id
    JOIN genre g ON t.genre_id = g.genre_id
    JOIN artist ar ON a.artist_id = ar.artist_id
    JOIN invoice i ON il.invoice_id = i.invoice_id
)
SELECT 
    p1.genre_name AS genre1,
    p1.artist_name AS artist1,
    p1.album_title AS album1,
    p2.genre_name AS genre2,
    p2.artist_name AS artist2,
    p2.album_title AS album2,
    COUNT(*) AS frequency
FROM customer_purchases p1
JOIN customer_purchases p2 ON p1.customer_id = p2.customer_id 
    AND p1.track_id < p2.track_id
    AND (p1.genre_name != p2.genre_name OR p1.artist_name != p2.artist_name OR p1.album_title != p2.album_title)
GROUP BY p1.genre_name, p1.artist_name, p1.album_title, p2.genre_name, p2.artist_name, p2.album_title
ORDER BY frequency DESC
LIMIT 10;

-- 5. Regional Market Analysis


WITH customer_dates AS (
    SELECT 
        c.customer_id, 
        c.country, 
        MIN(i.invoice_date) AS first_purchase_date, 
        MAX(i.invoice_date) AS last_purchase_date, 
        DATEDIFF(MAX(i.invoice_date), MIN(i.invoice_date)) AS tenure, 
        DATEDIFF('2020-12-31', MAX(i.invoice_date)) AS days_since_last_purchase 
    FROM customer c 
    JOIN invoice i ON c.customer_id = i.customer_id 
    GROUP BY c.customer_id, c.country 
), 
customer_classification AS ( 
    SELECT 
        customer_id, 
        country, 
        tenure, 
        days_since_last_purchase, 
        CASE  
            WHEN YEAR(first_purchase_date) = 2020 THEN 'New Customer' 
            ELSE 'Long-term Customer' 
        END AS customer_type, 
        CASE 
            WHEN last_purchase_date < DATE_SUB('2020-12-31', INTERVAL 6 MONTH) THEN 'Churned Customer' 
            ELSE 'Active Customer' 
        END AS customer_status 
    FROM customer_dates 
) 
SELECT 
    c.country, 
    COUNT(DISTINCT c.customer_id) AS num_customers, 
    SUM(i.total) AS total_sales, 
    ROUND(AVG(i.total),2) AS average_order_value, 
    COUNT(DISTINCT CASE WHEN cc.customer_type = 'Long-term Customer' THEN c.customer_id END) AS long_term_customers, 
    COUNT(DISTINCT CASE WHEN cc.customer_type = 'New Customer' THEN c.customer_id END) AS new_customers, 
    COUNT(DISTINCT CASE WHEN cc.customer_status = 'Churned Customer' THEN c.customer_id END) AS churned_customers 
FROM customer c 
JOIN invoice i ON c.customer_id = i.customer_id 
JOIN customer_classification cc ON c.customer_id = cc.customer_id 
GROUP BY c.country 
ORDER BY total_sales DESC;


-- 6. CUstomer risk profiling

-- Input (for identifying customers and risk frequency)
SELECT 
    c.customer_id,
    CONCAT(c.first_name," ",c.last_name) AS name,
    c.country,
    COUNT(i.invoice_id) AS purchase_frequency,
    SUM(i.total) AS total_spending,
    DATEDIFF('2020-12-31', MAX(i.invoice_date)) AS days_since_last_purchase,
    CASE 
        WHEN DATEDIFF('2020-12-31', MAX(i.invoice_date)) > 180 THEN 'High Risk'
        WHEN DATEDIFF('2020-12-31', MAX(i.invoice_date)) BETWEEN 90 AND 180 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category,
    CASE 
        WHEN DATEDIFF('2020-12-31', MAX(i.invoice_date)) > 180 THEN 1
        WHEN DATEDIFF('2020-12-31', MAX(i.invoice_date)) BETWEEN 90 AND 180 THEN 2
        ELSE 3
    END AS risk_order
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
ORDER BY risk_order, total_spending DESC;

-- for identifying avg purchase and spend across risk categories

SELECT 
    risk_category,
    ROUND(AVG(total_spending),2) AS avg_spending,
    ROUND(AVG(purchase_frequency),0) AS avg_purchase_per_person
FROM (
    SELECT  
        c.customer_id, 
        CONCAT(c.first_name, " ", c.last_name) AS name, 
        c.country, 
        COUNT(i.invoice_id) AS purchase_frequency, 
        SUM(i.total) AS total_spending, 
        DATEDIFF('2020-12-31', MAX(i.invoice_date)) AS days_since_last_purchase, 
        CASE  
            WHEN DATEDIFF('2020-12-31', MAX(i.invoice_date)) > 180 THEN 'High Risk' 
            WHEN DATEDIFF('2020-12-31', MAX(i.invoice_date)) BETWEEN 90 AND 180 THEN 'Medium Risk' 
            ELSE 'Low Risk' 
        END AS risk_category
    FROM customer c 
    JOIN invoice i ON c.customer_id = i.customer_id 
    GROUP BY c.customer_id, c.first_name, c.last_name, c.country
) AS customer_risk_profile
GROUP BY risk_category
ORDER BY FIELD(risk_category, 'High Risk', 'Medium Risk', 'Low Risk');


-- 7. Customer Lifetime Value Modeling

WITH customer_clv AS ( 
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        MIN(i.invoice_date) AS first_purchase_date, 
        COUNT(DISTINCT i.invoice_id) AS num_orders, 
        SUM(il.unit_price * il.quantity) AS total_spending, 
        DATEDIFF('2020-12-31', MIN(i.invoice_date)) AS customer_tenure_days,
        MAX(i.invoice_date) AS last_purchase_date
    FROM customer c 
    LEFT JOIN invoice i ON c.customer_id = i.customer_id 
    LEFT JOIN invoice_line il ON i.invoice_id = il.invoice_id 
    GROUP BY c.customer_id 
),
customer_purchase_status AS (
    SELECT 
        customer_id,
        CASE 
            WHEN MAX(i.invoice_date) < DATE_SUB('2020-12-31', INTERVAL 6 MONTH) THEN 'Stopped Purchasing'
            ELSE 'Active Customer'
        END AS purchase_status
    FROM invoice i
    GROUP BY customer_id
),
customer_clv_with_status AS (
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        c.first_purchase_date, 
        c.num_orders, 
        c.total_spending, 
        c.customer_tenure_days, 
        c.last_purchase_date, 
        cps.purchase_status
    FROM customer_clv c
    LEFT JOIN customer_purchase_status cps ON c.customer_id = cps.customer_id
)
SELECT 
    CASE 
        WHEN customer_tenure_days < 365 THEN 'New Customer' 
        WHEN customer_tenure_days >= 365 AND customer_tenure_days < 1095 THEN 'Existing Customer' 
        ELSE 'Loyal Customer' 
    END AS customer_segment, 
    COUNT(*) AS num_customers, 
    ROUND(AVG(total_spending), 2) AS avg_spending, 
    ROUND(AVG(num_orders), 2) AS avg_orders,
    SUM(CASE WHEN purchase_status = 'Stopped Purchasing' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(AVG(CASE WHEN purchase_status = 'Stopped Purchasing' THEN total_spending ELSE NULL END), 2) AS avg_spending_churned_customers
FROM customer_clv_with_status
GROUP BY customer_segment
ORDER BY avg_spending DESC;


-- 8.	If data on promotional campaigns is available, how could you measure their impact on customer acquisition, retention, and overall sales?  -- refer word doc

-- 9.	How would you approach this problem, if the objective and subjective questions weren't given? -- refer word doc

-- 10.	How can you alter the "Albums" table to add a new column named "ReleaseYear" of type INTEGER to store the release year of each album? 

ALTER TABLE album ADD COLUMN ReleaseYear INTEGER; 

-- 11. purchasing behaviour of customers

SELECT 
    c.country AS country, 
    COUNT(DISTINCT c.customer_id) AS num_customers, 
    SUM(i.total) AS total_amount_spent, 
    ROUND(AVG(i.total),2) AS avg_amount_spent_per_customer,
    ROUND(AVG(il.track_count),0) AS avg_tracks_purchased_per_customer
FROM 
    customer c
JOIN 
    invoice i ON c.customer_id = i.customer_id
JOIN (
    SELECT 
        invoice_id, 
        COUNT(track_id) AS track_count
    FROM 
        invoice_line
    GROUP BY 
        invoice_id
) il ON i.invoice_id = il.invoice_id
GROUP BY 
    c.country
ORDER BY 
    total_amount_spent DESC;
  
  
  
  
  