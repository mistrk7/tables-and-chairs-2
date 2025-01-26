advancement revoke @s only tac:table_rclick

execute if entity @n[type=item_display,tag=table,distance=..6] as @e[type=item_display,tag=table,sort=nearest,distance=..6] at @s:
    setblock ~ ~ ~ minecraft:oak_trapdoor[open=false,half=top,powered=true]