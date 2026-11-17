-- =============================================================================
-- Apache Hive - Missing Data & Quality Audit Query
-- Author: Vaibhav Mistry
-- Purpose: Evaluates missing/incomplete records across all 24 schema attributes
-- =============================================================================

USE mental_health_db;

SELECT 
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS missing_gender,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country,
    SUM(CASE WHEN self_employed IS NULL THEN 1 ELSE 0 END) AS missing_self_employed,
    SUM(CASE WHEN family_history IS NULL THEN 1 ELSE 0 END) AS missing_family_history,
    SUM(CASE WHEN treatment IS NULL THEN 1 ELSE 0 END) AS missing_treatment,
    SUM(CASE WHEN work_interfere IS NULL THEN 1 ELSE 0 END) AS missing_work_interfere,
    SUM(CASE WHEN no_employees IS NULL THEN 1 ELSE 0 END) AS missing_no_employees,
    SUM(CASE WHEN remote_work IS NULL THEN 1 ELSE 0 END) AS missing_remote_work,
    SUM(CASE WHEN benefits IS NULL THEN 1 ELSE 0 END) AS missing_benefits,
    SUM(CASE WHEN care_options IS NULL THEN 1 ELSE 0 END) AS missing_care_options,
    SUM(CASE WHEN wellness_program IS NULL THEN 1 ELSE 0 END) AS missing_wellness_program,
    SUM(CASE WHEN seek_help IS NULL THEN 1 ELSE 0 END) AS missing_seek_help,
    SUM(CASE WHEN anonymity IS NULL THEN 1 ELSE 0 END) AS missing_anonymity,
    SUM(CASE WHEN leave IS NULL THEN 1 ELSE 0 END) AS missing_leave,
    SUM(CASE WHEN mental_health_consequence IS NULL THEN 1 ELSE 0 END) AS missing_mental_health_consequence,
    SUM(CASE WHEN phys_health_consequence IS NULL THEN 1 ELSE 0 END) AS missing_phys_health_consequence,
    SUM(CASE WHEN coworkers IS NULL THEN 1 ELSE 0 END) AS missing_coworkers,
    SUM(CASE WHEN supervisor IS NULL THEN 1 ELSE 0 END) AS missing_supervisor,
    SUM(CASE WHEN mental_health_interview IS NULL THEN 1 ELSE 0 END) AS missing_mental_health_interview,
    SUM(CASE WHEN phys_health_interview IS NULL THEN 1 ELSE 0 END) AS missing_phys_health_interview,
    SUM(CASE WHEN mental_vs_physical IS NULL THEN 1 ELSE 0 END) AS missing_mental_vs_physical,
    SUM(CASE WHEN obs_consequence IS NULL THEN 1 ELSE 0 END) AS missing_obs_consequence
FROM mental_health_survey;
