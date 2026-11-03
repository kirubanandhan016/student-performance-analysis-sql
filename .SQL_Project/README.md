# Student Performance Analysis System

SQLite project for exploring student marks, subject performance, and attendance.

## Files

- `student_performance.sql` creates and populates the student tables, adds the `student_performance` view and indexes, and runs example analysis queries.
- `advanced_queries.sql` contains additional CTE, window-function, aggregate, and `CASE` queries.

There is no prebuilt database file in this directory. Create one locally by running the setup script.

## Run the project

From this directory, create a new SQLite database:

```bash
sqlite3 student_performance.db
```

Inside the SQLite prompt, run the setup script:

```sql
.read student_performance.sql
```

Run additional queries after the main schema has been created:

```sql
.read advanced_queries.sql
```

Inspect tables and schema:

```sql
.tables
.schema
```

Exit with `.quit`.

## Notes

- The advanced query file expects the tables created by `student_performance.sql`.
- The schema uses SQLite foreign keys, check constraints, window functions, and a view.
- The setup script inserts fixed sample IDs. Use a fresh database file when running it again to avoid duplicate-key conflicts.
