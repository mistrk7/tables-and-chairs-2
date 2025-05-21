#variables: type, mat, facing (0=south, 90=west, 180=north 270=east)
scoreboard players add tables tac.main 1

$summon minecraft:item_display ~ ~ ~ {\
    Tags:["$(type)","$(mat)","table","tac","v0"],\
    item_display: "fixed",\
    item:{\
        id:"minecraft:armor_stand",\
        components:{\
            "minecraft:item_model": "tac:table/$(type)/$(mat)_$(type)_table",\
            "minecraft:custom_model_data":{\
                floats:[$(state).0f]\
            },\
            "minecraft:max_stack_size":64,\
            "minecraft:entity_data":{\
                id:"minecraft:armor_stand",\
                Invisible:1b,\
                Tags:["table","tac"],\
                equipment:{\
                    feet: {\
                        id: "minecraft:armor_stand",\
                        components: {\
                            "minecraft:custom_data": {\
                            type: "$(type)",\
                            mat: "$(mat)",\
                            model: "table",\
                            tac: 1b\
                            }\
                        }\
                    }\
                },\
                ArmorItems:[{\
                    id:"minecraft:armor_stand",\
                    components:{\
                        "minecraft:custom_data":{\
                            model:"table",\
                            type:"$(type)",\
                            mat:"$(mat)",\
                            tac:1b\
                        }\
                    }\
                }]\
            },\
            "minecraft:custom_data":{\
                model:"table",\
                type:"$(type)",\
                mat:"$(mat)",\
                tac:1b\
            },\
            "minecraft:custom_name":\
                {translate:"tac.table.$(mat).$(type)",italic:false}\
        }\
    }\
}
# (1.21.5) NOTE: ^^ The entity_data changes when the item is placed. The 'ArmorItems' key becomes its own 'data' key, and its contents are of the 'custom_data' value. 

setblock ~ ~ ~ minecraft:oak_trapdoor[half=top,powered=true,open=false]
$setblock ~ ~ ~ minecraft:$(mat)_trapdoor[half=top,powered=true]

$summon minecraft:interaction ~ ~.3115 ~ {Tags:["$(type)","$(mat)","table","tac","v0"], width: 1.001f, height: 0.1895f}