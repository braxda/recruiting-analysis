# 2023 College Football Recruiting Analysis

## Project Overview
A data analysis project examining recruiting patterns of 2023-24 College Football Playoff teams (Michigan, Washington, Texas, and Alabama). 
This project uses Python to analyze geographical distribution of recruits, recruiting rankings, and other patterns.

## Data Source
- College Football Data API (CFBD)
- 247sports.com for star ratings
- Nominatim for geocoding

## Technologies Used
- IDE - PyCharm
- pandas for data analysis
- CFBD API for college football data
- PostgreSQL for running queries and managing data
- GitHub for version control
- QGIS for geospatial analysis

## Python Setup
- pip install -r requirements.txt***********UPDATE THIS LATER
- Request API Key from https://collegefootballdata.com/key
- Configure API Key

## GIS Setup
- Download .qgz file from gis/qgis directory
- Download .gpkg file from gis/data directory
- Open .qgz file and add .gpkg to view layers

## Process
1. Data collection via cfbd api and 247sports.com (main.py)
   a. Requested roster data from cfbd and player rating data from 247sports.com
   b. Hardcoded rating data into csvs from main.py
2. Geolocate players' hometowns with geopy (geocode.py)
3. Basic data cleaning before importing to Postgres (sql_import.py)
4. Ran SQL queries on data for insights on each school's ability to recruit various player types from across the world (sql directory)
5. Imported data into a .gpkg and created GIS project file to visualize data