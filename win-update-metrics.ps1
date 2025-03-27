### Pending Updates ###
$inputString = Get-WindowsUpdate
$lineCount = ($inputString -split "`n").Count
"win_upgrades_pending " + $lineCount | Out-File -encoding utf8 "win_updates.prom"

# ### Pending Updates ###
$inputString = Get-WindowsUpdate -Category 'SecurityUpdates'
$lineCount = ($inputString -split "`n").Count
"win_security_upgrades_pending " + $lineCount | Out-File -encoding utf8 "win_updates.prom" -Append

### Reboot Required ###
$inputString = Get-WURebootStatus | Select-Object RebootRequired
$pattern = "True"

if ($inputString -match $pattern) {
    "win_reboot_required 1" | Out-File -encoding utf8 "win_updates.prom" -Append
} else {
    "win_reboot_required 0" | Out-File -encoding utf8 "win_updates.prom" -Append
}
