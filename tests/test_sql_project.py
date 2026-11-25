import sqlite3
from pathlib import Path

import pytest


SQL_FILE = Path(__file__).resolve().parents[1] / "student_performance.sql"


@pytest.fixture
def database():
    connection = sqlite3.connect(":memory:")
    connection.executescript(SQL_FILE.read_text(encoding="utf-8"))
    yield connection
    connection.close()


def test_schema_enables_foreign_keys_and_has_no_orphans(database):
    assert database.execute("PRAGMA foreign_keys").fetchone()[0] == 1
    assert database.execute("PRAGMA foreign_key_check").fetchall() == []


def test_attendance_query_returns_only_students_below_75_percent(database):
    rows = database.execute(
        """
        SELECT s.name, ROUND(100.0 * a.classes_attended / a.total_classes, 2)
        FROM attendance AS a
        JOIN students AS s ON s.student_id = a.student_id
        WHERE 1.0 * a.classes_attended / a.total_classes < 0.75
        ORDER BY s.name
        """
    ).fetchall()
    assert len(rows) == 3
    assert {row[0] for row in rows} == {"Karthik", "Manoj"}


def test_marks_constraints_reject_scores_outside_zero_to_one_hundred(database):
    with pytest.raises(sqlite3.IntegrityError):
        database.execute(
            "INSERT INTO marks (student_id, subject_id, semester, marks) VALUES (1, 1, 5, 101)"
        )


def test_performance_view_includes_all_students(database):
    count = database.execute("SELECT COUNT(*) FROM student_performance").fetchone()[0]
    assert count == 8
