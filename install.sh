#!/bin/sh

if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be run as root" >&2
	exit 1
fi

INSTALL_PREFIX="/usr/local/"
BIN_DIR="${INSTALL_PREFIX}/bin/"
DATA_DIR="${INSTALL_PREFIX}/share/firetv-remap/"
COMMAND_NAME="firetv-activate-remap"

mkdir -p "${BIN_DIR}"
cp ./firetv-activate-remap "${BIN_DIR}"
chmod +x "${BIN_DIR}/${COMMAND_NAME}"

mkdir -p "${DATA_DIR}"
cp ./start-me.sh "${DATA_DIR}"
cp ./watch-home.sh "${DATA_DIR}"
cp ./watch-power.sh "${DATA_DIR}"

USE_SYSTEMD=false
USE_CRON=false

for arg in "$@"; do
	case $arg in
		--systemd)
			USE_SYSTEMD=true
			;;
		--cron)
			USE_CRON=true
			;;
	esac
done

if ! $USE_SYSTEMD && ! $USE_CRON; then
	if command -v systemctl > /dev/null 2>&1; then
		USE_SYSTEMD=true
	else
		USE_CRON=true
	fi
fi

if $USE_SYSTEMD; then
	if command -v systemctl > /dev/null 2>&1; then
		echo "Installing systemd service files..."
		cp ./firetv-remap@.service /etc/systemd/system/
		cp ./firetv-remap@.timer /etc/systemd/system/
		systemctl daemon-reload

		echo "Enable with 'systemctl enable --now firetv-remap@<device>.timer'"
	else
		echo "Systemd not found, cannot install systemd service files."
	fi
fi

if $USE_CRON; then
	echo "Adding cronjob..."
	cp crontab /etc/cron.d/firetv-remap
	echo "Cronjob added, you may need to restart cron service"
fi
