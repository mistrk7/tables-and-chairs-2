# tac:x/upgrade : upgrades all loaded T&C1 with the new version (T&C2)
execute as @e[tag=tac.V5.0] run function ./zfunction/lgcy_upgrade
execute as @e[tag=tac.V5.1] run function ./zfunction/lgcy_upgrade
execute as @e[tag=tac.V5.2] run function ./zfunction/lgcy_upgrade
execute as @e[tag=tac.V5.3] run function ./zfunction/lgcy_upgrade
clear @p minecraft:jungle_trapdoor[minecraft:custom_model_data,minecraft:custom_data,minecraft:lore]

# tac:x/upgrade/legacy : upgrades nearest T&C1 with the new version (T&C2)

function ~/nearest:
    execute as @n[tag=tac.V5.0] run function ./zfunction/lgcy_upgrade
    execute as @n[tag=tac.V5.1] run function ./zfunction/lgcy_upgrade
    execute as @n[tag=tac.V5.2] run function ./zfunction/lgcy_upgrade
    execute as @n[tag=tac.V5.3] run function ./zfunction/lgcy_upgrade
    clear @p minecraft:jungle_trapdoor[minecraft:custom_model_data,minecraft:custom_data,minecraft:lore]