@echo off
rem Usage: run_sim.bat mult_4bit        (simulate only)
rem        run_sim.bat bcd_conv wave    (simulate + open GTKWave)
if "%~1"=="" (
    echo Usage: run_sim.bat [mult_4bit^|bcd_conv] [wave]
    exit /b 1
)
cd /d "%~dp0%~1" || exit /b 1
echo === iverilog compile: %~1 ===
iverilog -g2012 -o %~1.vvp *.v *.sv || exit /b 1
echo === vvp run ===
vvp -n %~1.vvp || exit /b 1
if /i "%~2"=="wave" start "" gtkwave %~1.gtkw
