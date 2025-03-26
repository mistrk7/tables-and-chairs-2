#Script is the same as place_table.mcfunction but without changing the state of the table
advancement revoke @s only tac:table_place_sneak
playsound minecraft:block.wood.place block @a ~ ~ ~ 0.5 0.8

# Summon Chair based on item
execute at @n[type=armor_stand,tag=table] with entity @n[type=armor_stand,tag=table] data:
    #$say $(type) $(mat) $(state)
    $execute as @n[type=armor_stand,tag=table] at @s align xyz positioned ~.5 ~.5 ~.5 run function tac:table/summon_table {type:$(type),mat:$(mat),state:0}
    kill @n[type=armor_stand,tag=table]