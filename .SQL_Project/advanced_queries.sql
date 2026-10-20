-- Advanced SQLite queries for the Student Performance Analysis System.
-- Run this file after student_performance.sql has been applied.

-- 1. Weighted average by student, using subject credits.
SELECT
    s.student_id,
    s.name,
    ROUND(SUM(m.marks * sub.credits) / SUM(sub.credits), 2) AS weighted_average
FROM students AS s
JOIN marks AS m
    ON m.student_id = s.student_id
JOIN subjects AS sub
    ON sub.subject_id = m.subject_id
GROUP BY s.student_id, s.name
ORDER BY weighted_average DESC, s.name;

-- 2. Rank students within each department.
WITH student_averages AS (
    SELECT
        s.student_id,
        s.name,
        s.department,
        AVG(m.marks) AS average_marks
    FROM students AS s
    JOIN marks AS m
        ON m.student_id = s.student_id
    GROUP BY s.student_id, s.name, s.department
)
SELECT
    student_id,
    name,
    department,
    ROUND(average_marks, 2) AS average_marks,
    RANK() OVER (
        PARTITION BY department
        ORDER BY average_marks DESC
    ) AS department_rank
FROM student_averages
ORDER BY department, department_rank, name;

-- 3. Find each department's highest-performing student(s), including ties.
WITH student_averages AS (
    SELECT
        s.student_id,
        s.name,
        s.department,
        AVG(m.marks) AS average_marks
    FROM students AS s
    JOIN marks AS m
        ON m.student_id = s.student_id
    GROUP BY s.student_id, s.name, s.department
),
ranked_students AS (
    SELECT
        student_id,
        name,
        department,
        average_marks,
        DENSE_RANK() OVER (
            PARTITION BY department
            ORDER BY average_marks DESC
        ) AS department_rank
    FROM student_averages
)
SELECT
    student_id,
    name,
    department,
    ROUND(average_marks, 2) AS average_marks
FROM ranked_students
WHERE department_rank = 1
ORDER BY department, name;

-- 4. Compare every subject's average with the overall average.
WITH subject_averages AS (
    SELECT
        sub.subject_id,
        sub.subject_name,
        AVG(m.marks) AS average_marks
    FROM subjects AS sub
    JOIN marks AS m
        ON m.subject_id = sub.subject_id
    GROUP BY sub.subject_id, sub.subject_name
)
SELECT
    subject_name,
    ROUND(average_marks, 2) AS subject_average,
    ROUND((SELECT AVG(marks) FROM marks), 2) AS overall_average,
    ROUND(
        average_marks - (SELECT AVG(marks) FROM marks),
        2
    ) AS difference_from_overall
FROM subject_averages
ORDER BY difference_from_overall DESC, subject_name;

-- 5. Assign a performance band to each student.
WITH student_averages AS (
    SELECT
        s.student_id,
        s.name,
        s.department,
        AVG(m.marks) AS average_marks
    FROM students AS s
    LEFT JOIN marks AS m
        ON m.student_id = s.student_id
    GROUP BY s.student_id, s.name, s.department
)
SELECT
    student_id,
    name,
    department,
    ROUND(average_marks, 2) AS average_marks,
    CASE
        WHEN average_marks >= 90 THEN 'Excellent'
        WHEN average_marks >= 80 THEN 'Very Good'
        WHEN average_marks >= 70 THEN 'Good'
        WHEN average_marks >= 60 THEN 'Needs Improvement'
        WHEN average_marks IS NULL THEN 'No marks recorded'
        ELSE 'At Risk'
    END AS performance_band
FROM student_averages
ORDER BY average_marks DESC, name;

-- 6. Calculate attendance percentages and flag students below 75%.
SELECT
    s.student_id,
    s.name,
    sub.subject_name,
    a.classes_attended,
    a.total_classes,
    ROUND(100.0 * a.classes_attended / a.total_classes, 2) AS attendance_percentage,
    CASE
        WHEN 1.0 * a.classes_attended / a.total_classes < 0.75 THEN 'Below 75%'
        ELSE 'At least 75%'
    END AS attendance_status
FROM attendance AS a
JOIN students AS s
    ON s.student_id = a.student_id
JOIN subjects AS sub
    ON sub.subject_id = a.subject_id
ORDER BY attendance_percentage, s.name, sub.subject_name;

-- 7. Show each student's strongest and weakest subjects.
WITH subject_results AS (
    SELECT
        s.student_id,
        s.name,
        sub.subject_name,
        m.marks,
        MAX(m.marks) OVER (PARTITION BY s.student_id) AS highest_mark,
        MIN(m.marks) OVER (PARTITION BY s.student_id) AS lowest_mark
    FROM students AS s
    JOIN marks AS m
        ON m.student_id = s.student_id
    JOIN subjects AS sub
        ON sub.subject_id = m.subject_id
)
SELECT
    student_id,
    name,
    subject_name,
    marks,
    CASE
        WHEN marks = highest_mark AND marks = lowest_mark THEN 'Strongest and weakest'
        WHEN marks = highest_mark THEN 'Strongest'
        WHEN marks = lowest_mark THEN 'Weakest'
    END AS result_type
FROM subject_results
WHERE marks = highest_mark OR marks = lowest_mark
ORDER BY name, result_type, subject_name;

-- 8. Summarize marks by semester.
SELECT
    m.semester,
    COUNT(*) AS marks_recorded,
    COUNT(DISTINCT m.student_id) AS students_assessed,
    ROUND(AVG(m.marks), 2) AS average_marks,
    MIN(m.marks) AS lowest_mark,
    MAX(m.marks) AS highest_mark
FROM marks AS m
GROUP BY m.semester
ORDER BY m.semester;
