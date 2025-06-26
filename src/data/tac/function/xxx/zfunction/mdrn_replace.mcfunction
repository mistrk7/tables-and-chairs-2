execute at @s[tag=chair]:
    scoreboard players set @s tac.main 0

    # Replace the chair with stairs
    execute as @n[tag=chair,type=item_display,distance=0..0.8]:
        execute with entity @s item.components."minecraft:custom_data":
            $execute store success score @s tac.main if entity @s[y_rotation= -135..-45] run setblock ~ ~ ~ $(mat)_stairs[facing=west]
            $execute store success score @s tac.main if entity @s[y_rotation= -45..45] run setblock ~ ~ ~ $(mat)_stairs[facing=north]
            $execute store success score @s tac.main if entity @s[y_rotation= 45..135] run setblock ~ ~ ~ $(mat)_stairs[facing=east]
            $execute if score @s tac.main matches 0 run setblock ~ ~ ~ $(mat)_stairs[facing=south]
            
    # Destroy the chair
    execute as @n[tag=chair,type=interaction,distance=0..0.8]:
        function tac:chair/break_chair/action/destroy
        scoreboard players add destroy-count tac.main 1

    scoreboard players reset @s tac.main

execute at @s[tag=table]:

    # Replace the table with planks
    execute with entity @n[tag=table,type=item_display,distance=0..0.8] item.components."minecraft:custom_data":
        $setblock ~ ~ ~ $(mat)_planks
    
    # Destroy the table
    execute as @n[tag=table,type=interaction,distance=0..0.8]:
        scoreboard players add destroy-count tac.main 1
        function tac:table/break_table/destroy

kill @s