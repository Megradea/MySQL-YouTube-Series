-- Using Common Table Expressions (CTE)
-- A CTE allows you to define a subquery block that can be referenced within the main query. 
-- It is particularly useful for recursive queries or queries that require referencing a higher level
-- this is something we will look at in the next lesson

-- Let's take a look at the basics of writing a CTE:


-- First, CTEs start using a "With" Keyword. Now we get to name this CTE anything we want
-- Then we say as and within the parenthesis we build our subquery/table we want
WITH CTE_Author AS 
(
SELECT gender, SUM(salary), MIN(salary), MAX(salary), COUNT(salary), AVG(salary)
FROM author_demographics dem
JOIN author_income inc
	ON dem.author_id = inc.author_id
GROUP BY gender
)
-- directly after using it we can query the CTE
SELECT *
FROM CTE_author;


-- Now if I come down here, it won't work because it's not using the same syntax
SELECT *
FROM CTE_Author;



-- Now we can use the columns within this CTE to do calculations on this data that
-- we couldn't have done without it.

WITH CTE_Author AS 
(
SELECT gender, SUM(income), MIN(income), MAX(income), COUNT(income)
FROM author_demographics dem
JOIN author_income inc
	ON dem.author_id = inc.author_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(`SUM(income)`/`COUNT(income)`),2)
FROM CTE_Author
GROUP BY gender;



-- we also have the ability to create multiple CTEs with just one With Expression

WITH CTE_Author AS 
(
SELECT author_id, gender, birth_date
FROM author_demographics dem
WHERE birth_date > '1982-11-01'
), -- just have to separate by using a comma
CTE_Author AS 
(
SELECT author_id, income
FROM parks_and_recreation.author_income
WHERE income >= 50000
)
-- Now if we change this a bit, we can join these two CTEs together
SELECT *
FROM CTE_Author cte1
LEFT JOIN CTE_Author2 cte2
	ON cte1. author_id = cte2. author_id;


-- the last thing I wanted to show you is that we can actually make our life easier by renaming the columns in the CTE
-- let's take our very first CTE we made. We had to use tick marks because of the column names

-- we can rename them like this
WITH CTE_Author (gender, sum_income, min_income, max_income, count_income) AS 
(
SELECT gender, SUM(income), MIN(income), MAX(income), COUNT(income)
FROM author_demographics dem
JOIN author_income inc
	ON dem.author_id = inc.author_id
GROUP BY gender
)
-- notice here I have to use back ticks to specify the table names  - without them it doesn't work
SELECT gender, ROUND(AVG(sum_imcome/count_income),2)
FROM CTE_Author
GROUP BY gender;



























