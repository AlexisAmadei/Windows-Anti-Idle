$signature = @"
using System;
using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("user32.dll", CallingConvention = CallingConvention.StdCall)]
    public static extern void mouse_event(int dwFlags, int dx, int dy, int dwData, UIntPtr dwExtraInfo);
}
"@
Add-Type $signature

$MOUSEEVENTF_MOVE = 0x0001
$PIXEL_DISTANCE = 100 # distance to move the mouse in pixels
$TIMEOUT = 1 # in seconds

try {
    Write-Host "Press Ctrl+C to stop."
    while ($true) {
        # move right by 1px
        [Win32]::mouse_event($MOUSEEVENTF_MOVE, $PIXEL_DISTANCE, 0, 0, [UIntPtr]::Zero)
        Start-Sleep -Milliseconds 100
        # move left by 1px
        [Win32]::mouse_event($MOUSEEVENTF_MOVE, -($PIXEL_DISTANCE), 0, 0, [UIntPtr]::Zero)
        Start-Sleep -Seconds $TIMEOUT
    }
}
catch [System.Management.Automation.StopException] {
    Write-Host "KeepActive script stopped."
}
