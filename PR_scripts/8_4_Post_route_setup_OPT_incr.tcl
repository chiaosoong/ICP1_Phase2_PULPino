setOptMode -fixCap false -fixTran false -fixFanoutLoad false
setOptMode -setupTargetSlack 0.05
optDesign -postRoute -setup -incr
