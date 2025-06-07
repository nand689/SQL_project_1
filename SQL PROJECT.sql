DROP TABLE IF EXISTS books;
CREATE TABLE books(
     Book_ID INT PRIMARY KEY,
     Title VARCHAR(100),
     Author VARCHAR(100),
     Genre VARCHAR(100),
     Published_Year INT,
     Price NUMERIC(10,2),
     Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
     Customer_ID INT PRIMARY KEY	,
     Name	VARCHAR(100),	
     Email	VARCHAR(100),	
     Phone	INT	,
     City	VARCHAR(50)	,
     Country VARCHAR(150)	
);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
     Order_ID INT PRIMARY KEY,
     Customer_ID INT REFERENCES CUSTOMERS(customer_id),
     Book_ID INT REFERENCES BOOKS(book_id),
     Order_Date	DATE,
     Quantity INT,
     Total_Amount NUMERIC(10,2)
);
SELECT* FROM books;
SELECT* FROM customers;
SELECT* FROM orders;

 -- import data from books, customers and orders  table excel file ---
 
                                                    --- Question ----
   -- 1) retrieve all books in the fiction genre -- 
  SELECT title, genre
  FROM books
  WHERE genre='Fiction';




    -- 2) find books published after the year 1950 --
  SELECT * FROM books
  WHERE published_year>1950;

    -- 3) List all customers from the canada --
SELECT * FROM customers
WHERE country='Canada';

  -- 4) Show orders placed in novemeber 2023 --
  SELECT * FROM orders
  WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

   --5) Retrieve the total stock of books available --
  SELECT SUM(stock) as total_stock
  FROM books;

    --6) find the details of the most expensive book --
	SELECT * FROM books
	ORDER BY price DESC
	LIMIT '1';

	--7) Show all customers who ordered more than 1 quantity of a book --
SELECT * FROM orders
WHERE quantity>1;

  -- 8) Retrieve all orders where the total amount exceeds $20 --
 SELECT * FROM orders
 WHERE total_amount>20;

  -- 9) list all the genres available in the books table --
  SELECT DISTINCT(genre)
  FROM books;

   -- 10) Find the book with the lowest stock --
  SELECT * FROM books
  ORDER BY stock ASC
  LIMIT '1';

  -- 11)Calculate the total revenue generated from all the orders --
  SELECT SUM(total_amount) as total_revenue
  FROM orders;

                         -------- ADVANCE QUERIES ---------
 --1) Retrieve the total no of books sold for each genre.
 SELECT b.Genre, sum(a.quantity) as total_booksold
 FROM orders as a
 JOIN books as b
 on b.book_id=a.book_id
 GROUP BY b.genre;

--2) Find the average price of books in the 'fantasy' genre.
SELECT AVG(price) as avg_price FROM books
WHERE genre='Fantasy';

--3) List customers who have placed at least 2 orders.
SELECT a.name,b.customer_id, COUNT(b.order_id) as order_count
FROM customers as a
join orders as b
on a.customer_id=b.customer_id
GROUP BY a.name,b.customer_id
HAVING COUNT (b.order_id)>=2;

--4) Find the most frequently ordered book. 
SELECT b.book_id, a.title, count(b.book_id) as order_count
FROM orders as b
join books as a
ON b.book_id=a.book_id
GROUP BY b.book_id, a.title
ORDER BY order_count DESC
LIMIT 1;

--5)Show the top 3 most expensive books of 'fantasy' genre.
SELECT * 
FROM books 
WHERE genre='Fantasy'
ORDER BY price DESC
LIMIT 3;

--6)Retrieve the total quantity of books sold by each author.
SELECT a.author, sum(b.quantity) as total_books_sold
FROM books as a
JOIN orders as b
ON a.book_id=b.book_id
GROUP BY a.author;

--7)list the cities where customers who have spent over $30 are located.
SELECT distinct a.city, b.total_amount
FROM customers as a
join orders as b
ON a.customer_id=b.customer_id
WHERE b.total_amount>30; 

--8) Find the customer who has spent most on orders.
SELECT a.name, SUM(b.total_amount) as most_spent_order
FROM customers as a
JOIN orders as b
on a.customer_id=b.customer_id
GROUP BY a.name 
ORDER BY most_spent_order DESC
LIMIT 1;

--9) Calculate the stock remaining after fulfilling all orders.
SELECT a.book_id,a.title, a.stock, COALESCE(SUM(b.quantity),0) as order_quantity,
a.stock-COALESCE(SUM(b.quantity),0) as remaining_quantity
FROM books as a
LEFT join orders as b
on a.book_id=b.book_id
GROUP BY a.book_id
ORDER BY a.book_id;













 
 
 














