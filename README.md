#  Telecom Customer Churn Analysis

##  Project Overview

Customer churn is a major challenge for telecom companies because losing customers directly affects recurring revenue and long-term customer value.

In this project, I analyzed **7,042 telecom customers** to understand customer churn patterns, identify high-risk customer segments, quantify the revenue associated with churn, and develop data-driven recommendations for improving customer retention.

The analysis was performed using **Excel, PostgreSQL, and Power BI**, following an end-to-end Data Analyst workflow.

---

#  Business Problem

The telecom company is experiencing customer churn and wants to understand:

* How large is the churn problem?
* Which customer segments have the highest churn rates?
* Does customer tenure influence churn?
* Is contract type associated with customer churn?
* Which payment methods show higher churn?
* Which internet service categories have higher churn?
* Do support and security services relate to customer retention?
* Which customer segments should the retention team prioritize?
* How much monthly revenue is associated with churned customers?

The objective is not only to report churn but to identify **actionable retention opportunities**.

---

# 🗂️ Dataset

The dataset contains customer-level telecom information.

### Customer Information

* Customer ID
* Gender
* Senior Citizen
* Partner
* Dependents
* Tenure

### Services

* Phone Service
* Multiple Lines
* Internet Service
* Online Security
* Online Backup
* Device Protection
* Tech Support
* Streaming TV
* Streaming Movies

### Contract & Billing

* Contract
* Paperless Billing
* Payment Method
* Monthly Charges
* Total Charges

### Target Variable

* Churn

Where:

```text
Yes = Customer churned
No  = Customer retained
```

Each row represents one customer.

---

# 🛠️ Tools & Technologies

| Tool                | Purpose                                                          |
| ------------------- | ---------------------------------------------------------------- |
| **Microsoft Excel** | Data validation, cleaning, exploratory analysis and Pivot Tables |
| **PostgreSQL**      | Data validation, transformation and business analysis            |
| **Power BI**        | Data modeling, DAX and interactive dashboard                     |
| **GitHub**          | Project documentation and portfolio presentation                 |

---

# 🔄 Project Workflow

```text
Raw Dataset
     ↓
Data Quality Assessment
     ↓
Excel Data Validation & Exploration
     ↓
PostgreSQL Data Cleaning & Analysis
     ↓
Business Question Investigation
     ↓
Power BI Data Modeling
     ↓
DAX Measures
     ↓
Interactive Dashboard
     ↓
Business Insights
     ↓
Retention Recommendations
```

---

# 1️⃣ Data Quality & Cleaning

Before performing analysis, the dataset was reviewed for:

* Duplicate customer IDs
* Missing values
* Blank values
* Incorrect data types
* Inconsistent categorical values
* Invalid numerical values
* Blank `TotalCharges` values

The cleaning process was documented before conducting the final analysis.

### Analytical fields created

* Churn Flag
* Tenure Group
* Customer Risk Segment
* Revenue-related metrics

---

# 2️⃣ Excel Analysis

Excel was used as the initial data-validation and exploratory-analysis layer.

### Functions Used

* `IF`
* `COUNT`
* `COUNTA`
* `COUNTIF`
* `COUNTIFS`
* `SUM`
* `SUMIF`
* `SUMIFS`
* `AVERAGE`
* `AVERAGEIF`
* `AVERAGEIFS`
* `XLOOKUP`
* Pivot Tables

### Excel Analysis Included

* Overall customer churn
* Churn by contract
* Churn by tenure
* Churn by payment method
* Churn by internet service
* Churn by technical support
* Churn by online security
* Customer segmentation
* Revenue analysis

---

# 3️⃣ SQL Analysis — PostgreSQL

PostgreSQL was used for structured data validation and business analysis.

### SQL Concepts Used

