setOptMode -fixCap false -fixTran false -fixFanoutLoad false
setOptMode -holdTargetSlack 0.05
setOptMode -holdFixingEffort high
optDesign -postRoute -hold -incr
