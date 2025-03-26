advancement revoke @s only tac:table_place
playsound minecraft:block.wood.place block @a ~ ~ ~ 0.5 0.8


# Run function to check for what state it should be in
scoreboard players set repeat_modify tac.main 1
execute as @n[type=armor_stand,tag=table] at @s run function ./modify_table


# Summon Chair based on item
execute at @n[type=armor_stand,tag=table] with entity @n[type=armor_stand,tag=table] data:
    #$say $(type) $(mat) $(state)
    $execute as @n[type=armor_stand,tag=table] at @s align xyz positioned ~.5 ~.5 ~.5 run function tac:table/summon_table {type:$(type),mat:$(mat),state:$(state)}
    kill @n[type=armor_stand,tag=table]