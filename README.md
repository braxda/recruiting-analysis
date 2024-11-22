# 2023 College Football Recruiting Analysis

## Project Overview
A data analysis project examining recruiting patterns of 2023-24 College Football Playoff teams (Michigan, Washington, Texas, and Alabama). 
This project uses Python to analyze geographical distribution of recruits, recruiting rankings, and other patterns.

## Data Source
- College Football Data API (CFBD)
- 247sports.com for star ratings

## Technologies Used
- Python
- pandas for data analysis
- CFBD API for college football data
- PostgreSQL for database management
- GitHub for version control

## Setup
1. Clone this repository
2. Install required packages:
   pip install -r requirements.txt***********UPDATE THIS LATER

## Process
1. Data collection via cfbd api and 247sports.com
   a. Requested roster data from cfbd and player rating data from 247sports.com
   b. Hardcoded rating data into csvs from main.py
2. Geolocate players' hometowns 
3. 