advancement revoke @s only tac:table_rclick

execute run with entity @s:
    $execute positioned as @e[sort=nearest,limit=1,tag=table,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] run function tac:table/rclick_table/action
    function ~/action:

        # Try to check and place the block above and store a success
        execute with entity @s SelectedItem:
            scoreboard players set place tac.main 0
            execute store result score place tac.main positioned ~ ~1 ~ run execute if block ~ ~1 ~ #minecraft:air
            execute unless block ~ ~1 ~ #minecraft:air run scoreboard players set place tac.main 0
            execute if items entity @s weapon.mainhand #tac:non_placeable run scoreboard players set place tac.main 0
            execute align xyz positioned ~.5 ~.5 ~.5 if entity @n[type=minecraft:interaction,tag=chair,distance=..0.5] run scoreboard players set place tac.main 0

            #Custom detection for the custom blocks
            execute if score place tac.main matches 1:
                execute unless data entity @s SelectedItem.components."minecraft:custom_data"{model:bench} if data entity @s SelectedItem.components."minecraft:custom_data"{tac:1b} align xyz positioned ~.5 ~1 ~.5 with entity @s SelectedItem.components."minecraft:custom_data":
                    $summon armor_stand ~ ~ ~ {\
                        Invisible:1b,\
                        Tags:["$(model)","tac"],\
                        data:{\
                            model:"$(model)",\
                            type:"$(type)",\
                            mat:"$(mat)",\
                            tac:1b\
                        }\
                    }
                    $function tac:$(model)/place_$(model)

                # Item Frames
                execute if data entity @s SelectedItem{id:"minecraft:item_frame"} align y positioned ~ ~1 ~ :
                    summon minecraft:item_frame ~ ~ ~ {Facing:1b}
                    execute unless data entity @s abilities{instabuild:1b} run item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
                    playsound minecraft:entity.item_frame.place block @a ~ ~ ~
                execute if data entity @s SelectedItem{id:"minecraft:glow_item_frame"} align y positioned ~ ~1 ~ :
                    summon minecraft:glow_item_frame ~ ~ ~ {Facing:1b}
                    execute unless data entity @s abilities{instabuild:1b} run item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
                    playsound minecraft:entity.item_frame.place block @a ~ ~ ~

            # If successful, place and remove the item

            # Place vanilla blocks
            execute if score place tac.main matches 1 unless data entity @s SelectedItem.components."minecraft:custom_data"{tac:1b} with entity @s SelectedItem:
                $setblock ~ ~1 ~ $(id)
                data modify block ~ ~1 ~ components set from entity @s SelectedItem.components
                execute unless data entity @s abilities{instabuild:1b} run item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
                playsound minecraft:block.wood.place block @a ~ ~ ~

                # Player Heads
                execute if data entity @s SelectedItem{id:"minecraft:player_head"} align y positioned ~ ~1 ~ run function ~/place_player_head with entity @s SelectedItem.components."minecraft:profile"
                function ~/place_player_head:
                    $setblock ~ ~ ~ minecraft:player_head{profile:{properties:$(properties)}}
            
            # Place t&c blocks
            execute unless data entity @s abilities{instabuild:1b} if score place tac.main matches 1 unless data entity @s SelectedItem.components."minecraft:custom_data"{model:bench} if data entity @s SelectedItem.components."minecraft:custom_data"{tac:1b} with entity @s SelectedItem.components."minecraft:custom_data":
                    item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
            
            scoreboard players reset place tac.main

        # If unsuccessful, nothing. (future: place as item).
            
    $data remove entity @e[limit=1,tag=table,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] interaction