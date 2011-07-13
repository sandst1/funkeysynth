#
# Regular cron jobs for the funkeysynth package
#
0 4	* * *	root	[ -x /usr/bin/funkeysynth_maintenance ] && /usr/bin/funkeysynth_maintenance
