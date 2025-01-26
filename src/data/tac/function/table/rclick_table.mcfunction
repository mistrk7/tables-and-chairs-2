advancement revoke @s only tac:table_rclick

execute as @e[type=item_display,tag=table,sort=nearest,limit=6] at @s:
    setblock ~ ~ ~ minecraft:oak_trapdoor[open=false,half=top]