function ~/once :
    scoreboard players reset #repeat_modify tac.main
    execute as @e[type=block_display,tag=tac] at @s align y run function tac:bench/modify_bench
# Set the state of the bench based on the bench's around it

scoreboard players set @s tac.main 0


#execute store result score @s tac.main run data get entity @s item.components."minecraft:custom_data".rotation

#Execute on North, south
execute if entity @s[type=armor_stand,tag=tac] positioned ~ ~.5 ~ run function ~/execute_on_poles with entity @s equipment.feet.components."minecraft:custom_data"
execute if entity @s[type=block_display,tag=tac] positioned ~ ~.5 ~ run function ~/execute_on_poles with entity @n[type=item_display,tag=bench,distance=..0.5] item.components."minecraft:custom_data"

function ~/execute_on_poles:
    $execute if entity @s[type=block_display,tag=tac] run summon minecraft:block_display ~ ~ ~ {Tags:["tac","origin"],Rotation:[$(rotation).0f,0.0f],data:{rotation:$(rotation)}} 
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_north
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_south
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_east
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_west

# Logic for north, south, east, west.
for x,z,va,vb,vc,pole in [(0,1,1,2,3,'north'),(0,-1,4,8,12,'south'),(1,0,16,16,16,'east'),(-1,0,32,32,32,'west')]:

    # Spaghetti setup - basically ignore
    func_set_action = f"tac:bench/modify_bench/set_action_{pole}"
    function func_set_action :
        execute positioned ^x ^ ^z run function f'tac:bench/modify_bench/action_{pole}'
        # Y Value set at execute north south.
    func_action = f"tac:bench/modify_bench/action_{pole}"

    #Main function
    function func_action :
        execute if entity @s[type=armor_stand,tag=tac] if entity @n[type=item_display,tag=bench,distance=..0.5] run function ~/bulk_action with entity @s equipment.feet.components."minecraft:custom_data"
        execute if entity @s[type=block_display,tag=tac] if entity @n[type=item_display,tag=bench,distance=..0.5] run function ~/bulk_action with entity @n[type=block_display,tag=tac,tag=origin] data

        # optimisation: don't let it use predicate if no bench is there. ^^^
        #I would like a unique set of rules that works across block displays and armor stands

        function ~/bulk_action :
            #say detected
            execute if score #repeat_modify tac.main matches 1 :
                summon minecraft:block_display ~ ~ ~ {Tags:["tac"]}
                schedule function tac:bench/modify_bench/once 1t replace

            
            #say message3 #$say orig angle $(rotation) #message3 = f"Checking bench at {pole}"
            
            #Check if the rotation matches - left, right, middle.
            for r,v in [(-90, va), (90, vb), (0, vc)]:
                #summon arrow

                #Summon another block display to compare rotations (if from first batch of block displays)
                execute if entity @s[type=block_display,tag=tac] run summon minecraft:block_display ~ ~ ~ {Tags:["tac","secondary"]}

              #Add origin angle, to comparison angle, and apply it to the block display.
                scoreboard players set @n[type=block_display,tag=tac,distance=..0.5] tac.main r
                $scoreboard players add @n[type=block_display,tag=tac,distance=..0.5] tac.main $(rotation)
                execute if score @n[type=block_display,tag=tac,distance=..0.5] tac.main matches -90 run scoreboard players set @n[type=block_display,tag=tac,distance=..0.5] tac.main 270
                execute store result entity @n[type=block_display,tag=tac,distance=..0.5] Rotation[0] float 1 run scoreboard players get @n[type=block_display,tag=tac,distance=..0.5] tac.main
                
                #execute as @a run tellraw @s [{"text":f"comparison angle {r} is "},{"score":{"name":"@n[type=block_display,tag=tac,distance=..0.5]","objective":"tac.main"}}]

                #Store a success if the compared entity rotation matches into block display.
                execute store success score @n[type=block_display,tag=tac,distance=..0.5] tac.main run data modify entity @n[type=block_display,tag=tac,distance=..0.5] Rotation[0] set from entity @n[type=item_display,tag=bench,distance=..0.5] Rotation[0]

                #1. on fail (is equivalent):
                execute if score @n[type=block_display,tag=tac,distance=..0.5] tac.main matches 0 :
                    scoreboard players add @s tac.main v
                    #message1 = f"It's equivalent: {r}^ . adding {v} "
                    #say message1

                #2. on success (is different):
                execute if score @n[type=block_display,tag=tac,distance=..0.5] tac.main matches 1 :
                    rotate @n[type=block_display,tag=tac,distance=..0.5] -v ~   
                    #message2 = f"It's different: {r}^ ."
                    #say message2
                
                kill @n[type=block_display,tag=tac,tag=secondary,distance=..0.5]
                scoreboard players reset @n[type=block_display,tag=tac,distance=..0.5]


scoreboard players set #threshold1 tac.main 15
scoreboard players set #threshold2 tac.main 31
# Prioritse the north/south connections over the east/west
execute unless score @s tac.main matches 16 unless score @s tac.main matches 32 unless score @s tac.main matches 48 :
    execute if score @s tac.main > #threshold2 tac.main run scoreboard players remove @s tac.main 32
    execute if score @s tac.main > #threshold1 tac.main run scoreboard players remove @s tac.main 16

execute if entity @s[type=block_display,tag=tac] run kill @n[type=block_display,tag=tac,tag=origin]
execute if entity @s[type=block_display,tag=tac] positioned ~ ~.5 ~ run store result entity @n[type=item_display,tag=bench,distance=..0.5] item.components."minecraft:custom_model_data".floats[0] float 1 run scoreboard players get @s tac.main
execute if entity @s[type=armor_stand,tag=tac] positioned ~ ~.5 ~ run store result entity @s equipment.feet.components."minecraft:custom_data".state float 1 run scoreboard players get @s tac.main

scoreboard players reset @s tac.main
#scoreboard players reset @n[type=block_display,tag=tac,distance=..0.5]
kill @s[type=block_display,tag=tac]