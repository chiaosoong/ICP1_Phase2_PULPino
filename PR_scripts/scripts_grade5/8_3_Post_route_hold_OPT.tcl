setOptMode -fixCap true -fixTran true -fixFanoutLoad false
setOptMode -holdTargetSlack 0.06
setOptMode -holdFixingEffort high
optDesign -postRoute -hold
