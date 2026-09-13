
--(A)
conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute('''SELECT category ,
                  count(order_id) AS TOTAL_ORDERS,
                  sum(amount_inr) AS TOTAL_REVENUE ,
                  AVG(amount_inr) AS AVG_REVENUE
                 FROM orders as o INNER JOIN Products as p on o.product_id = p.product_id
                 WHERE o.status = 'Delivered'
                 GROUP BY category
                 HAVING TOTAL_REVENUE > 10000 ''')
for row in cur.fetchall():
  print(row)

conn.close()

--(B)
conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute('''SELECT p.product_name ,
                  count(o.order_id) AS TOTAL_ORDERS
                 FROM products as p LEFT JOIN orders as o on p.product_id = o.product_id
                 GROUP BY p.product_name
''')
for row in cur.fetchall():
  print(row)

conn.close()
