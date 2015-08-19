v 20130925 2
C 40000 40000 0 0 0 Noqsi-title-B.sym
{
T 50000 40500 5 10 1 1 0 0 1
date=$Date: 2009-01-11 18:02:03 $
T 53900 40500 5 10 1 1 0 0 1
rev=$Revision: 1.1 $
T 55400 40200 5 10 1 1 0 0 1
auth=$Author: jpd $
T 50200 40800 5 8 1 1 0 0 1
fname=$Source: /cvs/MIT/TESS/AE/minisys/components/symbols/Noqsi-title-B.sym,v $
T 53200 41200 5 14 1 1 0 4 1
title=TITLE
}
C 47500 44700 1 0 0 Pump.sym
{
T 49200 47600 5 10 1 1 0 6 1
refdes=PP
}
C 48500 44400 1 0 0 gnd-1.sym
C 47900 42900 1 0 0 vdc-1.sym
{
T 48600 43550 5 10 1 1 0 0 1
refdes=Vm
T 48600 43350 5 10 1 1 0 0 1
value=DC -12V
}
C 48100 42600 1 0 0 gnd-1.sym
N 48200 44100 48200 44700 4
C 46400 47600 1 0 0 vdc-1.sym
{
T 47100 48250 5 10 1 1 0 0 1
refdes=Vp
T 47100 48050 5 10 1 1 0 0 1
value=DC 15V
}
C 46600 47300 1 0 0 gnd-1.sym
N 46700 48800 48200 48800 4
N 48200 48800 48200 47800 4
C 49800 47600 1 0 0 vdc-1.sym
{
T 50500 48250 5 10 1 1 0 0 1
refdes=VL
T 50500 48050 5 10 1 1 0 0 1
value=DC 5V
}
N 50100 48800 48600 48800 4
N 48600 48800 48600 47800 4
C 50000 47300 1 0 0 gnd-1.sym
C 42700 45300 1 0 0 vpulse-1.sym
{
T 43400 45950 5 10 1 1 0 0 1
refdes=Vclk
T 43400 45750 5 10 1 1 0 0 1
value=pulse 0 3.3V 0 10n 10n 0.8u 1.6u
}
C 42900 45000 1 0 0 gnd-1.sym
N 43000 46500 47500 46500 4
C 50400 45900 1 0 0 resistor-1.sym
{
T 50600 46200 5 10 1 1 0 0 1
refdes=Rm
T 51100 46100 5 10 1 1 0 0 1
value=50k
}
C 51200 45700 1 0 0 gnd-1.sym
N 49500 46500 52200 46500 4
{
T 49800 46700 5 10 1 1 0 0 1
netname=op
}
N 49500 46000 50400 46000 4
{
T 49800 46100 5 10 1 1 0 0 1
netname=om
}
C 51900 45300 1 0 0 idc-1.sym
{
T 52600 45950 5 10 1 1 0 0 1
refdes=IBL
T 52600 45750 5 10 1 1 0 0 1
value=DC 16mA
}
C 52100 45000 1 0 0 gnd-1.sym
C 52200 46400 1 0 0 resistor-1.sym
{
T 52400 46700 5 10 1 1 0 0 1
refdes=RSL
T 52900 46600 5 10 1 1 0 0 1
value=2k
}
C 53400 46200 1 0 0 gnd-1.sym
N 53100 46500 53500 46500 4