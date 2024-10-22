import psycopg2

# Настройте подключение к вашей базе данных
conn = psycopg2.connect("dbname=bazar user=postgres password=123 host=localhost")
cursor = conn.cursor()
