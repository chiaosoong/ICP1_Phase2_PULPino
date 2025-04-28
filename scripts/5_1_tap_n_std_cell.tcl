#optimizing for hold, this command spreads the cells and should give you more space for buffers
setPlaceMode -place_global_uniform_density true -place_global_max_density 0.6
setPlaceMode -place_global_cong_effort high
setPlaceMode -place_global_reorder_scan true
setPlaceMode -place_global_timing_effort high

addWellTap -cell HS65_LH_FILLERNPWPFP4 -cellInterval 25 -prefix WELLTAP
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}

setDrawView place
setPlaceMode -fp false
placeDesign
fit
