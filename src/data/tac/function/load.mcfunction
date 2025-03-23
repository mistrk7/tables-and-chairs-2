scoreboard objectives add tac.main dummy
function tac:loop

# Kill misplaced armor stands if they were placed with the pack disabled. 
kill @e[type=armor_stand, tag=tac]

#Add table and chair counters (version 0.1 and onward)W

data merge storage tac:main {\
    version:0,\
    destroyCount:0,\
    objectCount:0\
}

# Old version detection and suggestion
schedule function ~/detect_old 1s:
    execute if entity @e[limit=1, tag=tac.V5.0] run tellraw @a ["",{"text":"[T&C2]: "},{"text":"Old & broken Tables & Chairs detected. ","color":"yellow"},{"text":"Click Here","color":"aqua","clickEvent":{"action":"suggest_command","value":"/function tac:xxx/upgrade"}},{"text":" for the command to upgrade those that are in loaded chunks, or click ","color":"yellow"},{"text":"here","color":"aqua","clickEvent":{"action":"suggest_command","value":"/function tac:xxx/clear/legacy"}},{"text":" to delete them. ","color":"yellow"}]

# WHEN UPDATING VERSION: Replace all instances of 'v(current version)' in the project with 'v(next version)'