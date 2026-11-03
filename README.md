# Student Performance Analysis — SQL & SQLite

Relational database project for exploring student marks, subject results, department performance, and attendance using SQLite.

The primary student-analysis setup script in the repository root is `student_performance.sql`. It creates and populates the student schema and runs example analysis queries.

## Schema

- `students`: student identity, department, date of birth, and email
- `subjects`: subject names and credit values
- `marks`: marks by student, subject, and semester
- `attendance`: attended and total classes by student and subject

The SQL defines primary keys, foreign keys, unique constraints, and check constraints.

## SQL concepts demonstrated

- Filtering and sorting with `WHERE`, `ORDER BY`, and `DISTINCT`
- Aggregation with `GROUP BY`, `HAVING`, `AVG`, and `COUNT`
- Joins and subqueries
- Views and indexes
- Window functions and ranking
- Attendance percentage calculations
- Query-plan inspection with `EXPLAIN QUERY PLAN`

The additional `.SQL_Project/advanced_queries.sql` file contains weighted averages, department rankings, performance bands, subject comparisons, and further attendance analysis. Run it after the main student schema has been created.

## Run locally

Install SQLite and ensure the `sqlite3` command is available.

Clone the repository:

```bash
git clone https://github.com/kirubanandhan016/student-performance-analysis-sql.git
cd student-performance-analysis-sql
```

Create a fresh database and open the SQLite shell:

```bash
sqlite3 student_performance.db
```

Run the root-level student schema and analysis script:

```sql
.read student_performance.sql
```

Optionally run the additional advanced queries:

```sql
.read .SQL_Project/advanced_queries.sql
```

Inspect the schema with `.tables` and `.schema`, then exit with `.quit`.

## Repository layout notes

- `student_performance.sql` is the root-level entry point for the student performance database.
- `.SQL_Project/student_performance.sql` is a second copy of the student setup script, and `.SQL_Project/README.md` documents that subfolder's standalone usage.
- `.SQL_Project/advanced_queries.sql` contains supplementary queries.
- The root-level `project.sql` currently contains an e-commerce schema, not the student-performance schema. Do not run it when creating the student performance database.

Use a fresh database file when re-running a setup script that inserts fixed sample IDs. The scripts are educational examples and are not guaranteed to be idempotent.

## Suggested verification

- Apply the root script to a fresh SQLite database.
- Confirm the four tables are present.
- Check foreign-key enforcement and representative aggregate results.
- Run the additional advanced query file after setup.
- Use `EXPLAIN QUERY PLAN` to inspect the query-plan example.

## Relevance to backend development

This project demonstrates relational schema design, integrity constraints, joins, aggregation, indexes, and analytical queries that complement the database layer of a backend API.

## Author

**Kirubanandhan V**

- GitHub: [@kirubanandhan016](https://github.com/kirubanandhan016)
- Portfolio: [kirubanandhan016.github.io](https://kirubanandhan016.github.io/)
- LinkedIn: [Kirubanandhan V](https://www.linkedin.com/in/kirubanandhan-v-98bb83443/)
