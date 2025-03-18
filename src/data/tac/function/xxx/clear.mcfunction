# tac:x/clear : Clears all loaded trace of T&C
scoreboard players set destroy-count tac.main 0

execute as @e[tag=tac] at @s run function ./zfunction/mdrn_clear
execute as @e[tag=tac.V5.0] at @s run function ./zfunction/lgcy_clear
execute as @e[tag=tac.V5.1] at @s run function ./zfunction/lgcy_clear
execute as @e[tag=tac.V5.2] at @s run function ./zfunction/lgcy_clear
execute as @e[tag=tac.V5.3] at @s run function ./zfunction/lgcy_clear
function ./zfunction/ztext_end

# tac:x/clear/nearest : Clears the single nearest T&C furniture
# tac:x/clear/legacy : Clears all loaded legacy T&C furniture
# tac:x/clear/modern : Clears all loaded modern T&C furniture

function ~/nearest:
    execute as @n[tag=tac] at @s run function ./zfunction/mdrn_clear
    execute as @n[tag=tac.V5.0] at @s run function ./zfunction/lgcy_clear
    execute as @n[tag=tac.V5.1] at @s run function ./zfunction/lgcy_clear
    execute as @n[tag=tac.V5.2] at @s run function ./zfunction/lgcy_clear
    execute as @n[tag=tac.V5.3] at @s run function ./zfunction/lgcy_clear
    function ./zfunction/ztext_end

function ~/legacy:
    execute as @e[tag=tac.V5.0] at @s run function ./zfunction/lgcy_clear
    execute as @e[tag=tac.V5.1] at @s run function ./zfunction/lgcy_clear
    execute as @e[tag=tac.V5.2] at @s run function ./zfunction/lgcy_clear
    execute as @e[tag=tac.V5.3] at @s run function ./zfunction/lgcy_clear
    function ./zfunction/ztext_end

function ~/modern:
    execute as @e[tag=tac] at @s run function ./zfunction/mdrn_clear
    function ./zfunction/ztext_end