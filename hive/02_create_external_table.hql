-- =============================================================================
-- Apache Hive External Table Definition
-- Author: Vaibhav Mistry
-- Project: Analyzing Mental Health Trends in the Workplace Using Big Data
-- =============================================================================

USE mental_health_db;

DROP TABLE IF EXISTS mental_health_survey;

CREATE EXTERNAL TABLE IF NOT EXISTS mental_health_survey (
    age INT,
    gender STRING,
    country STRING,
    self_employed STRING,
    family_history STRING,
    treatment STRING,
    work_interfere STRING,
    no_employees STRING,
    remote_work STRING,
    benefits STRING,
    care_options STRING,
    wellness_program STRING,
    seek_help STRING,
    anonymity STRING,
    leave STRING,
    mental_health_consequence STRING,
    phys_health_consequence STRING,
    coworkers STRING,
    supervisor STRING,
    mental_health_interview STRING,
    phys_health_interview STRING,
    mental_vs_physical STRING,
    obs_consequence STRING,
    comments STRING
)
COMMENT 'Public workplace survey on mental health in the technology sector'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/root/final_project'
TBLPROPERTIES ("skip.header.line.count"="1");

-- Data verification
SELECT * FROM mental_health_survey LIMIT 10;
