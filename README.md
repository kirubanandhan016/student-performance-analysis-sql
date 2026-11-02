# Student Performance Analysis — SQL & SQLite

A relational database project for exploring student marks, subject results, department-level performance, and attendance using SQL. It demonstrates database querying and reporting skills relevant to backend development and data-driven applications.

## Project scope

The documented schema covers:
- `students` — student and department information
- `subjects` — subject details and credits
- `marks` — marks by student, subject, and semester
- `attendance` — classes attended and total classes

Confirm table and script names against the repository if you change the schema.

## SQL concepts

- Filtering and sorting: `WHERE`, `ORDER BY`, `DISTINCT`
- Aggregation: `GROUP BY`, `HAVING`, `AVG`, `COUNT`
- Relational queries: joins and subqueries
- Analytical SQL: CTEs and window functions such as `RANK`, `DENSE_RANK`, `ROW_NUMBER`, and `LAG`
- Data integrity: primary keys, foreign keys, and constraints
- Database objects and performance: views, indexes, and SQLite query plans

## Questions the database can answer

- Who are the top students by average marks?
- Which department has the highest average performance?
- Which subjects have the highest or lowest marks?
- Which students fall below a chosen attendance threshold?
- Which students perform above their department average?
- How does an index affect a query plan?

## Run locally

Install SQLite and ensure the `sqlite3` command is available.

```bash
git clone https://github.com/kirubanandhan016/student-performance-analysis-sql.git
cd student-performance-analysis-sql
sqlite3 student_performance.db
```

Inside the SQLite prompt, run the setup script if the file exists under that name:

```sql
.read student_performance.sql
```

Then execute the analysis queries from the SQL files in the repository. Use a fresh database file when re-running a setup script that inserts fixed sample IDs, unless the script is designed to be idempotent.

## Suggested verification

- Run setup against a fresh database.
- Check foreign-key constraints and representative query results.
- Use `EXPLAIN QUERY PLAN` for queries discussed as optimization examples.
- Record actual output samples in the README after validating them.

## Relevance to backend development

This project supports backend work by demonstrating relational schema concepts, joins, aggregation, constraints, and query analysis. It complements the FastAPI projects in my portfolio.

## Project status

Educational SQL project. The repository's SQL scripts are the source of truth; verify filenames and execute the queries locally before relying on specific results.

## Author

**Kirubanandhan V** · [GitHub](https://github.com/kirubanandhan016) · [Portfolio](https://kirubanandhan016.github.io/) · [LinkedIn](https://www.linkedin.com/in/kirubanandhan-v-98bb83443/)
