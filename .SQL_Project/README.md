# Student Performance Analysis System

A sample SQLite project for exploring student marks, subject performance, and
attendance. The database includes 8 students, 4 subjects, 32 mark records, and
16 attendance records.

## Files

- `student_performance.sql` creates and populates the tables, adds the
  `student_performance` view and indexes, and runs example analysis queries.
- `advanced_queries.sql` contains additional CTE, window-function, aggregate,
  and `CASE` queries.
- `student_performance.db` is a prebuilt SQLite database populated from the
  main script.

## Run the project

From this directory, use the SQLite command-line tool:

```text
sqlite3 student_performance.db
```

To create a fresh database, run the main script:

```text
sqlite3 student_performance.db ".read student_performance.sql"
```

To run the advanced queries against that database:

```text
sqlite3 student_performance.db ".read advanced_queries.sql"
```

The advanced query file expects the tables created by `student_performance.sql`.
The schema uses SQLite features including foreign keys, check constraints,
window functions, and a view.
