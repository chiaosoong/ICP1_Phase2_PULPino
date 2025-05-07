setOptMode -fixCap true -fixTran true -fixFanoutLoad true
setOptMode -holdTargetSlack 0.05
setOptMode -holdFixingEffort high
optDesign -postRoute -hold
