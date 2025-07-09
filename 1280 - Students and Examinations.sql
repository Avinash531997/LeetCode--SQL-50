WITH all_combinations AS (
    SELECT 
        s.student_id,
        s.student_name,
        sub.subject_name
    FROM Students s
    CROSS JOIN Subjects sub
),

joined_with_exams AS (
    SELECT 
        ac.student_id,
        ac.student_name,
        ac.subject_name,
        e.subject_name AS exam_taken
    FROM all_combinations ac
    LEFT JOIN Examinations e
        ON ac.student_id = e.student_id AND ac.subject_name = e.subject_name
),

window_counts AS (
    SELECT 
        student_id,
        student_name,
        subject_name,
        COUNT(exam_taken) OVER (PARTITION BY student_id, subject_name) AS attended_exams
    FROM joined_with_exams
)

SELECT DISTINCT
    student_id,
    student_name,
    subject_name,
    attended_exams
FROM window_counts
ORDER BY student_id, subject_name;
