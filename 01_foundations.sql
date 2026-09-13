-- 1.
print('SELECT/WHERE')

conn = sqlite3.connect("bigbasket_capstone.db")
cur = conn.cursor()

cur.execute(" SELECT count(*) from Customers WHERE city = 'Mumbai' ")
print('Total Number of orders in Mumbai:', cur.fetchall())

conn.close()

-- 2. 
print('DISTINCT')

conn = sqlite3.connect("bigbasket_capstone.db")
cur = conn.cursor()

cur.execute(" SELECT DISTINCT category from Products")
for row in cur.fetchall():
  print(row)

conn.close()


-- 3. 
print('ORDER BY + LIMIT')

conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute(''' SELECT amount_inr
                  FROM Orders
                  ORDER BY amount_inr desc
                  LIMIT 5 ''')
print(cur.fetchall())
conn.close()



-- 4. 
print('ALIAS')

conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute(''' SELECT sum(amount_inr) AS TOTAL_REVENUE,
                  order_date AS DATE_OF_HIGHEST_REVENUE
                  FROM Orders
                  GROUP BY order_date
                  ORDER BY amount_inr desc
                  LIMIT 5 ''')
for row in cur.fetchall():
  print(row)

conn.close()



-- 5.
print('IN')

conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute("SELECT DISTINCT customer_id , payment_mode FROM Orders WHERE payment_mode IN ('UPI','Cash on Delivery') LIMIT 20")

for row in cur.fetchall():
  print(row)

conn.close()



-- 6. 
print("BETWEEN")

conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute(' SELECT order_id , amount_inr FROM Orders WHERE amount_inr BETWEEN 500 and 1000 LIMIT 20')
for row in cur.fetchall():
  print(row)

conn.close()


-- 7.
print("NOT BETWEEN")

conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute(' SELECT order_id , amount_inr FROM Orders WHERE amount_inr NOT BETWEEN 50 and 600 LIMIT 20')
for row in cur.fetchall():
  print(row)

conn.close()


-- 8.
print('IS NULL')

conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute(' SELECT status , Rating FROM Orders WHERE rating IS NULL LIMIT 10')

for row in cur.fetchall():
  print(row)

conn.close()
