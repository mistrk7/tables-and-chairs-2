#variables: type, mat, facing (0=south, 90=west, 180=north 270=east)
scoreboard players add chairs tac.main 1

$summon minecraft:item_display ~ ~.6 ~ {\
    Rotation:[$(facing).0f,0.0f],\
    transformation:{scale:[1.0f,1.0f,1.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.0f,-0.1f,0.0f]},\
    Tags:["$(type)","$(mat)","chair","tac","v0"],\
    teleport_duration: 1,\
    item:{\
        id:"minecraft:armor_stand",\
        components:{\
            "minecraft:item_model": "tac:chair/$(type)/$(mat)_$(type)_chair",\
            "minecraft:custom_model_data":{\
                strings:[""]\
            },\
            "minecraft:max_stack_size":64,\
            "minecraft:entity_data":{\
                id:"minecraft:armor_stand",\
                Invisible:1b,\
                Tags:["chair","tac"],\
                equipment:{\
                    feet: {\
                        id: "minecraft:armor_stand",\
                        components: {\
                            "minecraft:custom_data": {\
                            type: "$(type)",\
                            mat: "$(mat)",\
                            model: "chair",\
                            tac: 1b\
                            }\
                        }\
                    }\
                },\
                ArmorItems:[{\
                    id:"minecraft:armor_stand",\
                    components:{\
                        "minecraft:custom_data":{\
                            model:"chair",\
                            type:"$(type)",\
                            mat:"$(mat)",\
                            tac:1b\
                        }\
                    }\
                }]\
            },\
            "minecraft:custom_data":{\
                model:"chair",\
                type:"$(type)",\
                mat:"$(mat)",\
                tac:1b\
            },\
            "minecraft:custom_name":\
                {translate:"tac.chair.$(mat).$(type)",italic:false}\
        }\
    }\
}
# (1.21.5) NOTE: ^^ The entity_data changes when the item is placed. The 'ArmorItems' key becomes its own 'data' key, and its contents are of the 'custom_data' value. 
# (1.21.5 v0.3) NOTE: Added 'equipment' key for backwards compatiblity with v0.0 items. For reference, every time a data type is completely revised, it may just duplicate the key. 
$summon minecraft:interaction ~ ~ ~ {Tags:["$(type)","$(mat)","chair","tac","v0"], width: 0.75f, height: 1.2f}