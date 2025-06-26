import csv
import psycopg2
import os
import time
from datetime import datetime

# Database connection parameters
DB_PARAMS = {
    'dbname': 'poc_db',
    'user': 'user',
    'password': 'password',
    'host': 'localhost',
    'port': 5432
}

def load_csv_to_db(filename, table_name, conn):
    print(f"\nStarting ingestion of {os.path.basename(filename)} into {table_name} table...")
    
    # First pass: count total rows for progress tracking
    total_rows = sum(1 for _ in open(filename)) - 1  # Subtract 1 for header
    print(f"Total rows to process: {total_rows}")
    
    # Progress tracking variables
    processed = 0
    start_time = time.time()
    progress_interval = max(1, min(1000, total_rows // 20))  # Show progress ~20 times
    
    with open(filename, 'r') as f:
        reader = csv.reader(f)
        columns = next(reader)  # Read header
        cursor = conn.cursor()
        
        # Process each row with progress updates
        for row in reader:
            # Define insert_query inside the loop, after row is defined
            insert_query = f"""
                INSERT INTO raw.{table_name} 
                ({','.join(columns)}, load_date) 
                VALUES ({','.join(['%s' for _ in row])}, CURRENT_DATE)
            """
            cursor.execute(insert_query, row)
            
            # Update progress
            processed += 1
            if processed % progress_interval == 0 or processed == total_rows:
                elapsed = time.time() - start_time
                percent = (processed / total_rows) * 100
                est_total = (elapsed / processed) * total_rows if processed > 0 else 0
                remaining = est_total - elapsed
                
                # Create progress bar
                bar_length = 30
                filled_length = int(bar_length * processed // total_rows)
                bar = '█' * filled_length + '░' * (bar_length - filled_length)
                
                print(f"\r[{bar}] {percent:.1f}% ({processed}/{total_rows}) | "
                      f"Elapsed: {elapsed:.1f}s | Remaining: {remaining:.1f}s", end='')
                
        # Commit changes and close cursor
        conn.commit()
        cursor.close()
        
        # Final status
        total_time = time.time() - start_time
        print(f"\n\nCompleted ingestion of {os.path.basename(filename)} into {table_name}")
        print(f"Processed {processed} rows in {total_time:.2f} seconds")
        print(f"Average: {processed/total_time:.2f} rows/second")

if __name__ == "__main__":
    print(f"=== DBT Learning Project Data Ingestion ===")
    print(f"Started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    try:
        # Connect to database
        print("Connecting to PostgreSQL database...")
        conn = psycopg2.connect(**DB_PARAMS)
        print("Connection established successfully")
        
        # Load data files
        load_csv_to_db('../data/amazon_products.csv', 'amazon_products', conn)
        load_csv_to_db('../data/amazon_categories.csv', 'amazon_categories', conn)
        
        # Close connection
        conn.close()
        print(f"\nIngestion completed successfully at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        
    except Exception as e:
        print(f"\nERROR: {str(e)}")
        print("Ingestion failed.")
