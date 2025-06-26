advancement revoke @s only tac:chair_break

# Logic
execute with entity @s:
    $execute as @n[tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] at @s run function tac:chair/break_chair/action
    $data remove entity @e[limit=1,tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack

function ~/action:
    # Second hit (within the last second): Destroy
    execute if entity @s[tag=wait] run function ~/destroy:
        playsound minecraft:block.wood.break block @a ~ ~ ~ 0.8 1

        # Drop its carpet if it has one
        execute if entity @s[tag=wait] as @n[type=item_display,tag=chair,distance=..0.61] unless data entity @n[type=item_display,tag=chair,distance=..0.61] {item:{components:{"minecraft:custom_model_data":{strings:[""]}}}}:
            summon minecraft:item ~ ~0.65 ~ {Tags:["temp"],Item:{id:"minecraft:white_carpet",count:1},Motion:[0.0,0.2,0.0]}
            data modify entity @n[type=item,tag=temp] Item.id set from entity @s item.components."minecraft:custom_model_data".strings[0]
            tag @n[type=item,tag=temp] remove temp

        # Drop the item
        execute if entity @s[tag=wait] as @n[type=item_display,tag=chair,distance=..0.61]:
            data modify entity @s item.components."minecraft:custom_model_data".strings[0] set value ""
            execute with entity @s:
                $summon minecraft:item ~ ~0.55 ~ {Item:$(item),Motion:[0.0,0.2,0.0]}
            
            # Particles
            execute with entity @s item.components."minecraft:custom_data":
                $particle block{block_state:{Name:$(mat)_planks}} ~ ~0 ~ 0 0 0 1 4
                $particle block{block_state:{Name:$(mat)_planks}} ~ ~.6 ~ 0 0 0 1 4
                $particle block{block_state:{Name:$(mat)_planks}} ~ ~1.2 ~ 0 0 0 1 4

        #Destroy the chair
        kill @s
        kill @n[type=item_display,tag=chair,distance=..0.61]
        kill @n[type=armor_stand,tag=pressure,tag=tac,distance=..0.8]
        scoreboard players remove chairs tac.main 1

    # First hit: Put into 'disturbed' state for one second
    execute unless entity @s[tag=wait]:
        tag @s add wait
        
        # Start wiggle animation
        playsound minecraft:block.wood.step block @a ~ ~ ~ 0.5 1.2
        execute as @n[type=item_display,tag=chair,distance=0..0.61] at @s run tp @s ~ ~ ~ ~12 ~
        tag @n[type=item_display,tag=chair,distance=0..0.61] add anibreak1

        schedule function ./animate/1 0.1s append:
            execute as @e[type=item_display,tag=anibreak1] at @s:
                tp @s ~ ~ ~ ~-24 ~
                tag @s remove anibreak1
                tag @s add anibreak2
        
        schedule function ./animate/2 0.2s append:
            execute as @e[type=item_display,tag=anibreak2] at @s:
                tp @s ~ ~ ~ ~12 ~
                tag @s remove anibreak2
        # Animation end (how fun)

        schedule function ./timer_hit 0.4s append:
            execute as @e[type=interaction,tag=wait] run tag @s remove wait
