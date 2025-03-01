execute if entity @s[tag=chair]
    scoreboard players set @s tac.main 0
    
    execute with entity @s item.components."minecraft:custom_data":
        $execute store success score @s tac.main if entity @s[y_rotation= -135..-45] run setblock ~ ~ ~ $(mat)_stairs[facing=west]
        $execute store success score @s tac.main if entity @s[y_rotation= -45..45] run setblock ~ ~ ~ $(mat)_stairs[facing=north]
        $execute store success score @s tac.main if entity @s[y_rotation= 45..135] run setblock ~ ~ ~ $(mat)_stairs[facing=east]
        $execute if score @s tac.main matches 0 run setblock ~ ~ ~ $(mat)_stairs[facing=south]
        scoreboard players add destroy-count tac.main 1
        scoreboard players remove chairs tac.main 1

    kill @s
    execute as @n[tag=chair,distance=0..0.8] run function ./
    scoreboard players reset @s tac.main

execute if entity @s[tag=table]:
    execute with entity @s item.components."minecraft:custom_data":
        $setblock ~ ~ ~ $(mat)_trapdoor[half=top]
        #scoreboard players add destroy-count tac.main 1
        scoreboard players remove tables tac.main 1

    kill @s
    kill @n[tag=table,distance=0..0.8]

