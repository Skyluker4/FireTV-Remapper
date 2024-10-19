#!/bin/sh

logcat 'ActivityTaskManager:I *:S' -T 1 | grep --line-buffered "ActivityTaskManager: START u0 {act=android.intent.action.MAIN cat=\[android.intent.category.HOME\] flg=0x10000100 cmp=com.amazon.tv.launcher/.ui.HomeActivity_vNext (has extras)} from uid 0" | while IFS='' read line; do
	am start -n me.efesser.flauncher/.MainActivity
done

