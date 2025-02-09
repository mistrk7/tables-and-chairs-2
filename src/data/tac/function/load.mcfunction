scoreboard objectives add tac.main dummy
function tac:loop

# Kill misplaced armor stands if they were placed with the pack disabled. 
kill @e[type=armor_stand, tag=tac]

data merge storage tac:main {\
    version:0,\
    convert:{\
        search_dimension:"overworld",\
        orig_playerGameType:0,\
        orig_dimension:"overworld",\
        orig_pos_0:0,\
        orig_pos_1:0,\
        orig_pos_2:0\
    }\
}

# WHEN UPDATING VERSION: Replace all instances of 'v(current version)' in the project with 'v(next version)'