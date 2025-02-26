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

            #Custom detection for the custom blocks
            execute if score place tac.main matches 1:
                execute if data entity @s SelectedItem.components."minecraft:custom_data"{model:"table"} align xyz positioned ~.5 ~1 ~.5 with entity @s SelectedItem.components."minecraft:custom_data":
                    $summon armor_stand ~ ~ ~ {\
                        Invisible:1b,\
                        Tags:["table","tac"],\
                        ArmorItems:[{\
                            id:"minecraft:armor_stand",\
                            components:{\
                                "minecraft:custom_data":{\
                                    model:"table",\
                                    type:"$(type)",\
                                    mat:"$(mat)",\
                                    tac:1b\
                                }\
                            }\
                        }]\
                    }
                    function tac:table/place_table
                
                execute if data entity @s SelectedItem.components."minecraft:custom_data"{model:"chair"} align xyz positioned ~.5 ~1 ~.5 with entity @s SelectedItem.components."minecraft:custom_data":
                    $summon armor_stand ~ ~ ~ {\
                        Invisible:1b,\
                        Tags:["chair","tac"],\
                        ArmorItems:[{\
                            id:"minecraft:armor_stand",\
                            components:{\
                                "minecraft:custom_data":{\
                                    model:"chair",\
                                    type:"$(type)",\
                                    mat:"$(mat)",\
                                    tac:1b\
                                }\
                            }\
                        }]\
                    }
                    function tac:chair/place_chair

                execute if data entity @s SelectedItem{id:"minecraft:item_frame"} align y positioned ~ ~1 ~ :
                    summon minecraft:item_frame ~ ~ ~ {Facing:1b}
                    execute unless data entity @s abilities{instabuild:1b} run item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
                    playsound minecraft:entity.item_frame.place block @a ~ ~ ~
                execute if data entity @s SelectedItem{id:"minecraft:glow_item_frame"} align y positioned ~ ~1 ~ :
                    summon minecraft:glow_item_frame ~ ~ ~ {Facing:1b}
                    execute unless data entity @s abilities{instabuild:1b} run item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
                    playsound minecraft:entity.item_frame.place block @a ~ ~ ~

            # If successful, place and remove the item
            #$say $(id)
            execute if score place tac.main matches 1 unless data entity @s SelectedItem.components."minecraft:custom_data"{tac:1b} with entity @s SelectedItem:
                $setblock ~ ~1 ~ $(id)
                execute unless data entity @s abilities{instabuild:1b} run item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
                playsound minecraft:block.wood.place block @a ~ ~ ~
            
            execute unless data entity @s abilities{instabuild:1b} if score place tac.main matches 1 if data entity @s SelectedItem.components."minecraft:custom_data"{tac:1b} with entity @s SelectedItem.components."minecraft:custom_data":
                    item modify entity @s weapon.mainhand {"function":"minecraft:set_count","count":-1,"add":true}
            
            scoreboard players reset place tac.main

        # If unsuccessful, nothing. (future: place as item).
            
    $data remove entity @e[limit=1,tag=table,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] interaction