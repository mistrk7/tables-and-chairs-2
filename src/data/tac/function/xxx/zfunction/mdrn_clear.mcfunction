execute at @s[tag=chair, type=item_display]:
    scoreboard players remove chairs tac.main 1
    scoreboard players add destroy-count tac.main 1

execute at @s[tag=table, type=item_display]:
    setblock ~ ~ ~ air
    scoreboard players remove tables tac.main 1
    scoreboard players add destroy-count tac.main 1

execute at @s[tag=table] run kill @n[tag=table,distance=0.1..0.4]
execute at @s[tag=chair] run kill @n[tag=chair,distance=0.1..0.61]

kill @s