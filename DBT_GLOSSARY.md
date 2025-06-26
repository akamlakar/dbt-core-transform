# DBT Glossary

This glossary explains key dbt terms and concepts used throughout this project.

## Core Concepts

### dbt (data build tool)
An open-source command-line tool that enables data analysts and engineers to transform data in their warehouses using SQL.

### Model
A SQL file that selects from existing tables/views to create a new table or view. Models are defined in `.sql` files within the `models` directory.

### Materialization
Determines how dbt builds models in the data warehouse:
- **Table**: Built as a physical table with each dbt run
- **View**: Built as a database view
- **Incremental**: Updates an existing table with new or changed records only
- **Ephemeral**: Not directly built in the database but included as CTE in dependent models

### Source
A reference to raw tables in your database that serve as inputs to your models. Sources are defined in YAML files.

### Ref
A dbt function (`ref()`) that creates dependencies between models, allowing proper sequencing during execution.

### Seed
CSV files in your dbt project that dbt loads into your data warehouse. Useful for static reference data.

### Snapshot
A table that records changes to a source table over time, implementing slowly changing dimensions.

### Macro
A reusable piece of SQL code, similar to a function in other programming languages.

### Test
A SQL query that returns failing records. Tests help validate assumptions about your data.

### Documentation
Descriptions of models, columns, and other objects in your dbt project, making it easier for others to understand.

## Project Structure Terms

### Refined Layer
Initial transformation layer that cleans and prepares data from source tables, with minimal business logic.

### Integrated Layer
Dimensional modeling layer that creates conformed dimensions and facts from refined data.

### Presentation Layer
Business-facing layer that organizes data for specific analytical use cases.

## dbt Commands

### dbt run
Executes the SQL in model files against your database.

### dbt test
Runs tests against your models to validate data quality.

### dbt compile
Generates executable SQL from your model files without running them.

### dbt docs generate/serve
Creates and serves documentation for your dbt project.

### dbt deps
Installs dependencies from the `packages.yml` file.

## Advanced Concepts

### Jinja
A templating language that dbt uses to enable programming constructs in your SQL code.

### Hook
SQL statements that execute at predefined times during the dbt run process.

### Package
Reusable dbt projects that can be imported into your own project.

### Selector
A method to specify which models to run or test using pattern matching.

### Custom Schema
A way to organize models in different database schemas, controlled through macros.
