# 2023 College Football Recruiting Analysis

## Project Overview
A data analysis project examining recruiting patterns of 2023-24 College Football Playoff teams (Michigan, Washington, Texas, and Alabama). 
This project uses Python to analyze geographical distribution of recruits, recruiting rankings, and other patterns.

## Data Source
- College Football Data API (CFBD)
- 247sports.com for star ratings
- Nominatim for geocoding
- -OpenRouteService for isochrones

## Technologies Used
- IDE - PyCharm
- pandas for data analysis
- CFBD API for college football data
- PostgreSQL for running queries and managing data
- GitHub for version control
- QGIS for geospatial analysis
- CartoDB Positron for basemap in GIS project

## Python Setup
- pip install -r requirements.txt***********UPDATE THIS LATER
- Request API Key from https://collegefootballdata.com/key
- Configure API Key

## GIS Setup
- Download .qgz file from gis/qgis directory
- Download .gpkg file from gis/data directory
- Open .qgz file and set up a connection to the .gpkg to view layers

## Process
1. Data collection via cfbd api and 247sports.com (main.py)
   i. Requested roster data from cfbd and player rating data from 247sports.com
   ii. Hardcoded rating data into csvs from main.py
2. Geolocate players' hometowns with geopy (geocode.py)
3. Basic data cleaning before importing to Postgres (sql_import.py)
4. Ran SQL queries on data for insights on each school's ability to recruit various player types from across the world (sql directory)
5. Imported layer data into a GIS project
   i. Format layer data, created calculated fields that will be used for analysis

   ii. Connected players to their schools with geodesic lines

   iii. Created 1-hour isochrones for each school

   iv. Create heatmap for recruits country-wide

   v. Found the mean distance of recruits from each school

   vi. Used the mean distance to create standard deviation ellipses showing how each school recruited