#!/bin/bash

# this is a Shebang, it tells the OS to use Bash to run this file

echo "================================"
echo "     SYSTEM HEALTH MONITOR      "
echo "================================"


# 1. print the date

echo "Date: $(date)"
echo ""

# 2. Check disk usage (human readable)
echo "Disk Space:"
df -h / | grep /
echo ""

# 3. Uptime
echo "System Uptime:"
uptime
echo ""


echo "================================="


