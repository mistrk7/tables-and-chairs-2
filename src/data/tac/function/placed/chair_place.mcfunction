advancement revoke @s only tac:chair_place

scoreboard players set dist= tac.main 501

execute anchored eyes run function ./chair_place/raycast:
    scoreboard players remove dist= tac.main 1

    #Once found
    execute if block ~ ~ ~ minecraft:jungle_trapdoor run function ./chair_place/found with entity @s SelectedItem.components."minecraft:custom_data":
        scoreboard players set dist= tac.main 0
        $execute if block ~ ~ ~ minecraft:jungle_trapdoor[facing= north ] align xyz positioned ~.5 ~ ~.5 run function tac:summon/chair {type:$(type),mat:$(mat),facing: 0 }
        $execute if block ~ ~ ~ minecraft:jungle_trapdoor[facing= east ] align xyz positioned ~.5 ~ ~.5 run function tac:summon/chair {type:$(type),mat:$(mat),facing: 90 }
        $execute if block ~ ~ ~ minecraft:jungle_trapdoor[facing= south ] align xyz positioned ~.5 ~ ~.5 run function tac:summon/chair {type:$(type),mat:$(mat),facing: 180 }
        $execute if block ~ ~ ~ minecraft:jungle_trapdoor[facing= west ] align xyz positioned ~.5 ~ ~.5 run function tac:summon/chair {type:$(type),mat:$(mat),facing: 270 }
        setblock ~ ~ ~ air
    
    execute if score dist= tac.main matches 1.. positioned ^ ^ ^0.01 run function ./chair_place/raycast

scoreboard players reset dist=

#raycast and find the birch trapdoor
#look at what item the player is holding
#summon that item in the position