# tac:x/upgrade : upgrades all loaded T&C1 with the new version (T&C2)
scoreboard players set destroy-count tac.main 0
scoreboard players set #is-destroying tac.main 1

execute as @e[tag=tac.V5.0] at @s run function ./zfunction/lgcy_upgrade
execute as @e[tag=tac.V5.1] at @s run function ./zfunction/lgcy_upgrade
execute as @e[tag=tac.V5.2] at @s run function ./zfunction/lgcy_upgrade
execute as @e[tag=tac.V5.3] at @s run function ./zfunction/lgcy_upgrade
clear @p minecraft:jungle_trapdoor[minecraft:custom_model_data,minecraft:custom_data,minecraft:lore]
function ./zfunction/ztext_end

# tac:x/upgrade/legacy : upgrades nearest T&C1 with the new version (T&C2)

function ~/nearest:
    execute as @n[tag=tac.V5.0] at @s run function ./zfunction/lgcy_upgrade
    execute as @n[tag=tac.V5.1] at @s run function ./zfunction/lgcy_upgrade
    execute as @n[tag=tac.V5.2] at @s run function ./zfunction/lgcy_upgrade
    execute as @n[tag=tac.V5.3] at @s run function ./zfunction/lgcy_upgrade
    clear @p minecraft:jungle_trapdoor[minecraft:custom_model_data,minecraft:custom_data,minecraft:lore]
    function ./zfunction/ztext_end