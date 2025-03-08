# 2023 College Football Recruiting Analysis

## Project Overview
A data analysis project examining recruiting patterns of 2023-24 College Football Playoff teams (Michigan, Washington, Texas, and Alabama). 
This project uses Python, SQL, Tableau, and GIS tools to visualize the geographical distribution of recruits, and analyze various trends in the makeup of playoff team rosters.

## Data Source
- College Football Data API (CFBD)
- 247sports.com for star ratings
- Nominatim for geocoding
- OpenRouteService for isochrones
- https://www2.census.gov/geo/tiger/TIGER2023/CBSA/ for Metropolitan area layer
- HTML5UP.net - Photon for HTML template

## Technologies Used
- IDE - PyCharm
- pandas for data analysis
- CFBD API for college football data
- PostgreSQL for running queries and managing data
- GitHub for version control
- QGIS for geospatial analysis
- CartoDB Positron for basemap in GIS project
- Tableau for data visualization

## Process
1. Request API Key from https://collegefootballdata.com/key
2. Player data via cfbd api and star rating data via 247sports.com (main.py)
3. Geolocate players' hometowns with geopy (geocode.py)
4. Basic data cleaning before importing to Postgres (sql_import.py)
5. Ran SQL queries on data for insights on each school's ability to recruit various player types from across the world (sql directory)
6. Imported layer data into a GIS project
   i. Format layer data, created calculated fields that will be used for analysis

   ii. Connected players to their schools with geodesic lines

   iii. Created 1-hour isochrones for each school

   iv. Create heatmap for recruits country-wide

   v. Found the mean distance of recruits from each school

   vi. Used the mean distance to create standard deviation ellipses showing how each school recruited

   vii. Use census data to join players into metropolitan regions

   viii. Use vector analysis tools to find the per team count of players, average star ratings, and totals stars for each region

   ix. Created a competition metric based on those numbers to show which metro regions were most competitive 
       a. formula: competition_metric = (teams_per_metro/4) * (metro_total_players) * (metro_avg_stars/3)

   x. Created a success metric showing how successful each team was at recruiting in each metro
7. Imported GIS data into Tableau to create recruiting visualizations for each team
8. Downloaded HTML template off of HTML5UP and imported into IDE and repository for editing
9. Imported data into ArcGIS Online for webpage display. Ran into issues displaying my QGIS project as a webmap with the proper symbology.

## Key Findings
From the data, two broad recruiting strategies emerged among the 2023 College Football Playoff teams. Michigan and Washington cast a wide net, recruiting players from across the country, while Texas and Alabama prioritized local talent, leveraging their proximity to elite high school football hotbeds.

1. Regional Recruiting Patterns
- Texas and Alabama’s home-field advantage in recruiting was evident, with 73 percent of Texas' roster coming from in-state recruiting, and 67% percent of Alabama's roster coming from states with high-density pipelines such as Texas, Georgia, Alabama, and Florida. These areas consistently produce top-tier high school talent, allowing Texas and Alabama to take advantage of these talent pipelines and not over-expend on resources to bring in highly sought-after prospects. The Recruiting Footprint Map shows just how concentrated Texas and Alabama's recruiting efforts were to the southern portion of the United States. 
- Michigan and Washington, by contrast, had to recruit more nationally due to a relative lack of elite in-state talent. Michigan pulled from all across the country, including Illinois, California, and the Northeast Corridor.  Washington recruited mainly across the West Coast and Texas with only 6 percent of their players coming from east of the Mississippi River. That being said, these two schools were able to find quite a bit of home-grown talent, as 23 percent of Michigan's roster is composed of in-state players, and Washington having 25 players whose hometowns were within a one-hour driving radius of the university.
2. Quality vs. Distance: Stars vs. Spread
- The data showed a correlation between recruiting proximity and player rating. Texas and Alabama, with their more localized approach, landed a higher proportion of four- and five-star recruits. 46 percent of Texas' players and 52 percent of Alabama's players were blue-chip prospects.
- Michigan and Washington, by recruiting from a wider area, took a more balanced approach, bringing in talent from diverse regions. This led to a dramatic difference in the average star rating, and overall volume of highly rated prospects. These two schools combined only had five 5-star recruits on their rosters, while Texas had 14, and Alabama had 34 alone. 
3. Team Experience Levels
- As I found from Queries #4 and #8 in my SQL Folder, Michigan had by far the most experienced roster, as 73% of their players were upper-classmen, with the offensive and defensive lines being the two most experienced postition groups on the team.
- Washington had the least experienced team on average, and had the highest percentage of freshmen on the team, totaling 23 percent of players. Their experience was mostly concentrated at the tight end and running back positions.
- Texas and Alabama had very similar experience profiles, given that 55 percent of both teams' players were upper-classmen, and freshmen composed 15 percent and 17 percent of their rosters respectively. As shown in Query #10 in my SQL Folder, both Texas and Alabama had their highly-rated recruits distributed evenly across their age groups, as 49 percent of Texas' blue chip players were upper-classmen, and 52 percent of Alabama's were upper-classmen 
4. Positional Recruiting Priorities
- Query #8 shows that Michigan built their roster around the offensive and defensive lines. Not only are these the two most experienced position groups on the team, they are also the two groups with the highest average star ratings.
- Washington built their roster around a veteran quarterback and offensive weapons, with their top 3 highest average star ratings for position groups being at running back, offensive line, and wide receiver.
- Texas had a highly-recruited quarterback, and stacked their offensive and defensive lines with talent in a similar fashion to Michigan
-  Alabama focused heavily on defensive front seven recruiting, prioritizing elite defensive line and linebacker prospects. The 14 players on Alabama's defensive line had a staggering average star rating of 3.9, by far the highest of any team's single position group. 
5. Final Takeaways
The recruiting strategies of the 2023 College Football Playoff teams reflected their geographic advantages and long-term roster-building approaches. Texas and Alabama leveraged their proximity to elite high school football hotbeds, securing higher-rated players without needing to recruit nationally. Michigan and Washington, lacking that same local talent density, were forced to take a more national approach, spreading their resources across the country to build competitive rosters.
Beyond geography, experience levels and position prioritization played a crucial role in each team’s makeup. How a team targets and develops certain position groups often outlines a coaching philosophy and defines the playstyle of the team.
These differences in approach highlight how different recruiting philosophies can lead to success, whether through regional dominance or a broader, more national talent pipeline.
