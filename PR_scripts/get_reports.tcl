reportCongestion -hotSpot    ;# report congestion
checkPlace                   ;# check placement legality
timeDesign -preCTS           ;# report timing
summaryReport                ;# report design summary

report_timing -late -net -max_slack 0.0 -nworst 1 -max_paths 1000 > ./reports/preCTS_setup_timing.rpt ;# report timing detail(setup)
report_timing -early -net -max_slack 0.0 -nworst 1 -max_paths 1000 > ./reports/preCTS_hold_timing.rpt ;# report timing detail(hold)
report_constraint -drv_violation_type {max_capacitance max_transition} -all_violators > ./reports/report_constraint.rpt ;# report drv

verify_drc -limit 9999999 -report ./reports/veryfy_drc.pg.rpt ;# report drc
verifyPowerVia -report ./reports/veryfy_PowerVia.pg.rpt ;# report power via
verifyConnectivity -report ./reports/veryfy_Connectivity.pg.rpt ;# report connectivity
