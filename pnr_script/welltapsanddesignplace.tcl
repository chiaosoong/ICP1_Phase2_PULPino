addWellTap -cell HS65_LH_FILLERNPWPFP4 -cellInterval 25 -prefix WELLTAP
setPlaceMode -prerouteAsObs {1 2 3 4 5 6 7 8}
setDrawView place
setPlaceMode -fp false
placeDesign
fit
