setOptMode -setupTargetSlack 0.05
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS -setup
