setOptMode -fixCap true -fixTran true -fixFanoutLoad true
setOptMode -setupTargetSlack 0.05
optDesign -postRoute -setup -drv
