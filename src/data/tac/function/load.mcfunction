scoreboard objectives add tac.main dummy
function tac:loop

# Kill misplaced armor stands if they were placed with the pack disabled. 
kill @e[type=armor_stand, tag=tac]

#Add table and chair counters (version 0.1 and onward)W

data merge storage tac:main {\
    version:0\
}

# WHEN UPDATING VERSION: Replace all instances of 'v(current version)' in the project with 'v(next version)'