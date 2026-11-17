# Analyzing Mental Health Trends in the Workplace Using Big Data Analytics

**Author:** Vaibhav Mistry  
**Course:** ITE-5324 Big Data Analytics  
**Architecture:** Apache Hadoop (HDFS), Apache Hive, Apache Spark, Spark MLlib, Apache Zeppelin  
**Dataset Reference:** [Kaggle Mental Health in Tech Survey](https://www.kaggle.com/datasets/ksaiprakashreddy/mental-health-in-tech-survey-dataset/data)

---

## 1. Problem Statement & Motivation
Workplace mental health concerns have surged across global organizations, directly influencing talent retention, absenteeism, and operational efficiency. However, traditional HR analytics relies on static, localized surveys that fail to capture multivariate relationships across global workforces.

This project designs and executes an end-to-end distributed Big Data pipeline utilizing **Hadoop HDFS**, **Apache Hive**, and **Apache Spark / MLlib** to:
1. Process distributed survey data with schema-on-read flexibility.
2. Audit data completeness and normalize unstructured inputs (such as free-text gender declarations and corrupted spreadsheet formatting).
3. Discover macro-level demographic and organizational patterns.
4. Train scalable machine learning classifiers to predict treatment-seeking behaviors and identify high-risk workplace factors for early intervention.

---

## 2. Five Key Research Questions & Findings

### Question 1: What workplace factors are most strongly correlated with mental health outcomes and treatment?
* **Finding:** Daily **work interference** is by far the strongest indicator ($1.6105$ coefficient weight in Spark MLlib), followed by **remote work** ($0.0727$). 
* **Supervisor Support:** Among employees actively seeking treatment, 39% report having supportive supervisors, while 32% report partial support. When supervisors are approachable, employees feel safer accessing clinical resources without fear of stigma or reprisal.
* **Leave Flexibility:** Employees who perceive medical leave as "Very difficult" or "Somewhat difficult" show high rates of untreated burnout.

### Question 2: How can Big Data tools and techniques handle missing or incomplete survey data?
* **Distributed Audit:** Using Apache Hive, an aggregated null audit was executed across all 24 columns simultaneously via MapReduce/Tez jobs (`SUM(CASE WHEN col IS NULL THEN 1 ELSE 0 END)`).
* **Missing Value Handling:** The audit confirmed that essential columns (`Age`, `Gender`, `Country`, `treatment`, `family_history`) exhibited negligible missingness (< 0.5%), allowing reliable downstream analysis without introducing imputation bias.

### Question 3: What trends in mental health metrics are observed across demographics and geography?
* **Demographics:** The tech workforce surveyed is 77% male, 19% female, and 4% non-binary/other. While males represent the majority of total volume, females and non-binary individuals exhibit a higher proportional rate of diagnosed conditions.
* **Age Trends:** Treatment seeking peaks intensely between ages **25 and 35**, declining steadily past age 40. This corresponds to the early-to-mid career phase characterized by high workloads and career transitions.
* **Geographical Distribution:** The United States, United Kingdom, and Canada represent the largest cohorts. Countries with universal public health systems (e.g., UK, Netherlands) show different employee expectations regarding whether employers should provide mental healthcare benefits.

### Question 4: How can machine learning models predict high-risk employee groups?
* **Spark MLlib Pipeline:** Using an 80/20 train/test split, categorical attributes (`family_history`, `work_interfere`, `treatment`) were encoded using `StringIndexer` and combined with `Age` using `VectorAssembler`.
* **Logistic Regression:** Achieved an **Area Under ROC of 70.61%**.
* **Decision Tree Classifier:** Achieved **69.49% accuracy** (depth 5, 49 nodes).
* **Feature Importance:** Logistic Regression coefficients revealed that environmental friction (`work_interfere`) dominates hereditary risk (`family_history` weight: $1.62 \times 10^{-10}$), emphasizing that workplace conditions are actionable levers for leadership.

### Question 5: How can visualization techniques communicate risks to stakeholders?
* Visual dashboards developed in **Apache Zeppelin** and exported as vector diagrams translate raw SQL counts into clear executive takeaways:
  - Demonstrating that **66% of employees lack access to workplace wellness programs**.
  - Highlighting that supervisor training directly correlates with a safer treatment environment.

---

## 3. Strategic Recommendations for Organizations
1. **Workload Redistribution & Flexibility:** Because work interference is the primary driver of burnout, companies should implement flexible scheduling and active workload balancing.
2. **Supervisor Mental Health Literacy:** Equip frontline engineering managers and supervisors with mental health first-aid training to recognize distress and normalize seeking help.
3. **Closing the Wellness Program Gap:** Over 60% of employees report no wellness programs. Organizations must establish clear, anonymous Employee Assistance Programs (EAPs).
4. **Gender-Inclusive Support:** Foster inclusive employee resource groups (ERGs) to dismantle stigma for underrepresented groups in STEM.
