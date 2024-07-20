### README for Munich Air Quality Analysis Project for course ESM

This project involves analyzing air quality data, specifically NO2 concentrations, collected from various monitoring stations in Munich. The project aims to visualize the data, understand its correlation with traffic, and generate a pollution concentration map.

### MATLAB Scripts

1. **visualizeNO2Data.m**: 
   - Purpose: Visualizes NO2 concentrations over time at five monitoring stations in Munich.
   - Key Functions: Processes multiple CSV files, converts NO2 data to ppb, and generates a line plot.

2. **processMultipleCSVFiles.m**:
   - Purpose: Reads and processes CSV files containing NO2 data from various stations.
   - Key Functions: Prompts user to select CSV files, reads data, ensures consistent time periods across files, and compiles the data into a single table.

3. **mappingNo2.m**:
   - Purpose: Generates an interpolated concentration map of NO2 for Munich.
   - Key Functions: Reads NO2 data, calculates average concentrations, performs IDW interpolation, and integrates the data with the `DisplayMunichMap` function.

4. **DisplayMunichMap.m**:
   - Purpose: Displays an interactive map of Munich with overlaid pollution data.
   - Key Functions: Sets map center and zoom level, plots a grid and pollution data, and marks station locations.

5. **Traffic.m**:
   - Purpose: Processes and analyzes traffic data.
   - Note: This script requires further details on its implementation.

### Data Files

- **traffic.csv**: Contains traffic data (number of cars per hour) for selected stations.
- **NO2Database**: Data for NO2 concentration at different locations.


## Instructions

1. **visualizeNO2Data.m**:
   - Run this script to visualize NO2 concentrations. It will prompt you to select the CSV files containing the data.

2. **processMultipleCSVFiles.m**:
   - This script will be called by `visualizeNO2Data.m` to process the selected CSV files.

3. **mappingNo2.m**:
   - Run this script to generate an interpolated NO2 concentration map. Ensure you have the required CSV files in the specified directory (`./NO2Database/`).

4. **DisplayMunichMap.m**:
   - This script will be called by `mappingNo2.m` to display the interactive map.

