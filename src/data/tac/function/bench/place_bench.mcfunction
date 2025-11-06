## Mostly copied from tac:chair/place_chair.mcfunction

advancement revoke @s only tac:bench_place
playsound minecraft:block.wood.place block @a ~ ~ ~ 0.5 0.8

# Get facing direction - east(90), south(180), west(270), north(0)
scoreboard players set dir tac.main 0
execute store success score dir tac.main if entity @s[y_rotation= -135..-45] run data modify entity @n[type=armor_stand,tag=bench] equipment.feet.components."minecraft:custom_data".rotation set value 90
execute store success score dir tac.main if entity @s[y_rotation= -45..45] run data modify entity @n[type=armor_stand,tag=bench] equipment.feet.components."minecraft:custom_data".rotation set value 180
execute store success score dir tac.main if entity @s[y_rotation= 45..135] run data modify entity @n[type=armor_stand,tag=bench] equipment.feet.components."minecraft:custom_data".rotation set value 270
execute if score dir tac.main matches 0 run data modify entity @n[type=armor_stand,tag=bench] equipment.feet.components."minecraft:custom_data".rotation set value 0
scoreboard players reset dir tac.main

# Run function to check for what state it should be in
scoreboard players set #repeat_modify tac.main 1
execute as @n[type=armor_stand,tag=bench] at @s run function ./modify_bench

# Summon Bench based on item
execute at @n[type=armor_stand,tag=bench] with entity @n[type=armor_stand,tag=bench] equipment.feet.components."minecraft:custom_data":
    $say $(state) $(rotation)
    $execute align xyz positioned ~.5 ~ ~.5 run function tac:bench/summon_bench {type:$(type),mat:$(mat),state:$(state),facing:$(rotation)}
    # tag poles are reversed ^^
    kill @n[type=armor_stand,tag=bench]