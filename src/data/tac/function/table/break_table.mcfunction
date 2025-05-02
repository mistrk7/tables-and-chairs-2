advancement revoke @s only tac:table_break

# Logic
execute with entity @s:
    $execute as @n[tag=table,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] at @s run function tac:table/break_table/action
    $data remove entity @e[limit=1,tag=table,type=minecraft:interaction,nbt={attack:{player:$(UUID)}}] attack 

function ~/action:
    tag @s add table_break
    playsound minecraft:block.wood.hit block @a ~ ~ ~ 0.5 1
    
    data modify entity @s width set value 0.1
    data modify entity @s height set value 0.1

    # While tag is 'table break' check to see if the trapdoor was broken. If so, replace the item.
    execute run function ~/check:
        execute as @e[type=interaction,tag=table_break] at @s align y positioned ~ ~0.5 ~:

            # When the table is detected to be broken
            unless block ~ ~ ~ #minecraft:trapdoors :
                function ./break_table/destroy
                scoreboard players set #repeat_modify tac.main 1
                align y run function ./modify_table

            if entity @s[tag=table_break] run schedule function ~/ 1t replace

    # Count down until the table is expected to be broken
    schedule function ~/delay_end 2.5s replace:
        execute as @e[type=interaction,tag=table_break] at @s:
            tag @s remove table_break
            data modify entity @s width set value 1.001
            data modify entity @s height set value 0.1895