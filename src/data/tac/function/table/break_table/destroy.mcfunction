# Replace item
execute as @n[type=minecraft:item, nbt={Age:0s}, distance=..1]:
    data modify entity @s Item set from entity @n[type=minecraft:item_display, distance=0..0.35] item
    data modify entity @s Item.components."minecraft:custom_model_data".floats[0] set value 0.0f

# Destroy the table
kill @n[type=item_display,tag=table,distance=0..0.4]
kill @s

scoreboard players remove tables tac.main 1