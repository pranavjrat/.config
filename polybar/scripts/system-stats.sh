#!/bin/bash

# JARVIS System Stats Script
# Shows system information in JARVIS style

# Get system info
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F'%' '{print $1}')
mem_usage=$(free | grep Mem | awk '{printf("%.0f", $3/$2 * 100.0)}')
disk_usage=$(df -h / | awk 'NR==2{print $5}' | sed 's/%//')
uptime=$(uptime -p | sed 's/up //')

# Display in notification
notify-send "🤖 JARVIS System Analysis" "
🔹 CPU Usage: ${cpu_usage}%
🔹 Memory Usage: ${mem_usage}%  
🔹 Disk Usage: ${disk_usage}%
🔹 Uptime: ${uptime}
🔹 Status: All systems operational" -i computer
