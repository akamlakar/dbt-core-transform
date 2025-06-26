# DBT Exercises for Beginners

These exercises are designed to give you hands-on experience with dbt using this project. Complete them in order to reinforce your understanding of key dbt concepts.

## Exercise 1: Basic Model Creation

**Objective:** Create your first dbt model.

1. Create a new file in `models/refined/rfnd_practice.sql`
2. Write a simple SQL query that selects data from the `raw.amazon_products` source
3. Include at least one simple transformation (e.g., convert a string to uppercase)
4. Run your model using `dbt run --select rfnd_practice`
5. Verify your model was created in the database

## Exercise 2: Add Documentation and Tests

**Objective:** Learn to document and test your models.

1. Create a YAML file in `models/refined/rfnd_practice.yml`
2. Add a description for your model and each column
3. Add at least two tests:
   - One built-in test (e.g., not_null, unique)
   - One custom test using SQL
4. Run the tests using `dbt test --select rfnd_practice`

## Exercise 3: Create a Dimensional Model

**Objective:** Build a dimensional model based on your refined model.

1. Create a new file in `models/integrated/dim_practice.sql`
2. Write SQL that references your `rfnd_practice` model using the `ref()` function
3. Include appropriate configurations for materialization and schema
4. Add documentation in a YAML file
5. Run your model and test it

## Exercise 4: Using Macros

**Objective:** Learn to use and create macros.

1. Create a new macro in `macros/format_price.sql` that:
   - Takes a price column as an input
   - Formats it to include a dollar sign and two decimal places
   - Returns the formatted string
2. Use your macro in a new or existing model
3. Run your model to see the results

## Exercise 5: Create a Combined Presentation Model

**Objective:** Create a business-ready view combining multiple dimensions.

1. Create a new file in `models/presentation/Product_Practice.sql`
2. Write SQL that joins data from at least two integrated models
3. Use appropriate aliases to make column names business-friendly
4. Include comments explaining the purpose of joins and transformations
5. Run your model and query it to verify the results

## Exercise 6: Incremental Models

**Objective:** Understand and implement incremental loading.

1. Modify an existing model or create a new one using incremental materialization
2. Add the appropriate incremental filter logic
3. Run the model with `dbt run --select your_model_name`
4. Run it again and observe the behavior
5. Explain how the incremental logic affects processing

## Exercise 7: Package Dependencies

**Objective:** Learn to use dbt packages.

1. Explore the packages already configured in `packages.yml`
2. Find and use a function from dbt_utils in one of your models
3. Run `dbt deps` to install the dependencies
4. Run your model to see the results

## Challenge Exercise: Build Your Own Data Mart

**Objective:** Create a complete data mart for a specific analytical purpose.

1. Identify a business question that could be answered using the Amazon products data
2. Design and implement:
   - Any additional refined models needed
   - Required dimension and fact tables
   - A final presentation layer view
3. Document your models and add appropriate tests
4. Create a markdown file explaining the purpose of your data mart and how to use it
5. Run and test your entire pipeline

## Submission

For each exercise, document:
- The SQL code you wrote
- Any challenges you faced
- The results you observed
- How you verified your solution worked correctly

Happy learning!
