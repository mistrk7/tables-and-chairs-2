# Replace nearest tables and chairs
say d
execute run function ./replace:
    say -- Replaced
    execute as @e[sort=nearest, type=item_display, tag=tac, distance=..191] at @s:
        execute if entity @s[tag=chair] with entity @s item.components."minecraft:custom_data":
            scoreboard players set @s tac.main 0
            $execute store success score @s tac.main if entity @s[y_rotation= -135..-45] run setblock ~ ~ ~ $(mat)_stairs[facing=east]
            $execute store success score @s tac.main if entity @s[y_rotation= -45..45] run setblock ~ ~ ~ $(mat)_stairs[facing=south]
            $execute store success score @s tac.main if entity @s[y_rotation= 45..135] run setblock ~ ~ ~ $(mat)_stairs[facing=west]
            $execute if score @s tac.main matches 0 run setblock ~ ~ ~ $(mat)_stairs[facing=north]
            scoreboard players reset @s tac.main
            kill @n[type=interaction,tag=chair,distance=0..0.8]
            kill @s
        execute if entity @s[tag=table]:
            setblock ~ ~ ~ oak_planks
            #kill @s (2x)

# If another furniture is found in the same dimension, run teleport
if entity @n[type=item_display, tag=tac] run function ./teleport with storage tac:main convert
if entity @n[type=item_display, tag=tac] run say There's more

# If can't find anymore in end, finish; it's over
execute unless entity @n[type=item_display, tag=tac] if data storage tac:main {convert:{search_dimension:"the_end"}} run function ./finish with storage tac:main convert:

    $execute in $(orig_dimension) run tp $(orig_pos_0) $(orig_pos_1) $(orig_pos_2)
    for i,v in {0:"survival", 1:"creative", 2:"spectator", 3:"adventure"}.items():
        if data storage tac:main {convert:{orig_playerGameType: i }} run gamemode v
    
    data modify storage tac:main convert.search_dimension set value "overworld"
    tag @s remove reverting
    say Elimination done

# If can't find anymore in nether, start again in the end
execute unless entity @n[type=item_display, tag=tac] if data storage tac:main {convert:{search_dimension:"the_nether"}}:
    say e2
    data modify storage tac:main convert.search_dimension set value "the_end"
    function ./teleport with storage tac:main convert

# If can't find anymore in overworld, start again in the nether
execute unless entity @n[type=item_display, tag=tac] if data storage tac:main convert{search_dimension:"overworld"}:
    say e1
    data modify storage tac:main convert.search_dimension set value "the_nether"
    function ./teleport with storage tac:main convert