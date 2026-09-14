CREATE DATABASE telecom_db;

CREATE TABLE tele_churn(
    CustomerID VARCHAR(30),
    Gender VARCHAR(10),
    SeniorCitizen INTEGER,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    Tenure INTEGER,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(30),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(30),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges NUMERIC(10,2),
    TotalCharges NUMERIC(12,2),
    Churn VARCHAR(5)
);

--1. How many customers are present in the dataset?

SELECT COUNT(*)AS total_customers 
	FROM tele_churn;

--2. How many customers have left the company? (Churned customers)

SELECT * FROM tele_churn
WHERE churn='Yes';

SELECT COUNT(*)AS churned_customers FROM tele_churn
WHERE churn='Yes';

--3. How many customers are still with the company? (Retained customers)

SELECT COUNT(*)AS retained_customers FROM tele_churn
WHERE churn='No';

--4. What percentage of the total customer base has churned? (Churn rate)

SELECT 
	(SELECT COUNT(*) FROM tele_churn
	WHERE churn='Yes')*100.0
	/ 
	(SELECT COUNT(*)
	FROM tele_churn)AS churn_rate;

--5. What is the average number of months customers have been with the company?(Average Tenure)

SELECT 	ROUND(AVG(tenure),2) AS avg_tenure
FROM tele_churn;

--6. What is the average monthly charge across all customers?
SELECT ROUND(AVG(monthlycharges),2)AS avg_mon_charges
FROM tele_churn;

SELECT customerid,ROUND(AVG(monthlycharges),2)AS avg_mon_charges
FROM tele_churn
GROUP BY customerid
ORDER BY avg_mon_charges ASC;

--7. How many customers are enrolled in each contract type?
SELECT contract,COUNT(*)
FROM tele_churn
GROUP BY contract;

--8. How many customers churned and how many were retained for each contract type?
SELECT contract,(COUNT(*) FILTER (WHERE churn = 'Yes'))AS churned,
				(COUNT(*) FILTER (WHERE churn = 'No'))AS retained
FROM tele_churn
GROUP BY contract
ORDER BY churned desc,retained desc;

--9.What is the churn rate for each contract type, and which contract type has the highest churn rate?
SELECT contract,COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
				/ COUNT (customerid) AS churn_rate			
FROM tele_churn
GROUP BY contract
ORDER BY churn_rate desc;

--10. What is the churn rate for each payment method, and which payment method has the highest churn rate?
SELECT paymentmethod,COUNT(*) AS total_customers,
					 COUNT(*) FILTER (WHERE churn ='Yes') AS churned_customers,
					 ROUND(COUNT(*) FILTER (WHERE churn='Yes') * 100.0
					/ COUNT(customerid),2) AS churn_rate
FROM tele_churn
GROUP BY paymentmethod
ORDER BY churn_rate desc;

--11. For each Internet Service type, how many total customers are there, how many have churned, and what is the churn rate?
SELECT internetservice,
		COUNT(*) AS total_customers,
		COUNT(*) FILTER (WHERE churn = 'Yes')AS churned_customers,
		ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
		/ COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY internetservice
ORDER BY churn_rate DESC;

--12.For each SeniorCitizen group, how many total customers are there, how many have churned, and what is the churn rate?
SELECT seniorcitizen,
		COUNT(*) AS total_customers,
		COUNT(*) FILTER (WHERE churn = 'Yes')AS churned_customers,
		ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
		/ COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY seniorcitizen
ORDER BY churn_rate DESC;

