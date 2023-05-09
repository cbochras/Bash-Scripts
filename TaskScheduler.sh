#!/bin/bash

# Define the tasks file path
TASKS_FILE="./tasks.txt"

execute_task() {
  echo "Executing task '$1'..."

  eval "$2"

  echo "Task '$1' completed."
}

check_tasks() {
  CURRENT_TIME=$(date +%s)

  while read -r line; do
    TASK_NAME=$(echo "$line" | cut -d "|" -f 1)
    TASK_COMMAND=$(echo "$line" | cut -d "|" -f 2)
    TASK_SCHEDULE=$(echo "$line" | cut -d "|" -f 3)
    TASK_NEXT_RUN=$(echo "$line" | cut -d "|" -f 4)

    if [[ $CURRENT_TIME -ge $TASK_NEXT_RUN ]]; then
      execute_task "$TASK_NAME" "$TASK_COMMAND"

      case $TASK_SCHEDULE in
        "hourly")
          NEXT_RUN=$(date +%s -d "1 hour")
          ;;
        "daily")
          NEXT_RUN=$(date +%s -d "1 day")
          ;;
        "weekly")
          NEXT_RUN=$(date +%s -d "1 week")
          ;;
        "monthly")
          NEXT_RUN=$(date +%s -d "1 month")
          ;;
        *)
          NEXT_RUN=$(date +%s -d "$TASK_SCHEDULE")
          ;;
      esac

      sed -i "s/^$TASK_NAME.*$/$TASK_NAME|$TASK_COMMAND|$TASK_SCHEDULE|$NEXT_RUN/g" "$TASKS_FILE"
    fi
  done < "$TASKS_FILE"
}

add_task() {
  echo "Enter the task name:"
  read TASK_NAME
  echo "Enter the task command:"
  read TASK_COMMAND
  echo "Enter the task schedule (hourly, daily, weekly, monthly, or specific time in HH:MM format):"
  read TASK_SCHEDULE

  case $TASK_SCHEDULE in
    "hourly")
      NEXT_RUN=$(date +%s -d "1 hour")
      ;;
    "daily")
      NEXT_RUN=$(date +%s -d "1 day")
      ;;
    "weekly")
      NEXT_RUN=$(date +%s -d "1 week")
      ;;
    "monthly")
      NEXT_RUN=$(date +%s -d "1 month")
      ;;
    *)
      NEXT_RUN=$(date +%s -d "$TASK_SCHEDULE")
      ;;
  esac

echo "$cron_line" >> "$cron_file"

echo "Task added successfully:"
echo "$cron_line"
