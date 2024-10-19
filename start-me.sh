#!/bin/sh

start_if_not_running() {
	if ! pgrep -f "${1}" > /dev/null; then
		nohup sh "${1}" >/dev/null 2>&1 &
	fi
}

# Check and start the processes
start_if_not_running "/data/local/tmp/1"
start_if_not_running "/data/local/tmp/2"

