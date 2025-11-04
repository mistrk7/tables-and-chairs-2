## Mostly copied from tac:chair/place_chair.mcfunction

advancement revoke @s only tac:bench_place
playsound minecraft:block.wood.place block @a ~ ~ ~ 0.5 0.8

# Get facing direction
scoreboard players set dir tac.main 0
execute store success score dir tac.main if entity @s[y_rotation= -135..-45] run tag @n[type=armor_stand,tag=bench] add east
execute store success score dir tac.main if entity @s[y_rotation= -45..45] run tag @n[type=armor_stand,tag=bench] add south
execute store success score dir tac.main if entity @s[y_rotation= 45..135] run tag @n[type=armor_stand,tag=bench] add west
execute if score dir tac.main matches 0 run tag @n[type=armor_stand,tag=bench] add north
scoreboard players reset dir tac.main

# Run function to check for what state it should be in
scoreboard players set #repeat_modify tac.main 1
execute as @n[type=armor_stand,tag=bench] at @s run function ./modify_bench

# Summon Bench based on item
execute at @n[type=armor_stand,tag=bench] with entity @n[type=armor_stand,tag=bench] data:
    #$say $(type) $(mat)
    $execute as @n[type=armor_stand,tag=west] align xyz positioned ~.5 ~ ~.5 run function tac:bench/summon_bench {type:$(type),mat:$(mat),state:$(state),facing: 270 }
    $execute as @n[type=armor_stand,tag=north] align xyz positioned ~.5 ~ ~.5 run function tac:bench/summon_bench {type:$(type),mat:$(mat),state:$(state),facing: 0 }
    $execute as @n[type=armor_stand,tag=east] align xyz positioned ~.5 ~ ~.5 run function tac:bench/summon_bench {type:$(type),mat:$(mat),state:$(state),facing: 90 }
    $execute as @n[type=armor_stand,tag=south] align xyz positioned ~.5 ~ ~.5 run function tac:bench/summon_bench {type:$(type),mat:$(mat),state:$(state),facing: 180 }
    # tag poles are reversed ^^
    kill @n[type=armor_stand,tag=bench]