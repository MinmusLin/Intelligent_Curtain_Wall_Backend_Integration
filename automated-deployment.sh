#!/bin/bash

LOG_DIR="/home/mat/Intelligent_Curtain_Wall/DeploymentLogs"

TIMESTAMP=$(date +"%Y%m%d-%H:%M")
START_TIME=$(date +"%Y-%m-%d %H:%M:%S")
START_SECONDS=$(date +%s)

{
    echo "Execution Start Time: $START_TIME"

    sudo docker compose pull
    sudo docker compose down
    sudo docker compose up -d

    END_TIME=$(date +"%Y-%m-%d %H:%M:%S")
    END_SECONDS=$(date +%s)
    ELAPSED_TIME=$((END_SECONDS - START_SECONDS))

    echo "Execution End Time: $END_TIME"
    echo "Total Execution Time: $ELAPSED_TIME seconds"
} &> "$LOG_DIR/$TIMESTAMP.txt"
