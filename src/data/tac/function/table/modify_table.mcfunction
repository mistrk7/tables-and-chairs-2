function ~/once :
    scoreboard players reset #repeat_modify tac.main
    execute as @e[type=block_display,tag=tac] at @s align y run function tac:table/modify_table
# Set the state of the table based on the chairs around it

scoreboard players set @s tac.main 0

# For north, east, south, west
for x,z,v in [(0,-1,1),(1,0,2),(0,1,4),(-1,0,8)]:
    execute positioned ~x ~0.5 ~z:
        if entity @n[type=item_display,tag=table,distance=..0.5] :
            scoreboard players add @s tac.main v
            execute if score #repeat_modify tac.main matches 1 :
                summon minecraft:block_display ~ ~ ~ {Tags:["tac"]}
                schedule function tac:table/modify_table/once 1t replace

execute store result entity @n[type=item_display,tag=table,distance=..0.5] item.components."minecraft:custom_model_data".floats[0] float 1 run scoreboard players get @s tac.main
execute store result entity @s data.state float 1 run scoreboard players get @s tac.main

scoreboard players reset @s tac.main
kill @s[type=block_display,tag=tac]