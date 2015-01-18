v 20130925 2
C 40000 40000 0 0 0 Noqsi-title-B.sym
{
T 50000 40500 5 10 1 1 0 0 1
date=20141202
T 53900 40500 5 10 1 1 0 0 1
rev=6.0
T 55400 40200 5 10 1 1 0 0 1
auth=jpd
T 50200 40800 5 8 1 1 0 0 1
fname=Interface.9.sch
T 53200 41200 5 14 1 1 0 4 1
title=Interface Board
}
N 44000 48800 47400 48800 4
C 42300 47500 1 0 0 REF43.sym
{
T 43700 49100 5 10 1 1 0 6 1
refdes=U10
}
C 42900 47200 1 0 0 gnd-1.sym
C 41600 49400 1 0 0 resistor.sym
{
T 41800 49700 5 10 1 1 0 0 1
refdes=R41
T 41800 49100 5 10 1 1 0 0 1
value=49.9
}
C 43700 49300 1 0 0 bypass.sym
{
T 43900 49800 5 10 1 1 0 0 1
refdes=C100
T 43700 50200 5 10 0 0 0 0 1
symversion=20131108
T 44300 49300 5 10 1 1 0 0 1
value=1uF
}
N 42500 49500 43700 49500 4
N 43000 49300 43000 49500 4
C 44700 49200 1 0 0 gnd-1.sym
N 44800 49500 44600 49500 4
U 41000 50000 41000 46200 10 -1
N 41600 49500 41200 49500 4
{
T 41200 49600 5 10 1 1 0 0 1
netname=+5
}
C 41200 49500 1 180 0 busripper-1.sym
U 41000 46200 56400 46200 10 1
C 53200 47100 1 0 1 led-1.sym
{
T 53100 46900 5 10 1 1 0 6 1
refdes=LED1
T 52400 47900 5 10 0 0 0 6 1
symversion=0.1
T 53200 47100 5 10 0 0 0 6 1
footprint=0603
T 53200 47100 5 10 0 0 0 6 1
value=475-2506-1-ND
}
C 54100 47200 1 0 1 resistor.sym
{
T 53900 47500 5 10 1 1 0 6 1
refdes=R46
T 53900 46900 5 10 1 1 0 6 1
value=1k
}
N 52300 47300 52200 47300 4
N 52200 47300 52200 46400 4
{
T 52000 47200 5 10 1 1 270 0 1
netname=\_RED\_
}
C 52200 46400 1 180 0 busripper-1.sym
N 54100 47300 54300 47300 4
N 54300 47300 54300 46400 4
{
T 54100 47200 5 10 1 1 270 0 1
netname=+3.3F
}
C 54300 46400 1 180 0 busripper-1.sym
C 55200 47100 1 0 0 led-1.sym
{
T 55300 46900 5 10 1 1 0 0 1
refdes=LED2
T 56000 47900 5 10 0 0 0 0 1
symversion=0.1
T 55200 47100 5 10 0 0 0 0 1
footprint=0603
T 55200 47100 5 10 0 0 0 0 1
value=475-2709-1-ND
}
C 54300 47200 1 0 0 resistor.sym
{
T 54500 47500 5 10 1 1 0 0 1
refdes=R47
T 54500 46900 5 10 1 1 0 0 1
value=1k
}
N 56100 47300 56200 47300 4
N 56200 47300 56200 46400 4
{
T 56000 47200 5 10 1 1 270 0 1
netname=\_GREEN\_
}
C 56200 46400 1 180 0 busripper-1.sym
T 52000 40100 9 10 1 0 0 0 1
10
T 50500 40100 9 10 1 0 0 0 1
9
C 52600 48100 1 0 1 led-1.sym
{
T 52500 47900 5 10 1 1 0 6 1
refdes=LED3
T 51800 48900 5 10 0 0 0 6 1
symversion=0.1
T 52600 48100 5 10 0 0 0 6 1
footprint=0603
T 52600 48100 5 10 0 0 0 6 1
value=475-2794-1-ND
}
C 53500 48200 1 0 1 resistor.sym
{
T 53300 48500 5 10 1 1 0 6 1
refdes=R48
T 53300 47900 5 10 1 1 0 6 1
value=1k
}
N 51700 48300 51600 48300 4
N 51600 48300 51600 46400 4
{
T 51400 48200 5 10 1 1 270 0 1
netname=\_YELLOW\_
}
C 51600 46400 1 180 0 busripper-1.sym
N 53500 48300 54100 48300 4
N 54100 48300 54100 47300 4
C 46600 42900 1 0 0 ArtixPower.sym
{
T 48300 45000 5 10 1 1 0 6 1
refdes=AP
}
N 46200 44100 46200 48800 4
N 46200 44100 46600 44100 4
C 47500 42600 1 0 0 gnd-1.sym
N 47600 45200 47600 46000 4
{
T 47300 45600 5 10 1 1 0 0 1
netname=+5
}
C 47600 46000 1 0 0 busripper-1.sym
N 48600 44700 48600 46000 4
{
T 48100 45400 5 10 1 1 0 0 1
netname=+3.3F
}
C 48600 46000 1 0 0 busripper-1.sym
N 48600 44300 49100 44300 4
{
T 48500 44300 5 10 1 1 0 0 1
netname=+2.5F
}
N 49100 44300 49100 46000 4
C 49100 46000 1 0 0 busripper-1.sym
N 48600 43900 49600 43900 4
{
T 48900 44000 5 10 1 1 0 0 1
netname=+1.8F
}
N 49600 43900 49600 46000 4
C 49600 46000 1 0 0 busripper-1.sym
N 48600 43500 50100 43500 4
{
T 49200 43600 5 10 1 1 0 0 1
netname=+1F
}
N 50100 43500 50100 46000 4
C 50100 46000 1 0 0 busripper-1.sym
C 52500 45300 1 180 0 led-1.sym
{
T 51700 44500 5 10 0 0 180 0 1
symversion=0.1
T 52500 45300 5 10 0 0 180 0 1
footprint=0603
T 52500 45300 5 10 0 0 180 0 1
value=475-2481-1-ND
T 52400 45500 5 10 1 1 180 0 1
refdes=LED4
}
C 53400 45200 1 180 0 resistor.sym
{
T 53200 44900 5 10 1 1 180 0 1
refdes=R49
T 53200 45500 5 10 1 1 180 0 1
value=1k
}
N 51600 45100 51500 45100 4
N 51500 45100 51500 46000 4
{
T 51300 45200 5 10 1 1 90 2 1
netname=\_ORANGE\_
}
C 51500 46000 1 0 1 busripper-1.sym
N 53400 45100 53600 45100 4
N 53600 45100 53600 46000 4
{
T 53400 45200 5 10 1 1 90 2 1
netname=+3.3F
}
C 53600 46000 1 0 1 busripper-1.sym
C 54500 45300 1 180 1 led-1.sym
{
T 55300 44500 5 10 0 0 180 6 1
symversion=0.1
T 54500 45300 5 10 0 0 180 6 1
footprint=0603
T 54500 45300 5 10 0 0 180 6 1
value=VAOL-S6SB4CT-ND
T 54600 45500 5 10 1 1 180 6 1
refdes=LED5
}
C 53600 45200 1 180 1 resistor.sym
{
T 53800 44900 5 10 1 1 180 6 1
refdes=R50
T 53800 45500 5 10 1 1 180 6 1
value=1k
}
N 55400 45100 55500 45100 4
N 55500 45100 55500 46000 4
{
T 55300 45200 5 10 1 1 90 2 1
netname=\_BLUE\_
}
C 55500 46000 1 0 1 busripper-1.sym
C 51900 44300 1 180 0 led-1.sym
{
T 51100 43500 5 10 0 0 180 0 1
symversion=0.1
T 51900 44300 5 10 0 0 180 0 1
footprint=0603
T 51900 44300 5 10 0 0 180 0 1
value=67-2226-1-ND
T 51800 44500 5 10 1 1 180 0 1
refdes=LED6
}
C 52800 44200 1 180 0 resistor.sym
{
T 52600 43900 5 10 1 1 180 0 1
refdes=R51
T 52600 44500 5 10 1 1 180 0 1
value=221
}
N 51000 44100 50900 44100 4
N 50900 44100 50900 46000 4
{
T 50700 44200 5 10 1 1 90 2 1
netname=\_WHITE\_
}
C 50900 46000 1 0 1 busripper-1.sym
N 52800 44100 53400 44100 4
N 53400 44100 53400 45100 4
C 42300 44400 1 0 0 coil-1.sym
{
T 42500 44800 5 10 0 0 0 0 1
device=IHLP5050FDER100M01
T 42500 45000 5 10 0 0 0 0 1
symversion=0.1
T 42300 44400 5 10 0 1 0 0 1
footprint=IHLP5050
T 42500 44600 5 10 1 1 0 0 1
refdes=L1
T 42600 44200 5 10 1 1 0 0 1
value=10uH
}
U 45300 46200 45300 42500 10 -1
N 43300 44400 45100 44400 4
{
T 44900 44500 5 10 1 1 0 0 1
netname=+15
}
C 45100 44400 1 270 0 busripper-1.sym
N 43300 42900 45100 42900 4
{
T 44900 43000 5 10 1 1 0 0 1
netname=-12
}
C 45100 42900 1 270 0 busripper-1.sym
N 43300 43800 45100 43800 4
{
T 45000 43900 5 10 1 1 0 0 1
netname=+5
}
C 45100 43800 1 270 0 busripper-1.sym
C 42300 42900 1 0 0 coil-1.sym
{
T 42500 43300 5 10 0 0 0 0 1
device=IHLP5050FDER100M01
T 42500 43500 5 10 0 0 0 0 1
symversion=0.1
T 42300 42900 5 10 0 1 0 0 1
footprint=IHLP5050
T 42500 43100 5 10 1 1 0 0 1
refdes=L2
T 42600 42700 5 10 1 1 0 0 1
value=10uH
}
C 40300 42300 1 0 0 DB9-1.sym
{
T 41300 45200 5 10 0 0 0 0 1
device=747467-1
T 40300 42300 5 10 0 0 0 0 1
footprint=747467-1
T 40300 42300 5 10 0 0 0 0 1
class=IO
T 40500 45500 5 10 1 1 0 0 1
refdes=J5
}
C 41600 42300 1 0 1 gnd-1.sym
N 41500 45000 41900 45000 4
N 41900 45000 41900 42600 4
N 41900 42600 41500 42600 4
N 41500 43800 41500 43500 4
N 42300 42900 41500 42900 4
N 41500 43200 41500 42900 4
N 42300 44400 41500 44400 4
N 41500 44700 41500 44400 4
C 42300 43800 1 0 0 coil-1.sym
{
T 42500 44200 5 10 0 0 0 0 1
device=CDPH4D19FNP-220MC
T 42500 44400 5 10 0 0 0 0 1
symversion=0.1
T 42300 43800 5 10 0 1 0 0 1
footprint=CDPH4D19F
T 42500 44000 5 10 1 1 0 0 1
refdes=L4
T 42600 43600 5 10 1 1 0 0 1
value=22uH
}
N 42300 43800 41500 43800 4
C 44000 43300 1 0 1 polarcap.sym
{
T 43800 44200 5 10 0 0 0 6 1
symversion=0.1
T 44000 43300 5 10 0 0 0 6 1
footprint=2711
T 44000 43300 5 10 0 0 0 6 1
spec=15WVDC
T 43900 43300 5 10 1 1 0 6 1
refdes=C80
T 43400 43300 5 10 1 1 0 6 1
value=47uF
}
C 42800 43200 1 0 0 gnd-1.sym
N 43100 43500 42900 43500 4
N 44000 43500 44000 43800 4
C 43700 45000 1 0 1 polarcap.sym
{
T 43500 45900 5 10 0 0 0 6 1
symversion=0.1
T 43700 45000 5 10 0 0 0 6 1
footprint=2711
T 43700 45000 5 10 0 0 0 6 1
spec=35WVDC
T 43600 45000 5 10 1 1 0 6 1
refdes=C78
T 43100 45000 5 10 1 1 0 6 1
value=6.8uF
}
N 43700 45200 43700 44400 4
C 42300 44900 1 0 0 gnd-1.sym
N 42400 45200 42800 45200 4
C 43100 42100 1 0 0 polarcap.sym
{
T 43300 43000 5 10 0 0 0 0 1
symversion=0.1
T 43100 42100 5 10 0 0 0 0 1
footprint=2711
T 43100 42100 5 10 0 0 0 0 1
spec=35WVDC
T 43200 42100 5 10 1 1 0 0 1
refdes=C82
T 43700 42100 5 10 1 1 0 0 1
value=6.8uF
}
N 44000 42300 44000 42900 4
C 43000 42000 1 0 0 gnd-1.sym
C 44900 43700 1 180 0 bypass.sym
{
T 44100 43200 5 10 1 1 0 0 1
refdes=C81
T 44900 42800 5 10 0 0 180 0 1
symversion=20131108
T 44600 43600 5 10 1 1 0 0 1
value=1uF
}
C 44800 43200 1 0 0 gnd-1.sym
C 44900 42500 1 180 0 bypass.sym
{
T 44600 42000 5 10 1 1 0 0 1
refdes=C83
T 44900 41600 5 10 0 0 180 0 1
symversion=20131108
T 44600 42400 5 10 1 1 0 0 1
value=0.1uF
T 44900 41100 5 10 0 1 180 0 1
spec=50WVDC X7R
}
C 45200 42000 1 0 1 gnd-1.sym
N 45100 42300 44900 42300 4
C 44600 45400 1 180 0 bypass.sym
{
T 44300 44900 5 10 1 1 0 0 1
refdes=C79
T 44600 44500 5 10 0 0 180 0 1
symversion=20131108
T 44300 45300 5 10 1 1 0 0 1
value=0.1uF
T 44600 44000 5 10 0 1 180 0 1
spec=50WVDC X7R
}
C 44900 44900 1 0 1 gnd-1.sym
N 44800 45200 44600 45200 4
C 48500 48500 1 0 0 resistor.sym
{
T 48700 48800 5 10 1 1 0 0 1
refdes=R43
T 48800 48300 5 10 1 1 0 0 1
value=1
}
N 48400 48600 48500 48600 4
N 48500 47800 48500 48600 4
C 46500 47000 1 0 0 resistor.sym
{
T 46700 47300 5 10 1 1 0 0 1
refdes=R44
T 46700 46700 5 10 1 1 0 0 1
value=14.7k
}
N 47400 47100 47400 48400 4
N 47400 47800 47600 47800 4
C 47600 47600 1 0 0 bypass.sym
{
T 47600 48500 5 10 0 0 0 0 1
symversion=20131108
T 47800 48100 5 10 1 1 0 0 1
refdes=C3
T 48200 47500 5 10 1 1 0 0 1
value=620pF
T 47600 48700 5 10 0 0 0 0 1
footprint=0603
T 47600 49000 5 10 0 1 0 0 1
spec=50WVDC X7R
}
C 47600 47000 1 0 0 resistor.sym
{
T 47800 47300 5 10 1 1 0 0 1
refdes=R45
T 47800 46700 5 10 1 1 0 0 1
value=4.75k
}
N 48500 47100 49400 47100 4
N 49400 47100 49400 48600 4
N 47600 47100 47400 47100 4
C 46400 46800 1 0 0 gnd-1.sym
N 49400 48600 50700 48600 4
{
T 50300 48700 5 10 1 1 0 0 1
netname=+3.3DAC
}
C 50200 47700 1 90 0 bypass.sym
{
T 49900 48500 5 10 1 1 180 0 1
refdes=C2
T 49300 47700 5 10 0 0 90 0 1
symversion=20131108
T 50400 48000 5 10 1 1 180 0 1
value=1uF
}
C 49900 47400 1 0 0 gnd-1.sym
C 47300 50200 1 0 1 gnd-1.sym
C 47200 50300 1 0 1 bypass10V.sym
{
T 47200 51200 5 10 0 0 0 6 1
symversion=20131216
T 46700 50700 5 10 1 1 0 6 1
refdes=C62
T 47300 50600 5 10 1 1 0 6 1
value=0.1uF
}
N 45700 50500 46300 50500 4
C 46100 49100 1 0 1 gnd-1.sym
N 44500 48000 44500 47600 4
N 44500 47600 45500 47600 4
N 45500 46400 45500 48200 4
{
T 44700 46500 5 10 1 1 0 0 1
netname=IBTEMP
}
C 46300 43200 1 90 0 resistor.sym
{
T 46700 44000 5 10 1 1 180 0 1
refdes=R42
T 46700 43700 5 10 1 1 180 0 1
value=4.99
}
C 46400 42300 1 90 0 bypass.sym
{
T 45500 42300 5 10 0 0 90 0 1
symversion=20131108
T 46100 43100 5 10 1 1 180 0 1
refdes=C1
T 46600 42600 5 10 1 1 180 0 1
value=1uF
}
C 46100 42000 1 0 0 gnd-1.sym
N 50700 48600 50700 46400 4
C 50700 46400 1 270 0 busripper-1.sym
N 44500 48400 44000 48400 4
C 45500 46400 1 270 0 busripper-1.sym
C 45700 50400 1 0 1 resistor.sym
{
T 45500 50700 5 10 1 1 0 6 1
refdes=R6
T 45500 50200 5 10 1 1 0 6 1
value=51.1
}
N 44800 50500 41600 50500 4
N 41600 50500 41600 49500 4
C 45700 49400 1 0 0 gp_opamp_dual_pwr.sym
{
T 45900 51400 5 8 0 0 0 0 1
symversion=1.0
T 46350 49950 5 10 1 1 0 0 1
refdes=U7
}
C 47300 48200 1 0 0 gp_opamp_dual.sym
{
T 48000 48900 5 10 1 1 0 0 1
refdes=U7
T 47600 50900 5 8 0 0 0 0 1
symversion=1.0nicer
T 47300 48200 5 10 0 0 0 0 1
slot=2
}
N 46000 50300 46000 50500 4
C 44400 47800 1 0 0 gp_opamp_dual.sym
{
T 45100 48500 5 10 1 1 0 0 1
refdes=U7
T 44700 50500 5 8 0 0 0 0 1
symversion=1.0nicer
}
T 47200 49700 9 15 1 0 0 0 1
Low Voltages
C 42300 41300 1 0 0 resistor.sym
{
T 42500 41600 5 10 1 1 0 0 1
refdes=R20
T 42600 41100 5 10 1 1 0 0 1
value=4.3
T 42900 41900 5 10 0 0 0 0 1
spec=5% 1W
T 43200 42200 5 10 0 0 0 0 1
footprint=2512
}
N 42300 41400 42200 41400 4
N 42200 41400 42200 44100 4
N 42200 44100 41500 44100 4
C 43200 41300 1 0 0 resistor.sym
{
T 43400 41600 5 10 1 1 0 0 1
refdes=R21
T 43500 41100 5 10 1 1 0 0 1
value=4.3
T 43800 41900 5 10 0 0 0 0 1
spec=5% 1W
T 44100 42200 5 10 0 0 0 0 1
footprint=2512
}
C 45000 41300 1 0 0 resistor.sym
{
T 45200 41600 5 10 1 1 0 0 1
refdes=R23
T 45300 41100 5 10 1 1 0 0 1
value=4.3
T 45600 41900 5 10 0 0 0 0 1
spec=5% 1W
T 45900 42200 5 10 0 0 0 0 1
footprint=2512
}
C 44100 41300 1 0 0 resistor.sym
{
T 44300 41600 5 10 1 1 0 0 1
refdes=R22
T 44400 41100 5 10 1 1 0 0 1
value=4.3
T 44700 41900 5 10 0 0 0 0 1
spec=5% 1W
T 45000 42200 5 10 0 0 0 0 1
footprint=2512
}
C 46800 41300 1 0 0 resistor.sym
{
T 47000 41600 5 10 1 1 0 0 1
refdes=R25
T 47100 41100 5 10 1 1 0 0 1
value=4.3
T 47400 41900 5 10 0 0 0 0 1
spec=5% 1W
T 47700 42200 5 10 0 0 0 0 1
footprint=2512
}
C 45900 41300 1 0 0 resistor.sym
{
T 46100 41600 5 10 1 1 0 0 1
refdes=R24
T 46200 41100 5 10 1 1 0 0 1
value=4.3
T 46500 41900 5 10 0 0 0 0 1
spec=5% 1W
T 46800 42200 5 10 0 0 0 0 1
footprint=2512
}
C 48600 41900 1 0 0 resistor.sym
{
T 49200 42500 5 10 0 0 0 0 1
spec=5% 1W
T 49500 42800 5 10 0 0 0 0 1
footprint=2512
T 48800 42200 5 10 1 1 0 0 1
refdes=R27
T 48900 41700 5 10 1 1 0 0 1
value=4.3
}
C 47700 41300 1 0 0 resistor.sym
{
T 48300 41900 5 10 0 0 0 0 1
spec=5% 1W
T 48600 42200 5 10 0 0 0 0 1
footprint=2512
T 47900 41600 5 10 1 1 0 0 1
refdes=R26
T 48000 41100 5 10 1 1 0 0 1
value=4.3
}
N 48600 42000 48600 41400 4
C 49500 41900 1 0 0 resistor.sym
{
T 50100 42500 5 10 0 0 0 0 1
spec=5% 1W
T 50400 42800 5 10 0 0 0 0 1
footprint=2512
T 49700 42200 5 10 1 1 0 0 1
refdes=R28
T 49800 41700 5 10 1 1 0 0 1
value=4.3
}
C 50400 41900 1 0 0 resistor.sym
{
T 51000 42500 5 10 0 0 0 0 1
spec=5% 1W
T 51300 42800 5 10 0 0 0 0 1
footprint=2512
T 50600 42200 5 10 1 1 0 0 1
refdes=R29
T 50700 41700 5 10 1 1 0 0 1
value=4.3
}
C 51200 41700 1 0 0 gnd-1.sym
T 41600 40500 9 10 1 0 0 0 2
R20-R29 are the survival heater. Arrange these in a circle around the
outside of the board to spread the heat.
