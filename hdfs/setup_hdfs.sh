#!/usr/bin/env bash
# ==============================================================================
# Workplace Mental Health Trends - HDFS Ingestion Script
# Author: Vaibhav Mistry
# Description: Automates HDFS directory creation, data upload, and file verification.
# ==============================================================================

set -euo pipefail

DATASET_NAME="Mental_Health_in_Tech_Survey_dataset.csv"
LOCAL_PATH="./data/${DATASET_NAME}"
HDFS_TARGET_DIR="/user/root/final_project"

echo "=== Step 1: Creating HDFS Target Directory ==="
hadoop fs -mkdir -p "${HDFS_TARGET_DIR}"
echo "[OK] Directory created: ${HDFS_TARGET_DIR}"

echo "=== Step 2: Ingesting Dataset to HDFS ==="
if [ -f "${LOCAL_PATH}" ]; then
    hadoop fs -put -f "${LOCAL_PATH}" "${HDFS_TARGET_DIR}/"
    echo "[OK] Ingested ${LOCAL_PATH} to ${HDFS_TARGET_DIR}/"
else
    echo "[ERROR] Local dataset not found at ${LOCAL_PATH}"
    exit 1
fi

echo "=== Step 3: Verifying HDFS File Storage ==="
hadoop fs -ls -h "${HDFS_TARGET_DIR}"
echo "[SUCCESS] Data ingestion pipeline complete."
