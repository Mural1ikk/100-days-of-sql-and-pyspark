CREATE TABLE Subscriptions (
    account_id INT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

-- Insert data into the Subscriptions table
INSERT INTO Subscriptions (account_id, start_date, end_date) VALUES
(9, '2020-02-18', '2021-10-30'),
(3, '2021-09-21', '2021-11-13'),
(11, '2020-02-28', '2020-08-18'),
(13, '2021-04-20', '2021-09-22'),
(4, '2020-10-26', '2021-05-08'),
(5, '2020-09-11', '2021-01-17');


-- Create the Streams table
-- This table stores information about individual streaming sessions.
CREATE TABLE Streams (
    session_id INT PRIMARY KEY,
    account_id INT,
    stream_date DATE NOT NULL,
    FOREIGN KEY (account_id) REFERENCES Subscriptions(account_id)
);
INSERT INTO Streams (session_id, account_id, stream_date) VALUES
(14, 9, '2020-05-16'),
(16, 3, '2021-10-27'),
(18, 11, '2020-04-29'),
(17, 13, '2021-08-08'),
(19, 4, '2020-12-31'),
(13, 5, '2021-01-05');
select * from Subscriptions
select * from Streams
--🤔𝐏𝐫𝐨𝐛𝐥𝐞𝐦 𝐒𝐭𝐚𝐭𝐞𝐦𝐞𝐧𝐭:
--Write an SQL query to report the number of accounts that bought a subscription in 2021 but did not have any stream session.




    
WITH Subscriptions2021 AS (
    -- First, we select all account IDs that started a subscription in 2021.
    SELECT
        account_id
    FROM
        Subscriptions
    WHERE
        YEAR(start_date) = 2021
)
SELECT
    COUNT(s2021.account_id) AS accounts_with_no_streams_2021
FROM
    Subscriptions2021 AS s2021
LEFT JOIN
    Streams AS s ON s2021.account_id = s.account_id
GROUP BY
    s2021.account_id;

----------------------->>
select count(s.account_id) as accounts_count
from subscriptions s 
left join streams s1 on s1.account_id = s.account_id
where year(s.start_date) <= 2021  
and year(s.end_date) >= 2021 
and (s1.stream_date is null or YEAR(s1.stream_date) != 2021 
or s1.stream_date > s.end_date )
