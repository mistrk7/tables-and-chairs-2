
execute at @s[tag=chk.table.legs] run setblock ~ ~ ~ air
execute at @s[tag=table] run setblock ~ ~ ~ air

execute at @s[tag=chair]:
    kill @n[type=item_display,tag=chair,distance=..0.61]
    scoreboard players remove chairs tac.main 1

execute at @s[tag=table]:
    kill @n[type=item_display,tag=table,distance=0..0.4]
    scoreboard players remove tables tac.main 1

kill @s