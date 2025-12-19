advancement revoke @s only tac:bench_rclick

execute run with entity @s:
    $execute positioned as @e[sort=nearest,tag=bench,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] run function tac:bench/rclick_bench/action
    function ~/action:

        # If the bench is already occupied, tag the rider (player)
        execute as @n[tag=bench,distance=0..0.8,type=minecraft:item_display] on passengers run tag @s add is_occupied

        # If not holding a carpet or shears, sit on the bench
        unless entity @n[tag=is_occupied,type=player,distance=0..0.8] unless items entity @s weapon.mainhand #minecraft:wool_carpets unless items entity @s weapon.mainhand minecraft:shears:

            scoreboard players set is_seated tac.main 1
            execute if entity @s on vehicle run scoreboard players reset is_seated tac.main

            #Sit on the bench
            ride @s mount @n[tag=bench,distance=0..0.8,type=minecraft:item_display]

            # Play seated sound if player is not already seated
            execute if score is_seated tac.main matches 1:
                playsound minecraft:block.wood.step block @a ~ ~ ~ 0.3 1
                playsound minecraft:item.armor.equip_leather block @a ~ ~ ~ 0.3 1.0
            scoreboard players reset is_seated tac.main
        
        # (detag the rider if was there)
        execute as @n[tag=is_occupied,type=player,distance=0..0.8] run tag @s remove is_occupied

        # If holding a carpet, add the carpet overlay
        #if items entity @s weapon.mainhand #minecraft:wool_carpets with entity @s SelectedItem:
            ## To be revised
            
        # If holding shears, drop the carpet
        #unless data entity @n[type=item_display,tag=bench,distance=..0.61] {item:{components:{"minecraft:custom_model_data":{strings:[""]}}}} if items entity @s weapon.mainhand minecraft:shears:
            ## To be revised

    $data remove entity @e[limit=1,tag=bench,type=minecraft:interaction,nbt={interaction:{player:$(UUID)}}] interaction