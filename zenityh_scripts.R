file.exists("C:/Users/Femi/Documents")
dir.create("C:/Users/Femi/Documents")
if(!file.exists("Zenith")) {
  dir.create("Zenith")
  
}


#Google Geocoding
Sys.setenv(GOOGLEGEOCODE_API_KEY= "AIzaSyDA_XjEWNXWmiJWqDWPFy6T_AaWpvTd4a4")

#Geocode Zenith Branch
geo_code_tbl <- zen_ith_branches %>%
  tidygeocoder::geocode(
    address = ADDRESS,
    method ="google"
  )
View(geo_code_tbl)

zen_ith_branches2 <- geo_code_tbl
zen_ith_branches_sf <- zen_ith_branches2 %>%
  st_as_sf(
    coords = c("long", "lat"),
    crs    = 4326
  )


#mapview(zen_ith_branches_sf)
zen_ith_branches_sf %>%
  leaflet() %>%
  #addProviderTiles (providers$Esri.worldImagery, group = "world Imagery") %>%
  addProviderTiles (providers$OpenStreetMap, group = "OpenStreetMap") %>%
  #addLayersControl (baseGroups = c("Toner Lite", "world Imagery")) %>%
  addMarkers (label = zen_ith_branches_sf$LOCATION,
              clusterOptions = markerClusterOptions(),
              popup = ifelse(!is.na(zen_ith_branches_sf$CITY),
                             zen_ith_branches_sf$CITY,
                             "Not sure of the market's location"))

mapview(zen_ith_branches_sf)


#zen_ith_branches_sf %>%
 # report (
  #  target      = "zen_ith_branches_sf$LOCATION", 
   # output_dir  = "C:/Users/Femi/Documents",
    #output_file =  "zen_ith_branches_sf_plots_html"
  #)
    
