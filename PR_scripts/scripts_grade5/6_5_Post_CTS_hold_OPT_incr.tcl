setOptMode -fixCap false -fixTran false -fixFanoutLoad false
setOptMode -holdTargetSlack 0.01
optDesign -postCTS -hold -incr
