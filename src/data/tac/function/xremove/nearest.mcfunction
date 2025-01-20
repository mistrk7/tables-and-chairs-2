execute as @n[type=item_display, tag=tac] at @s:
    execute if entity @s[tag=chair] with entity @s item.components."minecraft:custom_data":
        scoreboard players set @s tac.main 0
        execute store success score @s tac.main if entity @s[y_rotation= -135..-45] run setblock ~ ~ ~ oak_stairs[facing=west]
        $execute store success score @s tac.main if entity @s[y_rotation= -135..-45] run setblock ~ ~ ~ $(mat)_stairs[facing=west]
        
        execute store success score @s tac.main if entity @s[y_rotation= -45..45] run setblock ~ ~ ~ oak_stairs[facing=north]
        $execute store success score @s tac.main if entity @s[y_rotation= -45..45] run setblock ~ ~ ~ $(mat)_stairs[facing=north]
        
        execute store success score @s tac.main if entity @s[y_rotation= 45..135] run setblock ~ ~ ~ oak_stairs[facing=east]
        $execute store success score @s tac.main if entity @s[y_rotation= 45..135] run setblock ~ ~ ~ $(mat)_stairs[facing=east]
        
        execute if score @s tac.main matches 0 run setblock ~ ~ ~ oak_stairs[facing=south]
        $execute if score @s tac.main matches 0 run setblock ~ ~ ~ $(mat)_stairs[facing=south]

        
        scoreboard players reset @s tac.main
        kill @n[type=interaction,tag=chair,distance=0..0.8]
        kill @s
    execute if entity @s[tag=table]:
        setblock ~ ~ ~ oak_planks
        #kill @s (2x)