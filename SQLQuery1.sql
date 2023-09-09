--Table 1 

-- user_id	created_at	company_id	language	activated_at	state
-- user_id	occurred_at	event_type	event_name	location	device	user_type
use TRANITY

create table users(

user_id int,
created_at varchar(100),
company_id int,
language varchar(100),
activated_at varchar(100),
state varchar(50));

select * from users
select * from events
select * from email_events



ALTER TABLE users
ADD temp_created_at datetime;


UPDATE users
SET temp_created_at = CONVERT(DATETIME, created_at, 105);;

alter table users Drop column created_at

ALTER TABLE users
ALTER COLUMN temp_created_at datetime;

EXEC sp_rename 'users.temp_created_at', 'created_at', 'COLUMN';

select * from events

--Write an SQL query to calculate the weekly user engagement.
SELECT 
    YEAR(occurred_at) AS year,
    DATEPART(ISO_WEEK, occurred_at) AS week,
    COUNT(DISTINCT user_id) AS engaged_users
FROM
    events
WHERE
    event_type = 'engagement'
GROUP BY
    YEAR(occurred_at),
    DATEPART(ISO_WEEK, occurred_at)
ORDER BY
    YEAR(occurred_at),
    DATEPART(ISO_WEEK, occurred_at);

	SELECT
    DATEPART(YEAR, created_at) AS year,
    DATEPART(MONTH, created_at) AS month,
    COUNT(DISTINCT user_id) AS new_users
FROM
    users
GROUP BY
    DATEPART(YEAR, created_at),
    DATEPART(MONTH, created_at)
ORDER BY
    year, month;

	SELECT
    device,
    YEAR(occurred_at) AS year,
    DATEPART(WEEK, occurred_at) AS week,
    COUNT(*) AS engagement_count
FROM
    events
WHERE
    event_type = 'engagement'
GROUP BY
    device,
    YEAR(occurred_at),
    DATEPART(WEEK, occurred_at)
ORDER BY
    device,
    year,
    week;


SELECT
    action,
    COUNT(DISTINCT user_id) AS unique_users,
    COUNT(*) AS total_events
FROM
    email_events
GROUP BY
    action
ORDER BY
    action;


