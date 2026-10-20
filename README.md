# 🎓 Student Performance Analysis System

### SQL • SQLite • Data Analysis • Database Management

A SQL-based academic analytics project designed to manage student records, analyze examination results, evaluate attendance, and generate performance reports using SQLite.

![SQL](https://img.shields.io/badge/SQL-Advanced-blue?style=for-the-badge)
![SQLite](https://img.shields.io/badge/Database-SQLite-003B57?style=for-the-badge&logo=sqlite)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)

## 📌 Project Overview

The Student Performance Analysis System demonstrates how relational databases and SQL queries can be used to extract meaningful insights from academic data.

The project focuses on database design, data integrity, analytical queries, performance ranking, and attendance monitoring.

## ✨ Key Features

- 👨‍🎓 Student and subject management
- 📊 Student performance and average marks analysis
- 🏆 Top-performing student rankings
- 🏢 Department-wise academic reports
- 📚 Subject-wise marks analysis
- 📅 Attendance percentage monitoring
- 🔍 Subqueries, CTEs, and window functions
- ⚡ Database indexing and query-plan analysis
- 👁️ Reusable SQL views
- 🔐 Primary keys, foreign keys, and data validation

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| SQL | Data querying and analysis |
| SQLite | Relational database |
| Git | Version control |
| GitHub | Project hosting |

## 🗂️ Database Schema

The project contains four relational tables:

- `students` — student details and department
- `subjects` — subject information and credits
- `marks` — marks by student, subject, and semester
- `attendance` — classes attended and total classes

## 🧠 SQL Concepts Demonstrated

**Fundamentals:** SELECT, WHERE, ORDER BY, DISTINCT, LIKE, BETWEEN

**Intermediate:** JOINs, GROUP BY, HAVING, aggregate functions, CASE

**Advanced:** Subqueries, CTEs, RANK, DENSE_RANK, ROW_NUMBER, LAG

**Database engineering:** Constraints, views, indexes, foreign keys, EXPLAIN QUERY PLAN

## 📈 Sample Business Questions

- Who are the top five students by average marks?
- Which department has the highest average performance?
- Which subjects have the highest and lowest marks?
- Which students have attendance below 75%?
- Which students perform above their department average?
- How can query execution be optimized using indexes?

## 🚀 How to Run

1. Install SQLite.
2. Clone this repository:

   ```bash
   git clone https://github.com/kirubanandhan016/student-performance-analysis-sql.git
   ```

3. Navigate to the project directory:

   ```bash
   cd student-performance-analysis-sql
   ```

4. Open SQLite and execute the setup script:

   ```bash
   sqlite3 student_performance.db
   ```

   ```sql
   .read student_performance.sql
   ```

5. Run individual analysis queries and inspect the results.

**Note:** Execute the setup script only once on a fresh database. If your repository uses a separate `advanced_queries.sql` file, execute it after the setup script.

## 📁 Project Structure

```text
student-performance-analysis-sql/
├── student_performance.sql
├── advanced_queries.sql
├── README.md
└── .gitignore
```

## 🎯 Learning Outcomes

- Designed a normalized relational database.
- Practiced SQL from basic retrieval to advanced analytics.
- Generated actionable reports using aggregation and window functions.
- Applied database constraints and indexing techniques.
- Practiced query analysis and version control.

## 👨‍💻 Author

**Kirubanandhan V**

GitHub: [@kirubanandhan016](https://github.com/kirubanandhan016)

---

⭐ If you find this project useful, consider starring the repository.

*Built to demonstrate practical SQL and database analysis skills.*
