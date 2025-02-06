advancement revoke @s only tac:chair_break

# Logic
execute with entity @s:
    $execute as @n[tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] at @s run function tac:chair/interact/break_chair/action
    $data remove entity @e[limit=1,tag=chair,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack

function ~/action:
    # Second hit (within the last second): Destroy
    execute if entity @s[tag=wait]:
        playsound minecraft:block.wood.break block @a ~ ~ ~ 0.8 1
        
        # Drop the item
        summon minecraft:item ~ ~0.55 ~ {Tags:["temp"],Item:{id:"minecraft:armor_stand",count:1,components:{"minecraft:item_model": "tac:chair/basic/oak_basic_chair"}},Motion:[0.0,0.2,0.0]}
        data modify entity @n[type=item,tag=temp] Item merge from entity @n[type=item_display,tag=chair,distance=..0.61] item
        data modify entity @n[type=item,tag=temp] Item.components."minecraft:custom_model_data".strings[0] set value ""
        tag @n[type=item,tag=temp] remove temp
        
        # Drop its carpet if it has one
        execute unless data entity @n[type=item_display,tag=chair,distance=..0.61] {item:{components:{"minecraft:custom_model_data":{strings:[""]}}}}:
            summon minecraft:item ~ ~0.65 ~ {Tags:["temp"],Item:{id:"minecraft:white_carpet",count:1},Motion:[0.0,0.2,0.0]}
            data modify entity @n[type=item,tag=temp] Item.id set from entity @n[type=item_display,tag=chair,distance=..0.61] item.components."minecraft:custom_model_data".strings[0]
            tag @n[type=item,tag=temp] remove temp

        #Destroy the chair
        kill @s
        kill @n[type=item_display,tag=chair,distance=..0.61]

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
