# Control BOSH jobs with monit or other ways

... bypassing BOSH control. This might be something to regret.

## The idea

There might be a reason why BOSH lifecycle is difficult to deal with. Especially if restarting specific jobs takes really long.
One way to deal with that is to call monit directly and have a specific list of jobs stopped or started. That will be the first approach of this script.
Renaming the job monit rc file and by doing so excluding it from monit's services is the next step. Doing so we also keep bosh_agent happy.
