advancement revoke @s only tac:chair_place
playsound minecraft:block.wood.place block @a ~ ~ ~ 0.5 0.8

# Get facing direction
scoreboard players set dir tac.main 0
execute store success score dir tac.main if entity @s[y_rotation= -135..-45] run tag @n[type=armor_stand,tag=chair] add east
execute store success score dir tac.main if entity @s[y_rotation= -45..45] run tag @n[type=armor_stand,tag=chair] add south
execute store success score dir tac.main if entity @s[y_rotation= 45..135] run tag @n[type=armor_stand,tag=chair] add west
execute if score dir tac.main matches 0 run tag @n[type=armor_stand,tag=chair] add north
scoreboard players reset dir tac.main

# Summon Chair based on item
execute at @n[type=armor_stand,tag=chair] with entity @n[type=armor_stand,tag=chair] data:
    #$say $(type) $(mat)
    $execute as @n[type=armor_stand,tag=east] align xyz positioned ~.5 ~ ~.5 run function tac:chair/summon_chair {type:$(type),mat:$(mat),facing: 270 }
    $execute as @n[type=armor_stand,tag=south] align xyz positioned ~.5 ~ ~.5 run function tac:chair/summon_chair {type:$(type),mat:$(mat),facing: 0 }
    $execute as @n[type=armor_stand,tag=west] align xyz positioned ~.5 ~ ~.5 run function tac:chair/summon_chair {type:$(type),mat:$(mat),facing: 90 }
    $execute as @n[type=armor_stand,tag=north] align xyz positioned ~.5 ~ ~.5 run function tac:chair/summon_chair {type:$(type),mat:$(mat),facing: 180 }
    kill @n[type=armor_stand,tag=chair]