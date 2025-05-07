setOptMode -fixCap true -fixTran true -fixFanoutLoad true
setOptMode -holdTargetSlack 0.1
setOptMode -holdFixingEffort high
optDesign -postCTS -hold
