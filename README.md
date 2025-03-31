# Windows Update Monitoring
This repository contains all necessary scripts to monitor Windows updates, security updates and pending reboots and store the results in Prometheus.

## Requirements
- Node Exporter with textfile collector enabled

## Usage

**Step 1:** Install the PSWindowsUpdate PowerShell module
```
Install-Module -Name PSWindowsUpdate
```

**Step 2:** Customize `create_update_monitoring_task.ps1`

Running `create_update_monitoring_task.ps1` creates entries in the Windows task scheduler (`taskschd.msc`).
Change the `WorkingDirectory` and the times of `New-ScheduledTaskTrigger` how you need it. `WorkingDirectory` needs to point to the directory where `win-update-metrics.ps1` is located. `New-ScheduledTaskTrigger` sets the times when the `win-update-metrics.ps1` is executed.

**Step 3:** Set up your `textfile collector`

The output of the `win-update-metrics.ps1` script is saved to `win_updates.prom` which located in the same directory as the script. The `textfile collector` needs to be configured in a way to collect `*.prom` files from this directory.

If everything is working correctly, the `win_updates.prom` file should have a similar content to the one shown below:
```
win_upgrades_pending 2
win_security_upgrades_pending 0
win_reboot_required 1
```

## Credits
Credits to [labmonkeys-space](https://github.com/labmonkeys-space) who created a [repository for apt monitoring](https://github.com/labmonkeys-space/apt-prometheus) which this approach was heavily inspired by.