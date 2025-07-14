#!/bin/bash

# JARVIS Polybar Launch Script
# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch JARVIS bar
echo "---" | tee -a /tmp/polybar1.log
polybar jarvis 2>&1 | tee -a /tmp/polybar1.log & disown

# Notification
sleep 2
notify-send "🤖 JARVIS" "Interface initialized. All systems online." -i computer

echo "JARVIS polybar launched..."
