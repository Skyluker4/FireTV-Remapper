#!/bin/sh

logcat -T 1 '*:I' | grep --line-buffered "I OZ-DCS:KeyPressReceiver: Received keyCode: KEYCODE_POWER" | while IFS='' read line; do
	 am start -n me.efesser.flauncher/.MainActivity
done

