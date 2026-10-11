# GTKWave 창을 띄워 파형을 PNG로 캡처해 evidence 폴더에 저장합니다.
# 사용법: powershell -ExecutionPolicy Bypass -File capture_wave.ps1
param([int]$WaitSec = 4)

Add-Type -AssemblyName System.Drawing
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class W {
    [DllImport("user32.dll")] public static extern bool SetProcessDPIAware();
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int n);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr h, out RECT r);
    public struct RECT { public int Left, Top, Right, Bottom; }
}
"@
[W]::SetProcessDPIAware() | Out-Null

$root = $PSScriptRoot
$ev = Join-Path $root 'evidence'
New-Item -ItemType Directory -Force $ev | Out-Null

# 이름, 폴더, 확대 구간(ps). 구간이 $null이면 전체 보기
$shots = @(
    @{ name = 'mult_4bit_wave_full';  dir = 'mult_4bit'; range = $null },
    @{ name = 'mult_4bit_wave_zoom';  dir = 'mult_4bit'; range = @(240000, 256000) },  # a=15, b=0..15
    @{ name = 'bcd_conv_wave_full';   dir = 'bcd_conv';  range = $null },
    @{ name = 'bcd_conv_wave_zoom';   dir = 'bcd_conv';  range = @(144000, 176000) }   # ten=9 (one 0~15), ten=10
)

foreach ($s in $shots) {
    $dir = Join-Path $root $s.dir
    $tcl = Join-Path $env:TEMP "gtkw_$($s.name).tcl"
    if ($s.range) {
        "gtkwave::setZoomRangeTimes $($s.range[0]) $($s.range[1])" | Out-File -Encoding ascii $tcl
    } else {
        "gtkwave::/Time/Zoom/Zoom_Full" | Out-File -Encoding ascii $tcl
    }
    $p = Start-Process gtkwave -ArgumentList "$($s.dir).gtkw", '-S', $tcl -WorkingDirectory $dir -PassThru
    Start-Sleep -Seconds $WaitSec
    $p.Refresh()
    $h = $p.MainWindowHandle
    if ($h -eq [IntPtr]::Zero) { Write-Error "GTKWave window not found: $($s.name)"; $p | Stop-Process -Force; continue }
    [W]::ShowWindow($h, 3) | Out-Null          # 최대화
    [W]::SetForegroundWindow($h) | Out-Null
    Start-Sleep -Seconds 2
    $r = New-Object W+RECT
    [W]::GetWindowRect($h, [ref]$r) | Out-Null
    $w = $r.Right - $r.Left; $hgt = $r.Bottom - $r.Top
    $bmp = New-Object System.Drawing.Bitmap $w, $hgt
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.CopyFromScreen($r.Left, $r.Top, 0, 0, $bmp.Size)
    $out = Join-Path $ev "$($s.name).png"
    $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose(); $bmp.Dispose()
    $p | Stop-Process -Force
    Write-Host "saved $out"
}
