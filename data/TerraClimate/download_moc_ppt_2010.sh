#!/bin/bash
# TEST
# GOAL: Download TerraClimate precipitation data (ppt) for Montes Claros/MG in 2010
# Author: Adapted by ChatGPT (original: Katherine Hegewisch)

#==========================================
#        PARAMETERS
#==========================================
# Point location (Montes Claros/MG)
LATS=("-16.73")       
LONS=("-43.87")     

# Variable: precipitation
VARIABLES=("ppt") 

# Time range: 2010 only
TIME_START="2010-01-01T00%3A00%3A00Z"
TIME_END="2010-12-31T00%3A00%3A00Z"
#==========================================
#       DOWNLOAD REQUESTS
#==========================================
ncssPath="http://thredds.northwestknowledge.net:8080/thredds/ncss"

for i in "${!LATS[@]}"; do 
	lat="${LATS[$i]}"
	lon="${LONS[$i]}"
	for variable in "${VARIABLES[@]}"
	do
		# Dataset filename pattern for NCSS access
		filename="agg_terraclimate_${variable}_1958_CurrentYear_GLOBE.nc"
		
		# Query string for the NCSS request
		queryString="$ncssPath/${filename}?"
		queryString="$queryString&var=${variable}"
		queryString="$queryString&latitude=${lat}&longitude=${lon}&horizStride=1"
		queryString="$queryString&time_start=${TIME_START}&time_end=${TIME_END}&timeStride=1"
		queryString="$queryString&addLatLon=true&accept=csv"

		echo "Downloading: $queryString"

		# Output filename
		newfilename="terraclimate_${variable}_MOC_2010.csv"
		wget -nc -c -nd "$queryString" -O "$newfilename"
	done
done