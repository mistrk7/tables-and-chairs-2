advancement revoke @s only tac:table_rclick

execute if entity @n[type=item_display,tag=table,distance=..6] as @e[type=item_display,tag=table,sort=nearest,distance=..6] at @s with entity @s item.components."minecraft:custom_data":
    setblock ~ ~ ~ minecraft:oak_trapdoor[half=top,powered=true,open=false]
    $setblock ~ ~ ~ minecraft:$(mat)_trapdoor[open=false,half=top,powered=true]