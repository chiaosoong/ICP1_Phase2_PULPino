setOptMode -fixCap false -fixTran false -fixFanoutLoad false
setOptMode -holdTargetSlack 0.5
optDesign -postCTS -hold -incr
