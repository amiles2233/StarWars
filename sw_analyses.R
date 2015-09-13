#----------Analysis--------------
library(ggplot2)
library(scales)

#----------Load Data-------------
source(sw_df_convert)
ship.df <- get_starship_df()
planet.df <- get_planet_df()



#----------Ships---------------

# Divide Cost variable by 1m credits to make it more manageable
ship.df$cost_in_credits <- ship.df$cost_in_credits/1000000

# Drop the Death Star (its more of a moon than a starship) & Executor 
ship.df <- filter(ship.df, name!="Death Star")
ship.df <- filter(ship.df, name!="Executor")

# Hyperdrive Rating vs Total Capacity
ggplot(ship.df, aes(ttl_capacity, hyperdrive_rating, geom="text", label=name)) +
    geom_text(hjust=0) +
    ggtitle("Hyperdrive Rating vs Total Capacity") +
    xlab("Total Capacity") +
    ylab("Hyperdrive Rating") +
    scale_x_continuous(labels=comma)

# Hyperdrive Rating vs. Cost
ggplot(ship.df, aes(cost_in_credits, hyperdrive_rating, geom="text", label=name)) +
    geom_text(hjust=0) +
    ggtitle("Hyperdrive Rating vs Total Cost") +
    xlab("Cost (Millions of Credits)") +
    ylab("Hyperdrive Rating") +
    scale_x_continuous(labels=comma)


#--------Planets---------------

# Orbital Period vs Gravity
ggplot(planet.df, aes(orbital_period, gravity, label=name)) +
    geom_text() +
    scale_x_continuous(labels=comma) +
    ggtitle("Orbital Period vs Gravity") +
    xlab("Orbital Period (Standard Days)") +
    ylab("Gravity (Relative to Standard)")

