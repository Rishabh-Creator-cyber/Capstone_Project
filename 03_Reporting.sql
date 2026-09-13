
--(A)
conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute('''SELECT product_name ,
                  amount_inr,
                  CASE
                        WHEN amount_inr >= 3000 then 'High'
                        WHEN amount_inr >= 1000 then 'Medium'
                        ELSE 'Low'
                 END
                 FROM orders as o INNER JOIN Products as p on o.product_id = p.product_id
                 WHERE o.status = 'Delivered'
                 GROUP BY product_name
                 ''')
for row in cur.fetchall():
  print(row)

conn.close()

--(B)
conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute('''SELECT category,
                  strftime('%Y-%m',order_date) AS month,
                  count(order_id) AS ORDER_COUNT,
                  SUM(amount_inr) AS TOTAL_REVENUE,
                  AVG(amount_inr) AS AVG_REVENUE
                 FROM orders as o INNER JOIN Products as p on o.product_id = p.product_id
                 WHERE o.status = 'Delivered'
                 GROUP BY category , month
                 ORDER BY category , month
                 ''')
for row in cur.fetchall():
  print(row)

conn.close()

--(C)
conn = sqlite3.connect('bigbasket_capstone.db')
cur = conn.cursor()

cur.execute("""
    SELECT
        c.category,
        c.target_revenue_inr,
        SUM(r.TOTAL_REVENUE) AS total_revenue,
        (c.target_revenue_inr - SUM(r.TOTAL_REVENUE)) AS Variance,
        ((SUM(r.TOTAL_REVENUE) - c.target_revenue_inr) * 100.0) / c.target_revenue_inr AS percentage_variance,
        CASE
            WHEN SUM(r.TOTAL_REVENUE) >= c.target_revenue_inr
                THEN 'Above Target'
            WHEN ((c.target_revenue_inr - SUM(r.TOTAL_REVENUE)) * 100.0) / c.target_revenue_inr <= 15.0
                THEN 'Below Target - Watch'
            ELSE 'Below Target - Critical'
        END AS status_tag
    FROM category_targets c
    INNER JOIN (
        SELECT
            p.category,
            strftime('%Y-%m', o.order_date) AS month,
            COUNT(o.order_id) AS ORDER_COUNT,
            SUM(o.amount_inr) AS TOTAL_REVENUE,
            AVG(o.amount_inr) AS AVG_REVENUE
        FROM orders AS o
        INNER JOIN Products AS p ON o.product_id = p.product_id
        WHERE o.status = 'Delivered'
        GROUP BY p.category, month
    ) r ON c.category = r.category
    GROUP BY c.category, c.target_revenue_inr
""")

for row in cur.fetchall():
    print(row)

conn.close()

