execute at @s[tag=chair]:

    # Destroy the chair
    execute as @n[tag=chair,type=interaction,distance=0..0.8]:
        function tac:chair/break_chair/action/destroy
        scoreboard players add destroy-count tac.main 1

execute at @s[tag=table]:

    # Destroy the table
    execute as @n[tag=table,type=interaction,distance=0..0.8]:
        setblock ~ ~ ~ air
        # ^ set the space to air
        function tac:table/break_table/destroy
        scoreboard players add destroy-count tac.main 1

#execute at @s[tag=table] run kill @n[tag=table,distance=0.1..0.4]
#execute at @s[tag=chair] run kill @n[tag=chair,distance=0.1..0.61]

kill @s