advancement revoke @s only tac:chair_move

# Run logic
execute with entity @s:
    $execute at @n[tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] run function tac:chair/interact/move_chair/action
    $data remove entity @e[limit=1,tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack

function ~/action:
    # If not in a table, Place checker based on facing direction
    execute unless entity @n[type=item_display,tag=table,distance=..0.87]:
        scoreboard players set dire tac.main 0
        execute store success score dire tac.main if entity @s[y_rotation= -135..-45] run summon minecraft:block_display ~.9 ~.6 ~ {Tags:["tac","east"]}
        execute store success score dire tac.main if entity @s[y_rotation= -45..45] run summon minecraft:block_display ~ ~.6 ~.9 {Tags:["tac","south"]}
        execute store success score dire tac.main if entity @s[y_rotation= 45..135] run summon minecraft:block_display ~-.9 ~.6 ~ {Tags:["tac","west"]}
        execute if score dire tac.main matches 0 run summon minecraft:block_display ~ ~.6 ~-.9 {Tags:["tac","north"]}

    execute as @n[type=item_display,tag=chair]:
        # If in a table, Place checker based on the opposite last moved direction
        if entity @n[type=item_display,tag=table,distance=..0.87]:
            if entity @s[tag= north] run scoreboard players set dire tac.main 0
            for y,x,z in [("north",1,0),("east",0,1),("south",-1,0),("west",0,-1)]:
                if entity @s[tag= y ]:
                    summon minecraft:block_display ~x ~.6 ~z {Tags:["tac", y ]}
        
        # Setup check to see if it's too close
        scoreboard players set close tac.main 0
        scoreboard players set close-block tac.main 0
        scoreboard players set close-floor tac.main 0
        scoreboard players set close-table tac.main 0

        execute at @n[type=minecraft:block_display,tag=tac]:
            execute store result score close tac.main run data get entity @n[distance=0..0.79,type=interaction,tag=chair]
            execute store result score close-block tac.main align xyz run execute unless block ~ ~ ~ #tac:non_solid_blocks
            execute store result score close-floor tac.main align xyz run execute if block ~ ~-1 ~ #tac:non_solid_blocks
            execute store result score close-table tac.main align xyz run execute if block ~ ~ ~ #minecraft:trapdoors[half=top]
        unless score close-table tac.main matches 1 run scoreboard players operation close tac.main += close-block tac.main
        scoreboard players operation close tac.main += close-floor tac.main

        # If projected space is free from another chair (close=0)
        execute if score close tac.main matches 0:
            playsound minecraft:item.brush.brushing.generic block @a ~ ~ ~ 0.7 1.2
            playsound minecraft:block.wood.hit block @a ~ ~ ~ 0.3 1

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

        # Detect the direction moved and add a direction tag in opposite
        for x in ["north","east","south","west"]: 
            tag @s remove x
        for x,y in [("north","south"),("east","west"),("south","north"),("west","east")]: 
            execute if entity @n[type=block_display, tag= x ] as @s:
                tag @s add y

    # Kills all tac-tagged block displays (checkers). If this causes issues in the futurue please revise.
    kill @e[type=block_display, tag=tac]

    scoreboard players reset dire tac.main
    scoreboard players reset close tac.main
    scoreboard players reset close-block tac.main
    scoreboard players reset close-floor tac.main
    scoreboard players reset close-table tac.main