function ~/once :
    scoreboard players reset #repeat_modify tac.main
    say repeating
    execute as @e[type=block_display,tag=tac] at @s align y run function tac:bench/modify_bench
# Set the state of the bench based on the bench's around it

scoreboard players set @s tac.main 0
#execute store result score @s tac.main run data get entity @s item.components."minecraft:custom_data".rotation
say run
#Execute on North, south
execute run function ~/execute_on_poles with entity @s equipment.feet.components."minecraft:custom_data"
execute run function ~/execute_on_poles with entity @n[type=item_display,tag=bench,distance=..0.5] item.components."minecraft:custom_data"
function ~/execute_on_poles:
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_north
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_south
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_east
    $execute rotated $(rotation) 0 run function tac:bench/modify_bench/set_action_west

# Logic for north, south, east, west.
for x,z,va,vb,vc,pole in [(0,-1,1,2,3,'north'),(0,1,4,8,12,'south'),(1,0,16,16,16,'east'),(-1,0,32,32,32,'west')]:

    # Spaghetti setup - basically ignore
    func_set_action = f"tac:bench/modify_bench/set_action_{pole}"
    function func_set_action :
        execute positioned ^x ^0.5 ^z run function f'tac:bench/modify_bench/action_{pole}'
    func_action = f"tac:bench/modify_bench/action_{pole}"

    #Main function
    function func_action :
        execute if entity @n[type=item_display,tag=bench,distance=..0.5] run function ~/bulk_action with entity @s equipment.feet.components."minecraft:custom_data"
        execute if entity @n[type=item_display,tag=bench,distance=..0.5] run function ~/bulk_action with entity @n[type=item_display,tag=bench,distance=..0.5] item.components."minecraft:custom_data"

        function ~/bulk_action :
            say detected
            execute if score #repeat_modify tac.main matches 1 :
                summon minecraft:block_display ~ ~ ~ {Tags:["tac"]}
                schedule function tac:bench/modify_bench/once 2t replace

            say attempting to modify on rotation 
            #Check if the rotation matches - left, right, middle.
            for r,v in [(-90, va), (90, vb), (0, vc)]:
                say in the midst
                summon arrow
                #Change block display angle to item display angle
                $data modify entity @n[type=block_display,tag=tac,distance=..0.5] Rotation[0] set value $(rotation)

                #Rotate block display to comparison angle
                scoreboard players set @n[type=block_display,tag=tac,distance=..0.5] tac.main r
                $scoreboard players add @n[type=block_display,tag=tac,distance=..0.5] tac.main $(rotation)
                execute store result entity @n[type=block_display,tag=tac,distance=..0.5] Rotation[0] float 1 run scoreboard players get @n[type=block_display,tag=tac,distance=..0.5] tac.main

                #Store a success if the compared entity rotation matches into block display.
                execute store success score @n[type=block_display,tag=tac,distance=..0.5] tac.main run data modify entity @n[type=block_display,tag=tac,distance=..0.5] Rotation[0] set from entity @n[type=item_display,tag=bench,distance=..0.5] Rotation[0]
                
                #say #matches into block display.

                #1. on fail (is equivalent):
                execute if score @n[type=block_display,tag=tac,distance=..0.5] tac.main matches 0 :
                    scoreboard players add @s tac.main v
                    say #1. v It's the same:

                #2. on success (is different):
                execute if score @n[type=block_display,tag=tac,distance=..0.5] tac.main matches 1 :
                    rotate @n[type=block_display,tag=tac,distance=..0.5] -v ~   
                    say #2. v It's different:
                
                scoreboard players reset @n[type=block_display,tag=tac,distance=..0.5]


execute store result entity @n[type=item_display,tag=bench,distance=..0.5] item.components."minecraft:custom_model_data".floats[0] float 1 run scoreboard players get @s tac.main
execute store result entity @s equipment.feet.components."minecraft:custom_data".state float 1 run scoreboard players get @s tac.main

scoreboard players reset @s tac.main
#scoreboard players reset @n[type=block_display,tag=tac,distance=..0.5]
kill @s[type=block_display,tag=tac]
say killed