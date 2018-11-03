*.lib '../models/PTM-MG/models' ptm20lstp

.option ingold=1
.subckt nfet d g s x l=lg nfin=1
.include 'modelfiles/lstp/20nfet.pm'
mnfet d g s x nfet L=l NFIN=nfin
.ends nfet

.subckt pfet d g s x l=lg nfin=1
.include 'modelfiles/lstp/20pfet.pm'
mpfet d g s x pfet L=l NFIN=nfin
.ends pfet

.lib 'param.inc' 20nm

.param vdd=0.8
.temp 25

V1 N001 0 vdd
V2 N004 0 0
E1 N005 0 N004 0 0.7071
E2 N003 N005 N002 0 0.7071
E4 N002 N006 Vout 0 1.414
E3 N006 0 N004 0 1
V3 N007 0 vdd
E5 N010 0 N004 0 -0.7071
E6 N009 N010 N008 0 0.7071
E7 N008 N011 Vout2 0 1.414
E8 N011 0 N004 0 -1
*X2 N001 N003 Vout N001 pfet nfin=2
*X4 N007 N009 Vout2 N007 pfet nfin=2
X2 Vout N003 N001 N001 pfet nfin=2
X4 Vout2 N009 N007 N007 pfet nfin=2
X1 Vout N003 0 0 nfet nfin=2
X3 Vout2 N009 0 0 nfet nfin=2
.dc V2 -0.7071*vdd 0.7071*vdd 0.01
*.print dc V(vout) V(vout2) V(n002) V(n008) V(n003) V(n009)
.print dc SNMCurve V(N002,N008)
.meas dc SNM1 MAX V(N002,N008)
.meas SNM2 MIN V(N002,N008)
*.meas SNM MIN (SNM1,SNM2)
*.meas dc vtwo v(N008)
*.meas dc vdiff vone-vtwo

.alter 
.param vdd=1.1
.temp 25

.alter
.param vdd=0.8
.temp 125

.alter
.param vdd=1.1
.temp 125

*.backanno
.end