* `SELECT`
* `WHERE`
* `GROUP BY`
* `HAVING`
* `ORDER BY`
* Aggregate Functions
* `CASE`
* Conditional Aggregation
* Subqueries
* CTEs
* Window Functions
* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`

### Key SQL Questions

The analysis investigated:

1. What is the overall churn rate?
2. Which contract type has the highest churn?
3. Which tenure group has the highest churn?
4. Which payment method has the highest churn?
5. Which internet service has the highest churn?
6. Does technical support relate to churn?
7. Does online security relate to churn?
8. Which Contract × Tenure segment has the highest churn?
9. Which segments have the highest churned monthly revenue?
10. Which high-value customers have churned?

---

# 4️⃣ Power BI Dashboard

The Power BI dashboard was designed as a management-facing reporting tool.

## Page 1 — Executive Overview

### KPIs

* Total Customers
* Churned Customers
* Retained Customers
* Churn Rate
* Monthly Revenue
* Churned Monthly Revenue
* Average Monthly Charges
* Average Tenure

### Visuals

* Churn by Contract
* Churn by Tenure Group
* Churn by Internet Service
* Churn by Payment Method

---

## Page 2 — Churn Drivers

This page investigates factors associated with customer churn.

### Analysis

* Contract Type
* Tenure
* Internet Service
* Payment Method
* Tech Support
* Online Security
* Monthly Charges
* Customer Demographics

Interactive slicers allow the analysis to be filtered by different customer segments.

---

## Page 3 — Retention Priority

This page focuses on identifying customer segments that may require additional retention attention.

### Analysis

* High-risk customer segments
* Contract × Tenure analysis
* High-risk customer count
* Monthly revenue associated with high-risk customers
* Customer-level details
* Retention opportunities

The risk segmentation is **rule-based analytical segmentation**, not a machine-learning prediction model.

---

# 5️⃣ DAX Measures

Key DAX measures include:

```DAX
Total Customers =
DISTINCTCOUNT(Telecom[customerID])
```

```DAX
Churned Customers =
CALCULATE(
    [Total Customers],
    Telecom[Churn] = "Yes"
)
```

```DAX
Retained Customers =
CALCULATE(
    [Total Customers],
    Telecom[Churn] = "No"
)
```

```DAX
Churn Rate =
DIVIDE(
    [Churned Customers],
    [Total Customers],
    0
)
```

```DAX
Total Monthly Revenue =
SUM(Telecom[MonthlyCharges])
```

```DAX
Churned Monthly Revenue =
CALCULATE(
    [Total Monthly Revenue],
    Telecom[Churn] = "Yes"
)
```

Additional measures were created for average monthly charges, average tenure, revenue exposure and segment-level analysis.

---

# 📈 Key Business Findings

## 1. Overall Customer Churn

The dataset contains **7,042 customers**, of which **1,869 customers churned**.

| Metric             |            Value |
| ------------------ | ---------------: |
| Total Customers    |            7,042 |
| Churned Customers  |            1,869 |
| Retained Customers |            5,173 |
| Overall Churn Rate |       **26.54%** |
| Average Tenure     | **32.37 months** |

### Insight

Approximately **1 in 4 customers has churned**, indicating that customer retention is an important business issue.

---

# 2. Contract Type Is Strongly Associated With Churn

| Contract Type  | Customers | Churned | Churn Rate |
| -------------- | --------: | ------: | ---------: |
| Month-to-Month |     3,875 |   1,655 | **42.71%** |
| One Year       |     1,473 |     166 | **11.27%** |
| Two Year       |     1,694 |      48 |  **2.83%** |

### Insight

Month-to-month customers have a substantially higher observed churn rate than customers on longer-term contracts.

### Recommendation

Investigate targeted strategies to encourage eligible month-to-month customers to move toward longer-term contracts through:

* Contract upgrade incentives
* Annual-plan discounts
* Loyalty benefits
* Personalized retention offers

---

# 3. Early-Tenure Customers Show Higher Churn

The **0–12 month tenure group has approximately 47.44% churn**.

### Insight

The first year appears to be a particularly important period in the customer lifecycle.

### Recommendation

Consider strengthening early customer engagement through:

* New-customer onboarding
* Early satisfaction surveys
* Welcome programs
* Proactive technical support
* Follow-up during the first year

---

# 4. Month-to-Month + Low-Tenure Customers Represent a High-Risk Segment

The analysis identified:

**Month-to-Month × Low Tenure**

with:

* **1,994 customers**
* **1,024 churned customers**
* **51.35% churn rate**

### Insight

Customers who are both relatively new and on month-to-month contracts represent a particularly high observed-risk segment.

### Recommendation

The retention team should investigate targeted onboarding and contract-conversion strategies for this group.

---

# 5. Electronic Check Customers Have Higher Observed Churn

| Payment Method   | Customers | Churned | Churn Rate |
| ---------------- | --------: | ------: | ---------: |
| Electronic Check |     2,365 |   1,071 | **45.29%** |
| Mailed Check     |     1,611 |     308 | **19.12%** |
| Bank Transfer    |     1,544 |     258 | **16.71%** |
| Credit Card      |     1,522 |     232 | **15.24%** |

### Insight

Electronic-check customers show a substantially higher observed churn rate than the other payment-method groups.

### Recommendation

Investigate whether billing experience, payment friction, customer composition, or other factors contribute to this relationship.

Automatic payment options could be tested as part of a retention experiment.

**Important:** This analysis shows an association and does not establish that electronic check causes churn.

---

# 6. Fiber Optic Customers Have Higher Observed Churn

| Internet Service | Customers | Churned | Churn Rate |
| ---------------- | --------: | ------: | ---------: |
| Fiber Optic      |     3,096 |   1,297 | **41.89%** |
| DSL              |     2,421 |     459 | **18.96%** |
| No Internet      |     1,525 |     113 |  **7.41%** |

### Insight

Fiber optic customers have a significantly higher observed churn rate than DSL customers.

### Recommendation

Further investigate:

* Service reliability
* Pricing
* Technical support
* Installation experience
* Customer satisfaction
* Competitor offerings

The analysis should not assume that fiber service itself causes churn.

---

# 7. Senior Citizens Have Higher Observed Churn

| Customer Group     | Churn Rate |
| ------------------ | ---------: |
| Senior Citizen     | **41.68%** |
| Non-Senior Citizen | **23.61%** |

### Insight

Senior-citizen customers have a higher observed churn rate.

### Recommendation

Further investigate whether contract type, tenure, pricing or service mix explains part of this difference before designing targeted interventions.

---

# 8. Customers Without Dependents Have Higher Churn

| Dependents | Churn Rate |
| ---------- | ---------: |
| No         | **31.28%** |
| Yes        | **15.46%** |

### Insight

Customers without dependents have approximately twice the observed churn rate of customers with dependents.

This segment should be investigated further to determine whether the difference is associated with contract, tenure, pricing or service characteristics.

---

# 9. Gender Shows Little Difference

| Gender | Churn Rate |
| ------ | ---------: |
| Female | **26.93%** |
| Male   | **26.16%** |

### Insight

The difference in churn between male and female customers is relatively small.

Gender therefore does not appear to be a major churn differentiator in this dataset.

Retention efforts should focus more heavily on variables showing larger differences.

---

# 🎯 Priority Retention Opportunities

Based on the observed patterns, the analysis recommends investigating the following areas in priority order:

### Priority 1 — New Month-to-Month Customers

Focus on customers during the first year of their relationship with the company.

### Priority 2 — Contract Conversion

Investigate incentives that could encourage suitable month-to-month customers to adopt longer-term contracts.

### Priority 3 — Fiber Optic Customer Experience

Investigate whether pricing, service quality, technical support or competition contributes to the higher observed churn.

### Priority 4 — Electronic Check Customers

Investigate billing and payment experience and test whether alternative payment options affect retention.

### Priority 5 — Continuous Churn Monitoring

Use the Power BI dashboard to monitor churn across:

* Contract
* Tenure
* Internet Service
* Payment Method
* Customer Services
* Customer Demographics

---

# ⚠️ Analytical Limitations

This analysis is primarily **descriptive and diagnostic**.

The observed relationships should not automatically be interpreted as causal relationships.

For example:

> High churn among Fiber Optic customers does not prove that Fiber Optic service causes churn.

Other variables such as contract type, tenure, monthly charges and customer characteristics may influence the relationship.

Further analysis or experimentation would be required to establish causality.

The rule-based customer risk segmentation is also an analytical prioritization framework and **not a predictive machine-learning model**.

---

# 📁 Project Structure

```text
telecom-customer-churn/
│
├── README.md
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── excel/
│   └── telecom_churn_analysis.xlsx
│
├── sql/
│   └── telecom_churn_analysis.sql
│
├── powerbi/
│   └── telecom_churn_dashboard.pbix
│
├── screenshots/
│   ├── executive_overview.png
│   ├── churn_drivers.png
│   └── retention_priority.png
│
└── documentation/
    ├── data_quality_log.md
    └── business_insights.md
