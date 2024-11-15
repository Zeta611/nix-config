#!/usr/bin/env fish

set PID_FILE "/tmp/brightness_control.pid"
set COUNT_FILE /tmp/brightness_counter

if not set -q argv[1]
    echo "Usage: bright.fish <change_amount>" >&2
    exit 1
end

set change $argv[1]

if test -f $PID_FILE
    set old_pid (cat $PID_FILE)
    if ps -p $old_pid >/dev/null
        echo (math (cat $COUNT_FILE 2>/dev/null; or echo "0") + $change) >$COUNT_FILE
        kill $old_pid
    end
end

echo %self >$PID_FILE
test -f $COUNT_FILE; or echo $change >$COUNT_FILE

sleep 1.5

set change (cat $COUNT_FILE)
if test $change -lt 0
    ddcutil setvcp 10 - (math "abs($change)")
else if test $change -gt 0
    ddcutil setvcp 10 + $change
end

rm -f $PID_FILE $COUNT_FILE
