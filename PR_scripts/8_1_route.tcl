

#Special Route (GND VDD)
sroute -connect { blockPin padPin corePin floatingStripe } -layerChangeRange { M1(1) AP(8) } -blockPinTarget { nearestTarget } -padPinPortConnect { allPort oneGeom } -padPinTarget { nearestTarget } -corePinTarget { firstAfterRowEnd } -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } -allowJogging 1 -crossoverViaLayerRange { M1(1) AP(8) } -nets { VDD GND } -allowLayerChange 1 -blockPin useLef -targetViaLayerRange { M1(1) AP(8) }

#Route Signal Nets
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false
routeDesign -globalDetail

verify_drc -limit 9999999 -report ./reports/veryfy_drc.pg.rpt ;# report drc
verifyPowerVia -report ./reports/veryfy_PowerVia.pg.rpt ;# report power via
verifyConnectivity -report ./reports/veryfy_Connectivity.pg.rpt ;# report connectivity
checkPlace                   ;# check placement legality

setAnalysisMode -analysisType onChipVariation -cppr both

