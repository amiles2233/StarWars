#----------Star Wars!!---------------
library(devtools)
install_github("ironholds/rwars", ref = "0.5.0")
library(rwars)
library(dplyr)


#-----------Starships Data Frame---------------
get_starship_df <- function(){

# Valid Ship Number from the Get_Starship Command (exept 2)
valid_ships <- c(3,5,9,10,11,12,13, 15, 17, 21,22,23,27,28,29,31,32, 39,40,41,43,47,48,49,
                 52,58,59,61,63,64,65,66,68,74,75,77)

# Base Data Frame using Ship Number 2
ship.df <- data.frame(get_starship(2)[c(1:13)], stringsAsFactors = F)
ship.df <- tbl_df(ship.df)

# Attach all other ships into data frame
for(i in valid_ships){
    ship_i <- data.frame(get_starship(i)[c(1:13)], stringsAsFactors = F)
    ship.df <- rbind(ship.df, ship_i)
}

# Make 'unknown' and n/a missing
ship.df[ship.df=='unknown' | ship.df=='n/a'] <- NA

# Lower-case all starship class
ship.df$starship_class <- tolower(ship.df$starship_class)

# Substitute Characters out of Numeric Vars
ship.df$max_atmosphering_speed <- gsub("km","", ship.df$max_atmosphering_speed)
ship.df$length <- gsub(",", "", ship.df$length)

# Set Vars to Numeric
ship.df[,c(4:9, 11:12)] <- sapply(ship.df[,c(4:9, 11:12)], as.numeric)

# Add Total Capacity Variable
ship.df <- mutate(ship.df, ttl_capacity = crew+passengers)

# Return Data Frame
return(ship.df)
}



#-----------Planets---------------
get_planet_df <- function(){

# Get Valid Planet Numbers
valid_planets <- c(2:61)

# Base Planet Data Frame
planet.df <- data.frame(get_planet(1)[c(1:8)], stringsAsFactors = F)
planet.df <- tbl_df(planet.df)

# Attach all other planets into data frame
for(i in valid_planets){
    planet_i <- data.frame(get_planet(i)[c(1:8)], stringsAsFactors = F)
    planet.df <- rbind(planet.df, planet_i)
}

# Set Unknown and N/A to missing
planet.df[planet.df=="unknown" | planet.df=="N/A"] <- NA

# Remove Characters from Numeric Vars
planet.df$gravity <- gsub("standard","", planet.df$gravity)

# Fix Cloud City Manually
planet.df[6,6] <- 1

# Change vars to numeric
planet.df[,c(2:4,6,8)] <- sapply(planet.df[,c(2:4,6,8)], as.numeric)

return(planet.df)

}
























