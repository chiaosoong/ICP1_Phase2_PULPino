#optimizing for hold, this command spreads the cells and should give you more space for buffers
setPlaceMode -place_global_uniform_density true -place_global_max_density 0.4
setPlaceMode -place_global_cong_effort high
setPlaceMode -place_global_reorder_scan true
setPlaceMode -place_global_timing_effort high

# Placement blockage
#createPlaceBlockage -type paetial -density 50 -box {}
createPlaceBlockage -type partial -density 30 -box {138.258 1253.276 1979.767 1977.106}

addWellTap -cell HS65_LH_FILLERNPWPFP4 -cellInterval 25 -prefix WELLTAP
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}

setDrawView place
setPlaceMode -fp false
placeDesign
fit
