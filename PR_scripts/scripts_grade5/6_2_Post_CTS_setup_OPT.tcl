setOptMode -setupTargetSlack 0.02
setOptMode -fixCap true -fixTran true -fixFanoutLoad true
optDesign -postCTS -setup
