-- Create a schema called 'raw'
CREATE SCHEMA raw;

-- Create the amazon_products table
CREATE TABLE raw.amazon_products (
    asin VARCHAR PRIMARY KEY,
    title TEXT,
    imgUrl TEXT,
    productURL TEXT,
    stars FLOAT,
    reviews INT,
    price DECIMAL,
    listPrice DECIMAL,
    category_id INT,
    isBestSeller BOOLEAN,
    boughtInLastMonth INT,
    load_date DATE
);

-- Create the amazon_categories table
CREATE TABLE raw.amazon_categories (
    id INT PRIMARY KEY,
    category_name TEXT,
    load_date DATE
);