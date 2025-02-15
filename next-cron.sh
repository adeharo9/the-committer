#!/usr/bin/env bash

# Determine the value of now
NOW=$(date +"%H:%M");
echo "Now: $NOW";

IFS=':' read -ra TIME <<< "$NOW";
HOURS=${TIME[0]};
MINUTES=${TIME[1]};

# Calculate a random delta between 15min and 24h
DELTA_MINUTES=$(shuf -i 15-1500 -n 1);
PLUS_HOURS=$((DELTA_MINUTES / 60));
PLUS_MINUTES=$((DELTA_MINUTES % 60));

NEXT_HOUR=$((HOURS + PLUS_HOURS));
NEXT_MINUTE=$((MINUTES + PLUS_MINUTES));

# Ensure the minutes are within bounds
if [ $NEXT_MINUTE -gt 59 ]; then
  NEXT_MINUTE=$((NEXT_MINUTE - 60));
  NEXT_HOUR=$((NEXT_HOUR + 1));
fi

# Ensure the hours are within bounds
if [ $NEXT_HOUR -gt 23 ]; then
  NEXT_HOUR=$((NEXT_HOUR - 24));
fi

# Store the next time
echo "$NEXT_HOUR:$NEXT_MINUTE";
NEXT_HOUR="$NEXT_HOUR" NEXT_MINUTE="$NEXT_MINUTE" envsubst < next-cron.tpl.yml > .github/workflows/next-cron.yml;
echo -n "$NEXT_HOUR:$NEXT_MINUTE" > next-cron.txt;