```

---

# 📸 Dashboard Preview
<img width="1202" height="688" alt="image" src="https://github.com/user-attachments/assets/25b1c127-669e-488d-acf6-69b8913e9351" />

## Executive Overview
<img width="1207" height="673" alt="image" src="https://github.com/user-attachments/assets/6d7cf4e5-3347-4336-9489-50f638b9848d" />


# 🚀 Skills Demonstrated

### Data Analysis

* Data Cleaning
* Data Validation
* Exploratory Data Analysis
* Customer Segmentation
* Churn Analysis
* Revenue Analysis
* Business Problem Solving

### Excel

* IF
* COUNTIF / COUNTIFS
* SUMIF / SUMIFS
* AVERAGEIF / AVERAGEIFS
* XLOOKUP
* Pivot Tables
* Data Validation
* Data Cleaning

### SQL

* PostgreSQL
* Aggregations
* GROUP BY
* HAVING
* CASE
* Conditional Aggregation
* Subqueries
* CTEs
* Window Functions
* Ranking

### Power BI

* Power Query
* Data Modeling
* DAX
* KPI Development
* Interactive Dashboards
* Customer Segmentation
* Business Reporting

---

# 💼 Business Value

The purpose of this project is not simply to calculate churn.

The analysis connects customer behavior to potential business action:

```text
Customer Data
      ↓
Churn Patterns
      ↓
High-Risk Segments
      ↓
Revenue Exposure
      ↓
Retention Priorities
      ↓
Business Recommendations
```

This approach demonstrates how a Data Analyst can transform raw customer data into insights that support business decision-making.

---

# 👤 Author

**Syed Auliya Mohiddin**

Aspiring Data Analyst

**Skills:** Excel | SQL | Power BI | Data Analysis
