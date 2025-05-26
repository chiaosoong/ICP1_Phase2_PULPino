#optimizing for hold, this command spreads the cells and should give you more space for buffers
setPlaceMode -place_global_uniform_density true -place_global_max_density 0.6
setPlaceMode -place_global_cong_effort high
setPlaceMode -place_global_reorder_scan true
setPlaceMode -place_global_timing_effort high

# Placement blockage
deletePlaceBlockage -type hard 
deletePlaceBlockage -type partial

#createFence pulpino_top_i/core_region_i {100 1400 1485 2590}
#createPlaceBlockage -type hard                -box {110 3113 3500 3500}
createPlaceBlockage -type partial -density 30 -box {118 2399 3500 3500}

addWellTap -cell HS65_LH_FILLERNPWPFP4 -cellInterval 100 -prefix WELLTAP
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}

setDrawView place
setPlaceMode -fp false
placeDesign
fit
