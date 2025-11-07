#variables: type, mat, facing (0=south, 90=west, 180=north 270=east)
scoreboard players add chairs tac.main 1

$summon minecraft:item_display ~ ~.6 ~ {\
    Rotation:[$(facing).0f,0.0f],\
    item_display: "fixed",\
    Tags:["$(type)","$(mat)","bench","tac","v0"],\
    interpolation_duration: 2,\
    item:{\
        id:"minecraft:armor_stand",\
        components:{\
            "minecraft:item_model": "tac:bench/$(type)/$(mat)_$(type)_bench",\
            "minecraft:custom_model_data":{\
                floats:[$(state).0f]\
            },\
            "minecraft:max_stack_size":64,\
            "minecraft:entity_data":{\
                id:"minecraft:armor_stand",\
                Invisible:1b,\
                Tags:["bench","tac"],\
                equipment:{\
                    feet: {\
                        id: "minecraft:armor_stand",\
                        components: {\
                            "minecraft:custom_data": {\
                            type: "$(type)",\
                            mat: "$(mat)",\
                            rotation:0,\
                            model: "bench",\
                            tac: 1b\
                            }\
                        }\
                    }\
                },\
                ArmorItems:[{\
                    id:"minecraft:armor_stand",\
                    components:{\
                        "minecraft:custom_data":{\
                            model:"bench",\
                            type:"$(type)",\
                            mat:"$(mat)",\
                            rotation:0,\
                            tac:1b\
                        }\
                    }\
                }]\
            },\
            "minecraft:custom_data":{\
                model:"bench",\
                type:"$(type)",\
                mat:"$(mat)",\
                rotation:$(facing),\
                tac:1b\
            },\
            "minecraft:custom_name":\
                {translate:"tac.bench.$(mat).$(type)",italic:false}\
        }\
    }\
}
# (1.21.5 v0.3) NOTE: Added 'equipment' key for backwards compatiblity with v0.0 items. For reference, every time a data type is completely revised, it may just duplicate the key. 
$summon minecraft:interaction ~ ~-.0025 ~ {Tags:["$(type)","$(mat)","bench","tac","v0"], width: 1.005f, height: 1.005f}
setblock ~ ~ ~ minecraft:barrier