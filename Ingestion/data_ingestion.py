import csv
import psycopg2

# Database connection parameters
DB_PARAMS = {
    'dbname': 'poc_db',
    'user': 'user',
    'password': 'password',
    'host': 'localhost',
    'port': 5432
}

def load_csv_to_db(filename, table_name, conn):
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        columns = next(reader) 
        cursor = conn.cursor()
        for row in reader:
            # Define insert_query inside the loop, after row is defined
            insert_query = f"""
                INSERT INTO raw.{table_name} 
                ({','.join(columns)}, load_date) 
                VALUES ({','.join(['%s' for _ in row])}, CURRENT_DATE)
            """
            cursor.execute(insert_query, row)
        conn.commit()
        cursor.close()

if __name__ == "__main__":
    conn = psycopg2.connect(**DB_PARAMS)
    load_csv_to_db('../data/amazon_products.csv', 'amazon_products', conn)
    load_csv_to_db('../data/amazon_categories.csv', 'amazon_categories', conn)
    conn.close()