--13. For each Partner group, how many total customers are there, how many have churned, and what is the churn rate?
SELECT partner,
		COUNT(*) AS total_customers,
		COUNT(*) FILTER (WHERE churn = 'Yes')AS churned_customers,
		ROUND(COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
		/ COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY partner
ORDER BY churn_rate DESC;

--14. For each Dependents group, how many total customers are there, how many have churned, and what is the churn rate?
SELECT dependents,
	   COUNT(*) AS total_customers,
	   COUNT(*) FILTER (WHERE churn ='Yes')AS churn_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rte
FROM tele_churn
GROUP BY dependents; 

--15. For each gender, how many total customers are there, how many have churned, and what is the churn rate?
SELECT gender,
	   COUNT(*) AS total_customers,
	   COUNT(*) FILTER (WHERE churn ='Yes')AS churn_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rte
FROM tele_churn
GROUP BY gender;

--16.What is the total number of customers, churned customers, and churn rate for each tenure group?
SELECT 
CASE
	WHEN tenure BETWEEN 0 AND 12 THEN 'Low tenure'
	WHEN tenure BETWEEN 13 AND 24 THEN 'Not bad tenure'
	WHEN tenure BETWEEN 25 AND 36 THEN 'Average tenure'
	WHEN tenure BETWEEN 37 AND 48 THEN 'Good tenure'
	WHEN tenure BETWEEN 49 AND 60 THEN 'Excellent tenure'
	ELSE 'Outstanding tenure'
	END AS tenure_group,
	COUNT(*) AS total_customers,
	COUNT(*) FILTER (WHERE churn ='Yes')AS churn_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY tenure_group
ORDER BY total_customers ASC;

--17. What is the total number of customers, churned customers, and churn rate for each Monthly Charges group?
SELECT 
	CASE
    WHEN monthlycharges < 30 THEN 'Low charges'
    WHEN monthlycharges < 50 THEN 'Middle charges'
    WHEN monthlycharges < 70 THEN 'Average charges'
    WHEN monthlycharges < 90 THEN 'High charges'
    ELSE 'Too much charges'
END AS monthly_charges_group,
	COUNT(*) AS total_customers,
	COUNT(*) FILTER (WHERE churn ='Yes')AS churn_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY Monthly_charges_group
ORDER BY total_customers;

--18. For each Contract type and Tenure group, how many customers have churned, and what is the churn rate?
SELECT contract,CASE
	WHEN tenure BETWEEN 0 AND 12 THEN 'Low tenure'
	WHEN tenure BETWEEN 13 AND 24 THEN 'Not bad tenure'
	WHEN tenure BETWEEN 25 AND 36 THEN 'Average tenure'
	WHEN tenure BETWEEN 37 AND 48 THEN 'Good tenure'
	WHEN tenure BETWEEN 49 AND 60 THEN 'Excellent tenure'
	ELSE 'Outstanding tenure'
	END AS tenure_group,
	COUNT(*) AS total_customers,
	COUNT(*) FILTER (WHERE churn ='Yes')AS churn_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY contract,tenure_group
ORDER BY contract ASC,churn_rate DESC;

--19. For each Contract type and Payment Method, how many customers are there, how many have churned, and what is the churn rate?
SELECT contract,paymentmethod,
	   COUNT(*) AS total_customers,
	   COUNT(*) FILTER (WHERE churn ='Yes')AS churn_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY contract,paymentmethod
ORDER BY contract,churn_rate DESC;

--20.For each Tech Support group, how many customers are there, how many have churned, and what is the churn rate?
SELECT techsupport,
	   COUNT(*) AS total_customers,
	   COUNT(*) FILTER (WHERE churn ='Yes')AS churned_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY techsupport;

--21.For each Online Security group, how many customers are there, how many have churned, and what is the churn rate?
SELECT onlinesecurity,
	   COUNT(*) AS total_customers,
	   COUNT(*) FILTER (WHERE churn ='Yes')AS churned_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rate
FROM tele_churn
GROUP BY onlinesecurity;

--22.Which Contract × Tenure segment has the highest churn rate?
WITH tenure_groups AS(
	SELECT contract,CASE
	WHEN tenure BETWEEN 0 AND 12 THEN 'Low tenure'
	WHEN tenure BETWEEN 13 AND 24 THEN 'Not bad tenure'
	WHEN tenure BETWEEN 25 AND 36 THEN 'Average tenure'
	WHEN tenure BETWEEN 37 AND 48 THEN 'Good tenure'
	WHEN tenure BETWEEN 49 AND 60 THEN 'Excellent tenure'
	ELSE 'Outstanding tenure'
	END AS tenure_group,churn
	FROM tele_churn
),
churn_analysis AS(
	SELECT contract,tenure_group,
	COUNT(*) AS total_customers,
	COUNT(*) FILTER (WHERE churn ='Yes')AS churn_customers,
	   ROUND(COUNT(*) FILTER (WHERE churn ='Yes') *100.0
	   / COUNT(*),2) AS churn_rate
FROM tenure_groups
GROUP BY contract,tenure_group
)
SELECT *
FROM churn_analysis
ORDER BY churn_rate DESC
LIMIT 1;

--23.Among Contract × Tenure segments with at least 100 customers, which 5 segments have the highest churn rate?
WITH tenure_groups AS (
    SELECT contract,CASE
	WHEN tenure BETWEEN 0 AND 12 THEN 'Low tenure'
	WHEN tenure BETWEEN 13 AND 24 THEN 'Not bad tenure'
	WHEN tenure BETWEEN 25 AND 36 THEN 'Average tenure'
	WHEN tenure BETWEEN 37 AND 48 THEN 'Good tenure'
	WHEN tenure BETWEEN 49 AND 60 THEN 'Excellent tenure'
	ELSE 'Outstanding tenure'
	END AS tenure_group,churn
    FROM tele_churn
),
churn_analysis AS (
    SELECT
        contract,
        tenure_group,
        COUNT(*) AS total_customers,
        COUNT(*) FILTER (WHERE churn = 'Yes') AS churned_customers,
        ROUND(
            COUNT(*) FILTER (WHERE churn = 'Yes') * 100.0
            / COUNT(*),
            2
        ) AS churn_rate
    FROM tenure_groups
    GROUP BY contract, tenure_group
    HAVING COUNT(*) >= 100
)
SELECT *
FROM churn_analysis
ORDER BY churn_rate DESC
LIMIT 5;

SELECT * FROM tele_churn;
