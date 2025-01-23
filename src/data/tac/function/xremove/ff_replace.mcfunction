execute if entity @s[tag=chair]
    scoreboard players set @s tac.main 0
    
    execute with entity @s item.components."minecraft:custom_data":
        $execute store success score @s tac.main if entity @s[y_rotation= -135..-45] run setblock ~ ~ ~ $(mat)_stairs[facing=west]
        $execute store success score @s tac.main if entity @s[y_rotation= -45..45] run setblock ~ ~ ~ $(mat)_stairs[facing=north]
        $execute store success score @s tac.main if entity @s[y_rotation= 45..135] run setblock ~ ~ ~ $(mat)_stairs[facing=east]
        $execute if score @s tac.main matches 0 run setblock ~ ~ ~ $(mat)_stairs[facing=south]

    kill @n[type=interaction,tag=chair,distance=0..0.8]
    kill @s
    scoreboard players reset @s tac.main


# Remove from loaded list
#Test performance before and after this. Big lists may lag a lot.
#execute if entity @s[tag=chair] with entity @s:
#    data remove storage furniture.overworld["$(uuid)"]

execute if entity @s[tag=table]:
    setblock ~ ~ ~ oak_planks
    #kill @s (2x)