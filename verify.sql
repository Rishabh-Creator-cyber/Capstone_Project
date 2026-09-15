
#Verifing the generated data

conn = sqlite3.connect("bigbasket_capstone.db")
cur = conn.cursor()

cur.execute("SELECT COUNT(*) FROM Products")
print(cur.fetchone())

conn.close()



conn = sqlite3.connect("bigbasket_capstone.db")
cur = conn.cursor()

cur.execute("SELECT COUNT(*) FROM Customers")
print(cur.fetchone())

conn.close()



conn = sqlite3.connect("bigbasket_capstone.db")
cur = conn.cursor()

cur.execute("SELECT COUNT(*) FROM Orders")
print(cur.fetchone())

conn.close()



conn = sqlite3.connect("bigbasket_capstone.db")
cur = conn.cursor()

cur.execute("SELECT COUNT(*) FROM category_targets")
print(cur.fetchone())

conn.close()
