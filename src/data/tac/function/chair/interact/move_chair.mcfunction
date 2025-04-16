advancement revoke @s only tac:chair_move

# Run logic
execute with entity @s:
    $execute at @n[tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] run function tac:chair/interact/move_chair/action
    $data remove entity @e[limit=1,tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack

function ~/action:

    #Check if the chair is in a table
    execute store result score in-table tac.main run positioned as @n[type=item_display,tag=chair,distance=..0.8] if entity @n[tag=table,distance=..0.72]

    # If not in a table, Place checker based on facing direction
    execute if score in-table tac.main matches 0:
        scoreboard players set dire tac.main 0
        execute store success score dire tac.main if entity @s[y_rotation= -135..-45] run summon minecraft:block_display ~.9 ~.6 ~ {Tags:["tac","east"]}
        execute store success score dire tac.main if entity @s[y_rotation= -45..45] run summon minecraft:block_display ~ ~.6 ~.9 {Tags:["tac","south"]}
        execute store success score dire tac.main if entity @s[y_rotation= 45..135] run summon minecraft:block_display ~-.9 ~.6 ~ {Tags:["tac","west"]}
        execute if score dire tac.main matches 0 run summon minecraft:block_display ~ ~.6 ~-.9 {Tags:["tac","north"]}

    execute as @n[type=item_display,tag=chair,distance=..0.8]:
        # If in a table, Place checker based on the direction pointing to where it last was.
        if score in-table tac.main matches 1:
            if entity @s[tag= north] run scoreboard players set dire tac.main 0
            for y,x,z in [("east",0.9,0),("south",0,0.9),("west",-0.9,0),("north",0,-0.9)]:
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
            execute store result score close-table tac.main align xyz positioned ~.5 ~.5 ~.5 run execute if entity @n[type=item_display,tag=table,distance=..0.1]
        unless score close-table tac.main matches 1 run scoreboard players operation close tac.main += close-block tac.main
        scoreboard players operation close tac.main += close-floor tac.main

        # If projected space is free from another chair, move it (close=0)  and trigger bottom observer.
        execute if score close tac.main matches 0:
            tag @s remove tucked-in
            scoreboard players set pressure_plate_L tac.main 0
            scoreboard players set pressure_plate_R tac.main 0
            playsound minecraft:item.brush.brushing.generic block @a ~ ~ ~ 0.7 1.2
            playsound minecraft:block.wood.hit block @a ~ ~ ~ 0.3 1

            # Facing East, tp
            execute if entity @n[type=minecraft:block_display,tag=east]:
                tp @s ~.5 ~.6 ~
                tp @n[type=interaction,tag=chair] ~.5 ~ ~

                # Facing East, trigger an observer beneath. 
                execute if block ~.4 ~-.5 ~ minecraft:observer:
                    setblock ~ ~.6 ~ minecraft:acacia_button
                    setblock ~ ~.6 ~ minecraft:air
                
                # Facing East, press a pressure plate beneath. 
                execute if block ~.7 ~.5 ~.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~.7 ~.5 ~-.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if block ~.3 ~.5 ~.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~.3 ~.5 ~-.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if score pressure_chain tac.main matches 1:
                    kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                    scoreboard players reset pressure_chain tac.main
                execute if score pressure_plate_L tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                execute if score pressure_plate_R tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                # -- continue --
                scoreboard players operation pressure_plate_L tac.main += pressure_plate_R tac.main
                execute if score pressure_plate_L tac.main matches 0 run kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                execute unless score pressure_plate_L tac.main matches 0 run function ~/east_pressure_plate:
                    tp @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure] ~.5 ~-.5 ~
                    execute unless entity @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure]:
                        summon minecraft:armor_stand ~.5 ~ ~ {Tags:['tac','pressure','fresh'], NoAI:1b, Silent:1, Invisible:1b, attributes:[{base:0.3d, id: "minecraft:scale"}]}
                        schedule function ./kill_pressure_east 2t append:
                            execute as @e[type=minecraft:armor_stand, limit=1, tag=fresh, tag=pressure] at @s:
                                tag @s remove fresh
                                data merge entity @s {NoGravity:1b}
                                tp @s ~ ~-.5 ~

            # Facing South, tp
            execute if entity @n[type=minecraft:block_display,tag=south]:
                tp @s ~ ~.6 ~.5
                tp @n[type=interaction,tag=chair] ~ ~ ~.5

                # Facing South, trigger an observer beneath. 
                execute if block ~ ~-.5 ~.4 minecraft:observer:
                    setblock ~ ~.6 ~ minecraft:acacia_button
                    setblock ~ ~.6 ~ minecraft:air
                
                # Facing South, press a pressure plate beneath. 
                execute if block ~.3 ~.5 ~.7 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~-.3 ~.5 ~.7 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if block ~.3 ~.5 ~.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~-.3 ~.5 ~.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if score pressure_chain tac.main matches 1:
                    kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                    scoreboard players reset pressure_chain tac.main
                execute if score pressure_plate_L tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                execute if score pressure_plate_R tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                # -- continue --
                scoreboard players operation pressure_plate_L tac.main += pressure_plate_R tac.main
                execute if score pressure_plate_L tac.main matches 0 run kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                execute unless score pressure_plate_L tac.main matches 0 run function ~/south_pressure_plate:
                    tp @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure] ~ ~-.5 ~.5
                    execute unless entity @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure]:
                        summon minecraft:armor_stand ~ ~ ~.5 {Tags:['tac','pressure','fresh'], NoAI:1b, Silent:1, Invisible:1b, attributes:[{base:0.3d, id: "minecraft:scale"}]}
                        schedule function ./kill_pressure_south 2t append:
                            execute as @e[type=minecraft:armor_stand, limit=1, tag=fresh, tag=pressure] at @s:
                                tag @s remove fresh
                                data merge entity @s {NoGravity:1b}
                                tp @s ~ ~-.5 ~

            # Facing West, tp
            execute if entity @n[type=minecraft:block_display,tag=west]:
                tp @s ~-.5 ~.6 ~
                tp @n[type=interaction,tag=chair] ~-.5 ~ ~

                # Facing West, trigger an observer beneath. 
                execute if block ~-.4 ~-.5 ~ minecraft:observer:
                    setblock ~-.4 ~.6 ~ minecraft:acacia_button
                    setblock ~-.4 ~.6 ~ minecraft:air
                
                # Facing West, press a pressure plate beneath. 
                execute if block ~-.7 ~.5 ~-.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~-.7 ~.5 ~.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if block ~-.3 ~.5 ~-.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~-.3 ~.5 ~.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if score pressure_chain tac.main matches 1:
                    kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                    scoreboard players reset pressure_chain tac.main
                execute if score pressure_plate_L tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                execute if score pressure_plate_R tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                # -- continue --
                scoreboard players operation pressure_plate_L tac.main += pressure_plate_R tac.main
                execute if score pressure_plate_L tac.main matches 0 run kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                execute unless score pressure_plate_L tac.main matches 0 run function ~/west_pressure_plate:
                    tp @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure] ~-.5 ~-.5 ~
                    execute unless entity @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure]:
                        summon minecraft:armor_stand ~-.5 ~ ~ {Tags:['tac','pressure','fresh'], NoAI:1b, Silent:1, Invisible:1b, attributes:[{base:0.3d, id: "minecraft:scale"}]}
                        schedule function ./kill_pressure_west 2t append:
                            execute as @e[type=minecraft:armor_stand, limit=1, tag=fresh, tag=pressure] at @s:
                                tag @s remove fresh
                                data merge entity @s {NoGravity:1b}
                                tp @s ~ ~-.5 ~
            
            # Facing North, tp
            execute if score dire tac.main matches 0:
                tp @s ~ ~.6 ~-.5
                tp @n[type=interaction,tag=chair] ~ ~ ~-.5

                # Facing North, trigger an observer beneath. 
                execute if block ~ ~-.5 ~-.4 minecraft:observer:
                    setblock ~ ~.6 ~-.4 minecraft:acacia_button
                    setblock ~ ~.6 ~-.4 minecraft:air
                
                # Facing North, press a pressure plate beneath.
                execute if block ~.3 ~.5 ~-.7 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~-.3 ~.5 ~-.7 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if block ~.3 ~.5 ~-.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_L tac.main 1
                execute if block ~-.3 ~.5 ~-.3 #minecraft:pressure_plates run scoreboard players add pressure_plate_R tac.main 1
                execute if score pressure_chain tac.main matches 1:
                    kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                    scoreboard players reset pressure_chain tac.main
                execute if score pressure_plate_L tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                execute if score pressure_plate_R tac.main matches 2 run scoreboard players set pressure_chain tac.main 1
                # -- continue --
                scoreboard players operation pressure_plate_L tac.main += pressure_plate_R tac.main
                execute if score pressure_plate_L tac.main matches 0 run kill @n[type=minecraft:armor_stand,tag=pressure,tag=tac,distance=0..8]
                execute unless score pressure_plate_L tac.main matches 0 run function ~/north_pressure_plate:
                    tp @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure] ~ ~-.5 ~-.5
                    execute unless entity @n[distance=0..0.8,type=minecraft:armor_stand, tag=tac, tag=pressure]:
                        summon minecraft:armor_stand ~ ~ ~-.5 {Tags:['tac','pressure','fresh'], NoAI:1b, Silent:1, Invisible:1b, attributes:[{base:0.3d, id: "minecraft:scale"}]}
                        schedule function ./kill_pressure_north 2t append:
                            execute as @e[type=minecraft:armor_stand, limit=1, tag=fresh, tag=pressure] at @s:
                                tag @s remove fresh
                                data merge entity @s {NoGravity:1b}
                                tp @s ~ ~-.5 ~
                
        # Detect the direction moved and add a direction tag in opposite
        execute if score in-table tac.main matches 0:
            for x in ["north","east","south","west"]: 
                tag @s remove x
            for x,y in [("north","south"),("east","west"),("south","north"),("west","east")]: 
                execute if entity @n[type=block_display, tag= x ] as @s:
                    tag @s add y
        
        # Chair tuck-in detection
        tag @s add tucker
        execute if score close-table tac.main matches 1:
            execute as @e[type=item_display,tag=tucker] at @s if entity @n[tag=table,distance=0..0.8]:
                tag @s remove tucker
                tag @s add tucked-in

                # Play tucked sound
                playsound minecraft:block.wood.step block @a ~ ~ ~ 0.5 1.4

                # Rotate the chair to face the table
                for x,r in [("north",0), ("east",90), ("south",180), ("west",270)]: 
                    if entity @s[tag= x ]:
                        rotate @s r 0
        tag @s remove tucker

    # Kills all tac-tagged block displays (checkers). If this causes issues in the futurue please revise.
    kill @e[type=block_display, tag=tac]

    scoreboard players reset dire tac.main
    scoreboard players reset close tac.main
    scoreboard players reset close-block tac.main
    scoreboard players reset close-floor tac.main
    scoreboard players reset close-table tac.main
    scoreboard players reset in-table tac.main
    scoreboard players reset pressure_plate_L tac.main
    scoreboard players reset pressure_plate_R tac.main