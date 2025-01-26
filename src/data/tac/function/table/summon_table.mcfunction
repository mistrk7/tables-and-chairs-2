#variables: type, mat, facing (0=south, 90=west, 180=north 270=east)

$summon minecraft:item_display ~ ~ ~ {\
    Tags:["$(type)","$(mat)","table","tac","v0"],\
    item_display: "fixed",\
    item:{\
        id:"minecraft:armor_stand",\
        components:{\
            "minecraft:item_model": "tac:table/basic/$(mat)_$(type)_table",\
            "minecraft:custom_model_data":{\
                floats:[0.0f]\
            },\
            "minecraft:max_stack_size":64,\
            "minecraft:entity_data":{\
                id:"minecraft:armor_stand",\
                Invisible:1b,\
                Tags:["table","tac"],\
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
                '{"translate":"tac.table.$(mat).$(type)","italic":false}'\
        }\
    }\
}
setblock ~ ~ ~ minecraft:oak_trapdoor[half=top]

# Full command
#/give @s minecraft:armor_stand[minecraft:max_stack_size=64,minecraft:entity_data={id:"armor_stand", Invisible:1b,Tags:["table","tac"]},minecraft:custom_data={model:"table",type:"basic",mat:"oak",tac:1b},"minecraft:custom_name":'{"translate":"$(type).$(mat).table","italic":false}',minecraft:custom_model_data={strings:["oak_basic_table"]}]

# Typable command
#/give @s minecraft:armor_stand[minecraft:entity_data={id:"armor_stand", Invisible:1b,Tags:["table","tac"]},minecraft:custom_data={model:"table",type:"basic",mat:"warped","tac":1b},minecraft:custom_model_data={strings:["warped_basic_table"]}]