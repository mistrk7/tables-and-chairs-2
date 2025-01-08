# Place checker based on facing direction
scoreboard players set dire tac.main 0
execute store success score dire tac.main if entity @s[y_rotation= -135..-45] run summon minecraft:block_display ~.9 ~.6 ~ {Tags:["tac","east"]}
execute store success score dire tac.main if entity @s[y_rotation= -45..45] run summon minecraft:block_display ~ ~.6 ~.9 {Tags:["tac","south"]}
execute store success score dire tac.main if entity @s[y_rotation= 45..135] run summon minecraft:block_display ~-.9 ~.6 ~ {Tags:["tac","west"]}
execute if score dire tac.main matches 0 run summon minecraft:block_display ~ ~.6 ~-.9 {Tags:["tac","north"]}

execute as @n[type=item_display,tag=chair]:

    # Setup check to see if it's too close
    scoreboard players set close tac.main 0
    scoreboard players set close-block tac.main 0
    scoreboard players set close-floor tac.main 0
    
    execute store result score close tac.main at @n[type=minecraft:block_display,tag=tac] run data get entity @n[distance=0..0.79,type=interaction,tag=tac]
    execute store result score close-block tac.main at @n[type=minecraft:block_display,tag=tac] align xyz run execute unless block ~ ~ ~ #minecraft:air
    execute store result score close-floor tac.main at @n[type=minecraft:block_display,tag=tac] align xyz run execute if block ~ ~-1 ~ #minecraft:air
    scoreboard players operation close tac.main += close-block tac.main
    scoreboard players operation close tac.main += close-floor tac.main

    # If projected space is free from another chair (close=0 & )
    execute if score close tac.main matches 0:

        # Facing East, tp
        execute if entity @n[type=minecraft:block_display,tag=east]:
            tp @s ~.5 ~.6 ~
            tp @n[type=interaction,tag=chair] ~.5 ~ ~
        
        # Facing South, tp
        execute if entity @n[type=minecraft:block_display,tag=south]:
            tp @s ~ ~.6 ~.5
            tp @n[type=interaction,tag=chair] ~ ~ ~.5

        # Facing West, tp
        execute if entity @n[type=minecraft:block_display,tag=west]:
            tp @s ~-.5 ~.6 ~
            tp @n[type=interaction,tag=chair] ~-.5 ~ ~

        # Facing North, tp
        execute if score dire tac.main matches 0:
            tp @s ~ ~.6 ~-.5
            tp @n[type=interaction,tag=chair] ~ ~ ~-.5

# Kills all tac-tagged block displays. If this causes issues in the futurue please revise.
kill @e[type=block_display, tag=tac]

scoreboard players reset dire tac.main
scoreboard players reset close tac.main
scoreboard players reset close-block tac.main
scoreboard players reset close-floor tac.main