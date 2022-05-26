# Control BOSH jobs with monit or other ways

... bypassing BOSH control. This might be something to regret.

## The idea

There might be a reason why BOSH lifecycle is difficult to deal with. Especially if restarting specific jobs takes really long.
One way to deal with that is to call monit directly and have a specific list of jobs stopped or started. That will be the first approach of this script.
Second approach would be to set specific files or configurations to override the existing ones (that could prove silly).