# Write your MySQL query statement below
WITH FriendsCount AS (
    SELECT requester_id AS id 
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted

)
SELECT id, count(id) AS num
FROM FriendsCount
GROUP BY id
ORDER BY num DESC
LIMIT 1;

# Solution with 2 CTE and LIMIT
WITH CTE AS (
    SELECT requester_id AS id 
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted
),
ACTE AS(
    SELECT id, COUNT(id) AS 'num' FROM CTE GROUP BY id
)
SELECT * FROM ACTE
ORDER BY num DESC
LIMIT 1;

# Solution with 2 CTE and without LIMIT
WITH CTE AS (
    SELECT requester_id AS id 
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id
    FROM RequestAccepted
),
ACTE AS(
    SELECT id, COUNT(id) AS 'num' FROM CTE GROUP BY id
)
SELECT *
FROM ACTE
WHERE num = (
    SELECT MAX(num) FROM ACTE
)

# One more solution
WITH CTE AS (SELECT requester_id AS 'id',
(
    SELECT COUNT(*) FROM RequestAccepted
    WHERE id = requester_id OR id = accepter_id
)AS'num'
FROM RequestAccepted
UNION ALL
SELECT accepter_id AS 'id',
(
    SELECT COUNT(*) FROM RequestAccepted
    WHERE id = requester_id OR id = accepter_id
)AS'num'
FROM RequestAccepted
)
SELECT * FROM CTE
ORDER BY num DESC
LIMIT 1
