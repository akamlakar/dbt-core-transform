# DBT Learning Path

This guide provides a structured learning path for beginners to understand and work with this dbt project.

## Prerequisites

Before starting:
- Basic SQL knowledge
- Basic understanding of data warehousing concepts
- Docker installed on your machine

## Learning Path

### Step 1: Understanding the Project Structure

Start by exploring the project structure to get familiar with how a dbt project is organized:
- Review the `README.md` file for an overview
- Examine the `dbt_project.yml` configuration
- Look at the directory structure to understand how files are organized

### Step 2: Setting Up Your Environment

Follow these steps to set up your development environment:
1. Clone this repository
2. Create a Python virtual environment and install dependencies
3. Start the PostgreSQL database using Docker
4. Configure your dbt profile

### Step 3: Understanding Data Sources

Explore the raw data structure:
- Check the `data` directory to understand the raw data files
- Review the `Ingestion` directory to see how data is loaded into the database
- Examine the `models/sources/sources.yml` file to see how dbt connects to raw data

### Step 4: Exploring the Transformation Layers

The project follows a layered approach to transformations:

1. **Refined Layer**: 
   - Look at `models/refined/*.sql` files
   - These models perform initial cleaning and basic transformations
   - Key concepts: incremental models, source references

2. **Integrated Layer**:
   - Explore `models/integrated/*.sql` files
   - These create dimensional models from refined data
   - Key concepts: dimensional modeling, tags, testing

3. **Presentation Layer**:
   - Examine `models/presentation/*.sql` files
   - These provide business-friendly views combining multiple dimensions
   - Key concepts: join strategies, aliases

### Step 5: Understanding Testing and Documentation

Learn how dbt ensures data quality and documents models:
- Review the `.yml` files alongside SQL models to see how tests are defined
- Run `dbt test` to verify your models
- Generate and view documentation with `dbt docs generate` and `dbt docs serve`

### Step 6: Hands-on Exercises

Try these hands-on exercises to reinforce your learning:
1. Add a new column to an existing model
2. Create a new test for a model
3. Build a new presentation layer model
4. Add documentation for a model you created

### Step 7: Advanced Concepts

Once comfortable with the basics, explore these advanced concepts:
- Macros (check the `macros` directory)
- Seeds (examine the `seeds` directory)
- Snapshots for slowly changing dimensions
- Custom schema generation

## Recommended Resources

- [dbt Documentation](https://docs.getdbt.com/)
- [dbt Learn Tutorials](https://courses.getdbt.com/collections)
- [dbt Discourse Community](https://discourse.getdbt.com/)
- [dbt Slack Community](https://community.getdbt.com/)
