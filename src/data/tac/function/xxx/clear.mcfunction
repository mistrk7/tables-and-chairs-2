# tac:x/clear : Clears all loaded trace of T&C

execute as @e[tag=tac] run function ./zfunction/mdrn_clear
execute as @e[tag=tac.V5.0] run function ./zfunction/lgcy_clear
execute as @e[tag=tac.V5.1] run function ./zfunction/lgcy_clear
execute as @e[tag=tac.V5.2] run function ./zfunction/lgcy_clear
execute as @e[tag=tac.V5.3] run function ./zfunction/lgcy_clear

# tac:x/clear/nearest : Clears the single nearest T&C furniture
# tac:x/clear/legacy : Clears all loaded legacy T&C furniture
# tac:x/clear/modern : Clears all loaded modern T&C furniture

function ~/nearest:
    execute as @n[tag=tac] run function ./zfunction/mdrn_clear
    execute as @n[tag=tac.V5.0] run function ./zfunction/lgcy_clear
    execute as @n[tag=tac.V5.1] run function ./zfunction/lgcy_clear
    execute as @n[tag=tac.V5.2] run function ./zfunction/lgcy_clear
    execute as @n[tag=tac.V5.3] run function ./zfunction/lgcy_clear

function ~/legacy:
    execute as @e[tag=tac.V5.0] run function ./zfunction/lgcy_clear
    execute as @e[tag=tac.V5.1] run function ./zfunction/lgcy_clear
    execute as @e[tag=tac.V5.2] run function ./zfunction/lgcy_clear
    execute as @e[tag=tac.V5.3] run function ./zfunction/lgcy_clear

function ~/modern:
    execute as @e[tag=tac] run function ./zfunction/mdrn_clear