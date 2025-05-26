setOptMode -fixCap true -fixTran true -fixFanoutLoad false
setOptMode -setupTargetSlack 0.05
optDesign -postRoute -setup -incr
