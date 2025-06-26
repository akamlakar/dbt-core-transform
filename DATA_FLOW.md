# Data Flow Architecture

This document explains the data transformation flow in this dbt project.

## Conceptual Data Flow

```
┌───────────────┐     ┌───────────────┐     ┌───────────────┐     ┌───────────────┐
│               │     │               │     │               │     │               │
│  Raw Data     │────▶│  Refined      │────▶│  Integrated   │────▶│  Presentation │
│  (Sources)    │     │  Models       │     │  Models       │     │  Models       │
│               │     │               │     │               │     │               │
└───────────────┘     └───────────────┘     └───────────────┘     └───────────────┘
      │                      │                     │                     │
      ▼                      ▼                     ▼                     ▼
┌───────────────┐     ┌───────────────┐     ┌───────────────┐     ┌───────────────┐
│ Raw Tables in │     │ Basic         │     │ Dimensional   │     │ Business      │
│ Database      │     │ Transformations│     │ Models       │     │ Logic Views   │
│               │     │               │     │               │     │               │
└───────────────┘     └───────────────┘     └───────────────┘     └───────────────┘
```

## Detailed Layer Description

### 1. Raw Data (Sources)
- Location: Defined in `models/sources/sources.yml`
- Purpose: References to raw tables in the database
- Examples: `raw.amazon_products`, `raw.amazon_categories`
- Key Concept: Source references using `{{ source('raw', 'amazon_products') }}`

### 2. Refined Layer
- Location: `models/refined/` directory
- Purpose: 
  - Initial data cleaning and standardization
  - Basic type conversions and null handling
  - No business logic or aggregations
- Materialization: Typically tables, often incremental
- Examples: `rfnd_amazon_products`, `rfnd_amazon_categories`

### 3. Integrated Layer
- Location: `models/integrated/` directory
- Purpose:
  - Implement dimensional modeling patterns
  - Create dimension and fact tables
  - Enforce relationships between entities
- Materialization: Typically tables
- Examples: `dim_product_base`, `dim_category`, `fact_sales`

### 4. Presentation Layer
- Location: `models/presentation/` directory
- Purpose:
  - Combine multiple dimensions and facts
  - Implement business logic
  - Create business-user-friendly views
- Materialization: Typically views
- Examples: `Products`, `Product Categories`, `Product Sales`

## Data Flow Example

Let's follow a specific example of how data transforms through the layers:

1. **Raw Data**: `raw.amazon_products` table contains raw product data from Amazon
   
2. **Refined**: `rfnd_amazon_products` 
   - Cleans and standardizes raw data
   - Handles data type conversions
   - Manages incremental loading logic

3. **Integrated**: `dim_product_base`, `dim_product_reviews`, `dim_product_sales_info`
   - Split product attributes into logical dimensions
   - Reference the refined layer using `{{ ref('rfnd_amazon_products') }}`
   - Apply constraints and tests

4. **Presentation**: `Products` 
   - Joins dimension tables into a unified view
   - Formats and renames fields for business users
   - References integrated models: `{{ ref('dim_product_base') }}`, `{{ ref('dim_product_reviews') }}`, etc.

This layered approach provides:
- Clear separation of concerns
- Improved maintainability
- Better performance through appropriate materializations
- Easier debugging and testing
