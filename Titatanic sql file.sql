Select * from titanic_data
--1. How many passengers were onboard the Titanic?
SELECT COUNT(*) AS total_passengers FROM titanic_data;
--2. How many passengers survived?
SELECT COUNT(*) AS survivors FROM titanic_data WHERE Survived = 1;
SELECT Sex, 
       COUNT(*) AS total, 
       SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS survived,
       ROUND(100.0 * SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS survival_rate
FROM titanic_data
GROUP BY Sex;
--3. What is the survival rate by gender?
SELECT Embarked, COUNT(*) AS total_passengers
FROM titanic_data
GROUP BY Embarked;
--4. How many passengers embarked from each port?
SELECT Name, Age 
FROM titanic_data
WHERE Survived = 1 AND Age IS NOT NULL
ORDER BY Age ASC
LIMIT 1;
--6. Who are the youngest and oldest passengers who survived?
SELECT Name, Age 
FROM titanic_data
WHERE Survived = 1 AND Age IS NOT NULL
ORDER BY Age DESC
LIMIT 1;
--6. Which ticket had the highest fare, and who was the passenger?
SELECT Name, Ticket, Fare 
FROM titanic_data
ORDER BY Fare DESC
LIMIT 1;
--7. Find the survival rate of passengers who were alone vs. with family.
SELECT 
    CASE 
        WHEN SibSp = 0 AND Parch = 0 THEN 'Alone'
        ELSE 'With Family'
    END AS travel_type,
    COUNT(*) AS total,
    SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS survived,
    ROUND(100.0 * SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS survival_rate
FROM titanic_data
GROUP BY travel_type;
--8. Which cabin prefix (e.g., 'C', 'D', etc.) had the highest survival rate?
SELECT LEFT(Cabin, 1) AS cabin_prefix,
       COUNT(*) AS total,
       SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END) AS survived,
       ROUND(100.0 * SUM(CASE WHEN Survived = 1 THEN 1 ELSE 0 END)/COUNT(*), 2) AS survival_rate
FROM titanic_data
WHERE Cabin IS NOT NULL
GROUP BY LEFT(Cabin, 1)
ORDER BY survival_rate DESC;



