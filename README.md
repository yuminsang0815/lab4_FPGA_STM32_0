# lab4_FPGA_STM32_0

전자전기컴퓨터설계실험Ⅱ STM32_0 주차 FPGA 교재 실습: 4비트 곱셈기(`mult_4bit`), BCD-이진수 변환(`bcd_conv`).

- 코드 출처: [Glaysia/ece2_474 `docs/FPGA_additional.md`](https://github.com/Glaysia/ece2_474/blob/main/docs/FPGA_additional.md) 1·2번 실습 (TB에 파형 저장만 추가)
- 실험 전 레포트: [reports/pre/01_mult_bcd.md](reports/pre/01_mult_bcd.md)
- 시뮬레이션 로그·파형: [evidence/](evidence/)

## 시뮬레이션 실행 (Icarus Verilog + GTKWave)

VS Code: `Ctrl+Shift+P` → `Tasks: Run Task` → `SIM: ...`

터미널:

```
.\run_sim.bat mult_4bit wave
.\run_sim.bat bcd_conv wave
```
