setOptMode -fixCap true -fixTran false -fixFanoutLoad false
setOptMode -setupTargetSlack 0.02
optDesign -postCTS -setup -incr
