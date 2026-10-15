# Combo II-DLD S75 (xc7s75fgga484-1) / BCD-이진수 변환 bcd_conv
# 클록이 없는 조합회로이므로 클록 제약은 없다.
# 입력 핀은 Lab1 4비트 가산기와 같은 스위치, 출력은 Lab3과 같은 LED 8개를 사용한다.

# ten[3:0] 십의 자리 입력 스위치 (곱셈기의 a와 같은 스위치)
set_property PACKAGE_PIN Y1 [get_ports {ten[3]}]
set_property PACKAGE_PIN W3 [get_ports {ten[2]}]
set_property PACKAGE_PIN U2 [get_ports {ten[1]}]
set_property PACKAGE_PIN T1 [get_ports {ten[0]}]

# one[3:0] 일의 자리 입력 스위치 (곱셈기의 b와 같은 스위치)
set_property PACKAGE_PIN W4 [get_ports {one[3]}]
set_property PACKAGE_PIN W1 [get_ports {one[2]}]
set_property PACKAGE_PIN V4 [get_ports {one[1]}]
set_property PACKAGE_PIN U4 [get_ports {one[0]}]

# valid → led[7], bin[6:0] → led[6:0]
set_property PACKAGE_PIN L4 [get_ports valid]
set_property PACKAGE_PIN M4 [get_ports {bin[6]}]
set_property PACKAGE_PIN M2 [get_ports {bin[5]}]
set_property PACKAGE_PIN N7 [get_ports {bin[4]}]
set_property PACKAGE_PIN M7 [get_ports {bin[3]}]
set_property PACKAGE_PIN M3 [get_ports {bin[2]}]
set_property PACKAGE_PIN M1 [get_ports {bin[1]}]
set_property PACKAGE_PIN N5 [get_ports {bin[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ten[*] one[*] bin[*] valid}]
