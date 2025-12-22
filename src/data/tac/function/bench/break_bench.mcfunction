## Mostly copied from tac:chair/place_chair.mcfunction
advancement revoke @s only tac:bench_break

# Logic
execute with entity @s:
    $execute as @n[tag=bench,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] at @s run function tac:bench/break_bench/action
    $data remove entity @e[limit=1,tag=bench,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack

function ~/action:
    # Second hit (within the last second): Destroy
    execute if entity @s[tag=wait] run function ~/destroy:
        playsound minecraft:block.wood.break block @a ~ ~ ~ 0.8 1

        # Drop its carpet if it has one
        ## LOGIC TO REVISE

        # Drop the item
        execute if entity @s[tag=wait] as @n[type=item_display,tag=bench,distance=..0.61]:
            data modify entity @s item.components."minecraft:custom_model_data".floats[0] set value 0.0f
            data modify entity @s item.components."minecraft:custom_data".rotation set value 0
            execute with entity @s:
                $summon minecraft:item ~ ~0.55 ~ {Item:$(item),Motion:[0.0,0.2,0.0]}
            
            # Particles
            execute with entity @s item.components."minecraft:custom_data":
                $particle block{block_state:{Name:$(mat)_planks}} ~ ~0 ~ 0 0 0 1 4
                $particle block{block_state:{Name:$(mat)_planks}} ~ ~.6 ~ 0 0 0 1 4
                $particle block{block_state:{Name:$(mat)_planks}} ~ ~1.2 ~ 0 0 0 1 4

        # Update Sourrounding Benches
        execute summon minecraft:block_display:
            tag @s add tac
            scoreboard players set #repeat_modify tac.main 1
            function tac:bench/modify_bench

        #Destroy the bench
        tag @s add killinteraction
        schedule function ./killinteraction 0.1s append:
            kill @e[tag=killinteraction]
        kill @n[type=item_display,tag=bench,distance=..0.61]
        
        setblock ~ ~1 ~ minecraft:air
        scoreboard players remove chairs tac.main 1
        ## ^^ Benches count as chairs for now on the scoreboard

    # First hit: Put into 'disturbed' state for one second
    execute unless entity @s[tag=wait]:
        tag @s add wait
        
        # Start pulse animation
        playsound minecraft:block.wood.step block @a ~ ~ ~ 0.5 0.95
        data modify entity @n[type=item_display,tag=bench,distance=0..0.61] transformation.scale set value [1.25f,1.25f,1.25f]
        tag @n[type=item_display,tag=bench,distance=0..0.61] add anibreak1

        schedule function ./animate/1 2t append:
            execute as @e[type=item_display,tag=anibreak1] at @s:
                data modify entity @n[type=item_display,tag=bench,distance=0..0.61] transformation.scale set value [0.95f,0.95f,0.95f]
                data modify entity @n[type=item_display,tag=bench,distance=0..0.61] transformation.scale set value [0.95f,0.95f,0.95f]
                tag @s remove anibreak1
                tag @s add anibreak2
        
        schedule function ./animate/2 4t append:
            execute as @e[type=item_display,tag=anibreak2] at @s:
                data modify entity @n[type=item_display,tag=bench,distance=0..0.61] transformation.scale set value [1.0f,1.0f,1.0f]
                data modify entity @n[type=item_display,tag=bench,distance=0..0.61] transformation.scale set value [1.0f,1.0f,1.0f]
                tag @s remove anibreak2
        # Animation end (how fun)

        schedule function ./timer_hit 0.4s append:
            execute as @e[type=interaction,tag=wait] run tag @s remove wait
