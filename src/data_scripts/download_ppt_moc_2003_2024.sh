#!/bin/bash
# Download monthly precipitation (ppt) data from TerraClimate for Montes Claros/MG (2003–2024)

# Coordenadas de Montes Claros
LAT="-16.73"
LON="-43.87"

# Variável desejada
VARIABLE="ppt"

# Caminho base para o serviço NCSS
NCSS_PATH="http://thredds.northwestknowledge.net:8080/thredds/ncss"

# Caminho relativo ao script
OUTPUT_DIR="../../data/TerraClimate/ppt_data"

# Loop sobre os anos
for YEAR in {2003..2024}; do
    echo "Downloading ${VARIABLE} for ${YEAR}..."

    FILENAME="agg_terraclimate_${VARIABLE}_1958_CurrentYear_GLOBE.nc"

    TIME_START="${YEAR}-01-01T00%3A00%3A00Z"
    TIME_END="${YEAR}-12-31T00%3A00%3A00Z"

    QUERY="${NCSS_PATH}/${FILENAME}?"
    QUERY="${QUERY}&var=${VARIABLE}"
    QUERY="${QUERY}&latitude=${LAT}&longitude=${LON}&horizStride=1"
    QUERY="${QUERY}&time_start=${TIME_START}&time_end=${TIME_END}&timeStride=1"
    QUERY="${QUERY}&addLatLon=true&accept=csv"

    OUTFILE="${OUTPUT_DIR}/terraclimate_${VARIABLE}_MOC_${YEAR}.csv"

    wget -nc -c -nd "$QUERY" -O "$OUTFILE"
done