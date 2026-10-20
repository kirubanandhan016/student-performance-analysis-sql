
PRAGMA foreign_keys = ON;

-- ==========================================
-- STUDENT PERFORMANCE ANALYSIS SYSTEM
-- Database: SQLite
-- ==========================================

-- 1. CREATE TABLES

CREATE TABLE students (
    student_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    department TEXT NOT NULL,
    date_of_birth TEXT,
    email TEXT UNIQUE
);

CREATE TABLE subjects (
    subject_id INTEGER PRIMARY KEY,
    subject_name TEXT NOT NULL,
    credits INTEGER NOT NULL CHECK (credits > 0)
);

CREATE TABLE marks (
    mark_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    semester INTEGER NOT NULL CHECK (semester BETWEEN 1 AND 8),
    marks REAL NOT NULL CHECK (marks BETWEEN 0 AND 100),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id),

    UNIQUE (student_id, subject_id, semester)
);

CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY,
    student_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    classes_attended INTEGER NOT NULL DEFAULT 0,
    total_classes INTEGER NOT NULL CHECK (total_classes > 0),

    CHECK (
        classes_attended BETWEEN 0 AND total_classes
    ),

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (subject_id)
        REFERENCES subjects(subject_id),

    UNIQUE (student_id, subject_id)
);

-- 2. INSERT STUDENTS

INSERT INTO students VALUES
(1, 'Arun', 'ECE', '2004-05-12', 'arun@example.com'),
(2, 'Priya', 'CSE', '2003-08-21', 'priya@example.com'),
(3, 'Karthik', 'ECE', '2004-02-15', 'karthik@example.com'),
(4, 'Divya', 'IT', '2003-11-10', 'divya@example.com'),
(5, 'Manoj', 'CSE', '2004-01-05', 'manoj@example.com'),
(6, 'Meena', 'IT', '2003-07-18', 'meena@example.com'),
(7, 'Rahul', 'ECE', '2004-09-20', 'rahul@example.com'),
(8, 'Sneha', 'CSE', '2003-03-14', 'sneha@example.com');

-- 3. INSERT SUBJECTS

INSERT INTO subjects VALUES
(1, 'Database Management', 4),
(2, 'Computer Networks', 3),
(3, 'Operating Systems', 4),
(4, 'Programming', 4);

-- 4. INSERT MARKS

INSERT INTO marks VALUES
(1,1,1,4,85),
(2,1,2,4,78),
(3,1,3,4,82),
(4,1,4,4,90),
(5,2,1,4,95),
(6,2,2,4,88),
(7,2,3,4,92),
(8,2,4,4,96),
(9,3,1,4,72),
(10,3,2,4,68),
(11,3,3,4,75),
(12,3,4,4,80),
(13,4,1,4,88),
(14,4,2,4,91),
(15,4,3,4,85),
(16,4,4,4,89),
(17,5,1,4,65),
(18,5,2,4,70),
(19,5,3,4,62),
(20,5,4,4,74),
(21,6,1,4,92),
(22,6,2,4,86),
(23,6,3,4,90),
(24,6,4,4,94),
(25,7,1,4,79),
(26,7,2,4,83),
(27,7,3,4,77),
(28,7,4,4,81),
(29,8,1,4,89),
(30,8,2,4,94),
(31,8,3,4,91),
(32,8,4,4,93);

-- 5. INSERT ATTENDANCE

INSERT INTO attendance VALUES
(1,1,1,42,45),
(2,1,2,35,45),
(3,2,1,44,45),
(4,2,2,40,45),
(5,3,1,30,45),
(6,3,2,32,45),
(7,4,1,38,45),
(8,4,2,40,45),
(9,5,1,28,45),
(10,5,2,34,45),
(11,6,1,43,45),
(12,6,2,44,45),
(13,7,1,36,45),
(14,7,2,38,45),
(15,8,1,45,45),
(16,8,2,43,45);

-- ==========================================
-- 6. SQL ANALYSIS QUERIES
-- ==========================================

-- Display all students
SELECT * FROM students;

-- Display the top 5 students by average marks
SELECT
    s.student_id,
    s.name,
    s.department,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM students AS s
JOIN marks AS m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.name, s.department
ORDER BY average_marks DESC
LIMIT 5;

-- Department-wise performance
SELECT
    s.department,
    COUNT(DISTINCT s.student_id) AS student_count,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM students AS s
JOIN marks AS m
    ON s.student_id = m.student_id
GROUP BY s.department
ORDER BY average_marks DESC;

-- Students with average marks above 80
SELECT
    s.name,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM students AS s
JOIN marks AS m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.name
HAVING AVG(m.marks) > 80
ORDER BY average_marks DESC;

-- Subject-wise highest marks
SELECT
    sub.subject_name,
    MAX(m.marks) AS highest_marks
FROM subjects AS sub
JOIN marks AS m
    ON sub.subject_id = m.subject_id
GROUP BY sub.subject_id, sub.subject_name;

-- Students with attendance below 75%
SELECT
    s.name,
    sub.subject_name,
    ROUND(
        100.0 * a.classes_attended / a.total_classes,
        2
    ) AS attendance_percentage
FROM attendance AS a
JOIN students AS s
    ON a.student_id = s.student_id
JOIN subjects AS sub
    ON a.subject_id = sub.subject_id
WHERE 1.0 * a.classes_attended / a.total_classes < 0.75;

-- Student marks report
SELECT
    s.name,
    sub.subject_name,
    m.semester,
    m.marks
FROM marks AS m
JOIN students AS s
    ON m.student_id = s.student_id
JOIN subjects AS sub
    ON m.subject_id = sub.subject_id
ORDER BY s.name, m.marks DESC;

-- Students above the overall average
SELECT
    s.name,
    ROUND(AVG(m.marks), 2) AS average_marks
FROM students AS s
JOIN marks AS m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.name
HAVING AVG(m.marks) > (
    SELECT AVG(marks) FROM marks
)
ORDER BY average_marks DESC;

-- ==========================================
-- 7. CREATE PERFORMANCE VIEW
-- ==========================================

CREATE VIEW student_performance AS
SELECT
    s.student_id,
    s.name,
    s.department,
    ROUND(AVG(m.marks), 2) AS average_marks,
    COUNT(m.mark_id) AS subjects_completed
FROM students AS s
LEFT JOIN marks AS m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.name, s.department;

-- Display performance view
SELECT *
FROM student_performance
ORDER BY average_marks DESC;

-- ==========================================
-- 8. RANK STUDENTS
-- ==========================================

SELECT
    student_id,
    name,
    department,
    average_marks,
    RANK() OVER (
        ORDER BY average_marks DESC
    ) AS performance_rank
FROM student_performance;

-- ==========================================
-- 9. CREATE INDEXES
-- ==========================================

CREATE INDEX idx_students_department
ON students(department);

CREATE INDEX idx_marks_student
ON marks(student_id);

CREATE INDEX idx_marks_subject
ON marks(subject_id);

CREATE INDEX idx_attendance_student
ON attendance(student_id);

-- ==========================================
-- 10. DATABASE VERIFICATION
-- ==========================================

SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(*) AS total_subjects FROM subjects;
SELECT COUNT(*) AS total_mark_records FROM marks;
SELECT COUNT(*) AS total_attendance_records FROM attendance;

-- Inspect query execution plan
EXPLAIN QUERY PLAN
SELECT *
FROM marks
WHERE student_id = 1;
