setAnalysisMode -analysisType onChipVariation -cppr both

#setup
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -idealClock -pathReports -drvReports -slackReports -numPaths 50 -prefix pulpino_padstop_preCTS -outDir timingReports

#hold
redirect -quiet {set honorDomain [getAnalysisMode -honorClockDomains]} > /dev/null
timeDesign -preCTS -hold -idealClock -pathReports -slackReports -numPaths 50 -prefix pulpino_padstop_preCTS -outDir timingReports
