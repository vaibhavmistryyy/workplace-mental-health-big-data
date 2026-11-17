-- =============================================================================
-- Apache Hive Database Initialization
-- Author: Vaibhav Mistry
-- Project: Analyzing Mental Health Trends in the Workplace Using Big Data
-- =============================================================================

CREATE DATABASE IF NOT EXISTS mental_health_db
COMMENT 'Enterprise database for workplace mental health survey and telemetry'
LOCATION '/user/hive/warehouse/mental_health_db.db';

USE mental_health_db;

SHOW DATABASES;
