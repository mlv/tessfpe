v 20130925 2
C 40000 40000 0 0 0 Noqsi-title-B.sym
{
T 50000 40500 5 10 1 1 0 0 1
date=20140923
T 53900 40500 5 10 1 1 0 0 1
rev=6.0
T 55400 40200 5 10 1 1 0 0 1
auth=jpd
T 50200 40800 5 8 1 1 0 0 1
fname=Video.8.sch
T 53200 41200 5 14 1 1 0 4 1
title=Video Board
}
C 43300 46800 1 0 0 74hc138.sym
{
T 45000 49500 5 10 1 1 0 6 1
refdes=U10
}
N 43300 49100 42500 49100 4
{
T 43100 49300 5 10 1 1 180 0 1
netname=DCS0
}
C 42500 49100 1 90 0 busripper-1.sym
N 43300 48800 42500 48800 4
{
T 43100 49000 5 10 1 1 180 0 1
netname=DCS1
}
C 42500 48800 1 90 0 busripper-1.sym
N 43300 48500 42500 48500 4
{
T 43100 48700 5 10 1 1 180 0 1
netname=DCS2
}
C 42500 48500 1 90 0 busripper-1.sym
N 43300 47300 43300 47000 4
N 43300 47600 42500 47600 4
{
T 43000 47800 5 10 1 1 180 0 1
netname=DCS3
}
C 42500 47600 1 90 0 busripper-1.sym
C 40200 47300 1 0 0 74_pwr16.sym
{
T 40400 49500 5 8 0 0 0 0 1
symversion=1.0
T 40700 48200 5 10 1 1 0 1 1
refdes=U10
}
N 40600 48200 40600 49300 4
C 40500 47000 1 0 0 gnd-1.sym
C 40600 48400 1 0 0 capacitor.sym
{
T 40800 48900 5 10 1 1 0 0 1
refdes=C26
T 41200 48400 5 10 1 1 0 0 1
value=0.1uF
T 40600 48400 5 10 0 1 0 0 1
footprint=0603
T 40600 49300 5 10 0 0 0 0 1
symversion=20090121
T 40600 48400 5 10 0 0 0 0 1
spec=16WVDC X7R
}
C 41700 48300 1 0 0 gnd-1.sym
N 41800 48600 41500 48600 4
C 43200 46700 1 0 0 gnd-1.sym
C 47400 45000 1 0 0 AD5308.sym
{
T 49200 49100 5 10 1 1 0 6 1
refdes=U12
T 48300 47400 5 10 0 0 0 0 1
device=AD5328
T 48300 47600 5 10 0 0 0 0 1
footprint=TSSOP16
}
C 47400 45500 1 0 0 gnd-1.sym
N 46600 47000 47500 47000 4
{
T 47000 47000 5 10 1 1 0 0 1
netname=DD
}
N 47000 46600 47500 46600 4
{
T 47100 46600 5 10 1 1 0 0 1
netname=DCK
}
C 48400 44800 1 0 0 gnd-1.sym
C 46900 47700 1 90 0 smallbypass.sym
{
T 47100 48500 5 10 1 1 180 0 1
refdes=C29
T 46000 47700 5 10 0 0 90 0 1
symversion=20131108
T 47300 48000 5 10 1 1 180 0 1
value=0.1uF
}
C 46600 47400 1 0 0 gnd-1.sym
N 46000 48600 47500 48600 4
{
T 46400 48700 5 10 1 1 0 0 1
netname=+2.5
}
N 47500 48600 47500 48200 4
C 47500 49300 1 90 0 smallbypass.sym
{
T 47700 50100 5 10 1 1 180 0 1
refdes=C28
T 46600 49300 5 10 0 0 90 0 1
symversion=20131108
T 47900 49600 5 10 1 1 180 0 1
value=0.1uF
}
N 47300 50200 48500 50200 4
N 48500 50200 48500 49300 4
C 47200 49000 1 0 0 gnd-1.sym
C 46400 50100 1 0 0 resistor.sym
{
T 46600 50400 5 10 1 1 0 0 1
refdes=R30
T 46700 49900 5 10 1 1 0 0 1
value=49.9
}
N 46400 50200 42500 50200 4
{
T 42800 50400 5 10 1 1 180 0 1
netname=+5
}
C 42500 50200 1 90 0 busripper-1.sym
N 45700 46200 47500 46200 4
C 52400 42700 1 0 0 gnd-1.sym
C 54100 47900 1 0 0 LM395K.sym
{
T 54700 48400 5 10 1 1 0 0 1
refdes=Q1
}
C 51100 47500 1 0 0 resistor.sym
{
T 51300 47800 5 10 1 1 0 0 1
refdes=R31
T 51400 47300 5 10 1 1 0 0 1
value=24.9k
}
N 52000 47600 52000 48200 4
C 52000 47500 1 0 0 resistor.sym
{
T 52200 47800 5 10 1 1 0 0 1
refdes=R32
T 52300 47300 5 10 1 1 0 0 1
value=100k
}
N 52900 47600 53000 47600 4
N 53000 47600 53000 48400 4
N 53000 48400 54100 48400 4
C 51000 47300 1 0 0 gnd-1.sym
N 49500 48600 52000 48600 4
C 55200 47100 1 0 0 TempConn.sym
{
T 56000 47700 5 10 1 1 0 0 1
refdes=J5
T 55200 48500 5 10 0 1 0 0 1
symversion=20090123
T 55200 47100 5 10 0 0 0 0 1
value=MDM25pads
T 55200 47100 5 10 0 0 0 0 1
footprint=MDM25pads
}
U 55200 47400 54300 47400 10 1
N 54600 47900 54600 47600 4
{
T 54700 47700 5 10 1 1 0 0 1
netname=HTR+
}
C 54600 47600 1 270 0 busripper-1.sym
N 51700 45500 51700 47000 4
{
T 51800 46200 5 10 1 1 0 0 1
netname=HTR-
}
C 54400 47200 1 0 0 busripper-1.sym
C 50900 44400 1 0 0 resistor.sym
{
T 51100 44700 5 10 1 1 0 0 1
refdes=R35
T 51200 44200 5 10 1 1 0 0 1
value=1k
}
N 51800 44500 51800 45100 4
C 51800 44400 1 0 0 resistor.sym
{
T 52000 44700 5 10 1 1 0 0 1
refdes=R36
T 52100 44200 5 10 1 1 0 0 1
value=31.6k
}
N 52700 44500 52800 44500 4
N 52800 44500 52800 45300 4
C 50800 44200 1 0 0 gnd-1.sym
N 45700 46200 45700 47900 4
N 45700 47900 45300 47900 4
C 43300 41100 1 0 0 74hc238.sym
{
T 45000 44500 5 10 1 1 0 6 1
refdes=U11
}
N 43300 44100 42500 44100 4
{
T 43100 44300 5 10 1 1 180 0 1
netname=HKA3
}
C 42500 44100 1 90 0 busripper-1.sym
N 43300 43700 42500 43700 4
{
T 43100 43900 5 10 1 1 180 0 1
netname=HKA4
}
C 42500 43700 1 90 0 busripper-1.sym
N 43300 43300 42500 43300 4
{
T 43100 43500 5 10 1 1 180 0 1
netname=HKA5
}
C 42500 43300 1 90 0 busripper-1.sym
N 43300 41700 42500 41700 4
{
T 43100 41900 5 10 1 1 180 0 1
netname=HKA6
}
C 42500 41700 1 90 0 busripper-1.sym
N 45300 42500 55400 42500 4
C 40200 41300 1 0 0 74_pwr16.sym
{
T 40400 43500 5 8 0 0 0 0 1
symversion=1.0
T 40700 42200 5 10 1 1 0 1 1
refdes=U11
}
N 40600 43200 40600 42200 4
C 40500 41000 1 0 0 gnd-1.sym
C 43000 42200 1 0 0 gnd-1.sym
N 43100 42500 43300 42500 4
N 43300 42500 43300 42100 4
C 54000 45700 1 0 0 gnd-1.sym
N 54600 46000 54100 46000 4
C 56200 45700 1 0 0 gnd-1.sym
N 56300 46100 55400 46100 4
N 55400 46100 55400 46000 4
N 55900 46400 56300 46400 4
N 56300 46000 56300 46400 4
N 55000 46000 55000 46400 4
C 54000 42600 1 0 0 MUX08.sym
{
T 55700 45800 5 10 1 1 0 0 1
refdes=U14
}
N 55100 42600 55100 41900 4
{
T 55300 41900 5 10 1 1 90 0 1
netname=HKA2
}
N 54800 42600 54800 41900 4
{
T 55000 41900 5 10 1 1 90 0 1
netname=HKA1
}
N 54500 42600 54500 41900 4
{
T 54700 41900 5 10 1 1 90 0 1
netname=HKA0
}
C 55100 41900 1 180 0 busripper-1.sym
C 54800 41900 1 180 0 busripper-1.sym
C 54500 41900 1 180 0 busripper-1.sym
C 54100 46300 1 0 0 resistor.sym
{
T 54300 46600 5 10 1 1 0 0 1
refdes=R34
T 54300 46100 5 10 1 1 0 0 1
value=464
T 54100 46300 5 10 0 0 0 0 1
footprint=0603
}
C 55000 46200 1 0 0 capacitor.sym
{
T 55200 46700 5 10 1 1 0 0 1
refdes=C31
T 55600 46200 5 10 1 1 0 0 1
value=0.1uF
T 55000 46200 5 10 0 1 0 0 1
footprint=0603
T 55000 47100 5 10 0 0 0 0 1
symversion=20090121
T 55000 46200 5 10 0 0 0 0 1
spec=16WVDC X7R
}
N 55400 42600 55400 42500 4
N 54000 45300 52800 45300 4
N 51700 47000 54400 47000 4
N 54400 47000 54400 47200 4
C 52600 46400 1 0 0 resistor.sym
{
T 52800 46700 5 10 1 1 0 0 1
refdes=R33
T 52900 46200 5 10 1 1 0 0 1
value=0.402
}
C 52500 46200 1 0 0 gnd-1.sym
N 53500 46500 53500 47000 4
N 51700 45500 51800 45500 4
U 56800 41700 48800 41700 10 -1
U 48800 41700 48800 40400 10 0
U 48800 40400 42300 40400 10 -1
U 42300 40400 42300 50700 10 -1
N 46000 48600 46000 49900 4
N 46000 49900 42500 49900 4
C 42500 49900 1 90 0 busripper-1.sym
N 54600 48900 56700 48900 4
{
T 55300 49000 5 10 1 1 0 0 1
netname=+15
}
N 56700 48900 56700 41900 4
C 56700 41900 1 180 0 busripper-1.sym
N 55900 44300 55900 41900 4
{
T 56100 42000 5 10 1 1 90 0 1
netname=HKCOM
}
C 55900 41900 1 180 1 busripper-1.sym
N 54100 46400 53700 46400 4
N 53700 46400 53700 41900 4
{
T 53800 42200 5 10 1 1 0 0 1
netname=+5
}
C 53700 41900 1 180 0 busripper-1.sym
C 50900 43300 1 0 0 capacitor.sym
{
T 51100 43800 5 10 1 1 0 0 1
refdes=C30
T 51500 43300 5 10 1 1 0 0 1
value=0.1uF
T 50900 43300 5 10 0 1 0 0 1
footprint=0603
T 50900 44200 5 10 0 0 0 0 1
symversion=20090121
T 50900 43300 5 10 0 0 0 0 1
spec=16WVDC X7R
}
N 51800 43500 51800 44100 4
C 50800 43200 1 0 0 gnd-1.sym
N 51800 44100 53700 44100 4
N 52500 43900 52500 44100 4
C 40600 42400 1 0 0 capacitor.sym
{
T 40800 42900 5 10 1 1 0 0 1
refdes=C27
T 41200 42400 5 10 1 1 0 0 1
value=0.1uF
T 40600 42400 5 10 0 1 0 0 1
footprint=0603
T 40600 43300 5 10 0 0 0 0 1
symversion=20090121
T 40600 42400 5 10 0 0 0 0 1
spec=16WVDC X7R
}
C 41700 42300 1 0 0 gnd-1.sym
N 41800 42600 41500 42600 4
N 40600 49300 42100 49300 4
{
T 41400 49400 5 10 1 1 0 0 1
netname=+3.3D
}
N 40600 43200 42100 43200 4
{
T 41400 43300 5 10 1 1 0 0 1
netname=+3.3D
}
C 42100 43200 1 270 1 busripper-1.sym
C 42100 49300 1 270 1 busripper-1.sym
N 47000 46600 47000 40600 4
C 47000 40600 1 180 0 busripper-1.sym
N 46600 47000 46600 40600 4
C 46600 40600 1 180 0 busripper-1.sym
T 50500 40200 9 10 1 0 0 0 1
8
T 52000 40200 9 10 1 0 0 0 1
8
C 51900 48000 1 0 0 lp_opamp_dual.sym
{
T 52600 48700 5 10 1 1 0 0 1
refdes=U13
T 52200 50700 5 8 0 0 0 0 1
symversion=1.0nicer
}
C 51700 44900 1 0 0 lp_opamp_dual.sym
{
T 52400 45600 5 10 1 1 0 0 1
refdes=U13
T 52000 47600 5 8 0 0 0 0 1
symversion=1.0nicer
T 51700 44900 5 10 0 0 0 0 1
slot=2
}
C 52200 43000 1 0 0 lp_opamp_dual_pwr.sym
{
T 52400 45000 5 8 0 0 0 0 1
symversion=1.0
T 52850 43550 5 10 1 1 0 0 1
refdes=U13
}
N 45300 41300 45300 40600 4
{
T 44700 40700 5 10 1 1 0 0 1
netname=HK120
}
C 45300 40600 1 180 0 busripper-1.sym
N 45300 41700 45800 41700 4
{
T 45600 41800 5 10 1 1 0 0 1
netname=HK112
}
N 45800 41700 45800 40600 4
C 45800 40600 1 180 0 busripper-1.sym
