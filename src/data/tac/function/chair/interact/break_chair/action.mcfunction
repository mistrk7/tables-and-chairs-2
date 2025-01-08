
# Second hit (within the last second): Destroy
execute if entity @s[tag=wait]:
    # Drop the item
    summon minecraft:item ~ ~0.55 ~ {Item:{id:"minecraft:armor_stand",count:1,components:{"minecraft:custom_model_data":{strings:["oak_basic_chair"]},"minecraft:custom_data":{tac:0b}}},Motion:[0.0,0.2,0.0]}
    data modify entity @n[type=item,nbt={Item:{components:{"minecraft:custom_data":{tac:0b}}}}] Item merge from entity @n[type=item_display,tag=chair] item
    #Destroy the chair
    kill @s
    kill @e[sort=nearest,limit=1,type=item_display,tag=chair]

# First hit: Put into 'disturbed' state for one second
execute unless entity @s[tag=wait]:
    tag @s add wait
    
    # Start wiggle animation
    execute as @n[type=item_display,tag=chair] at @s run tp @s ~ ~ ~ ~12 ~
    tag @n[type=item_display,tag=chair] add anibreak1

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
