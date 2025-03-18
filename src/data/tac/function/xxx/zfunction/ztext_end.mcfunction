execute store result storage tac:main destroyCount int 1 run scoreboard players get destroy-count tac.main

scoreboard players operation total tac.main = tables tac.main
scoreboard players operation total tac.main += chairs tac.main
execute store result storage tac:main objectCount int 1 run scoreboard players get total tac.main

scoreboard players reset destroy-count tac.main
scoreboard players reset total tac.main

execute with storage tac:main:
    $tellraw @a ["",{"text":"[T&C]: "},{"text":"$(destroyCount) ","color":"aqua"},{"text":"out of","color":"yellow"},{"text":" $(objectCount)*","color":"aqua"},{"text":" furniture removed/modified.","color":"yellow"}]