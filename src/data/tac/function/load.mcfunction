scoreboard objectives add tac.main dummy
function tac:loop

# Kill misplaced armor stands if they were placed with the pack disabled. 
kill @e[type=armor_stand, tag=tac, tag=!pressure]

#Add table and chair counters (version 0.1 and onward)W

data merge storage tac:main {
    version:0,
    destroyCount:0,
    objectCount:0
}

# Old version detection and suggestion
schedule function ./load_detect_old 1s:
    execute if entity @e[limit=1, tag=tac.V5.0] run tellraw @a ["",{"text":"[T&C2]: "},{"text":"Old & broken Tables & Chairs detected. ","color":"yellow"},{"text":"Click Here","color":"aqua","clickEvent":{"action":"suggest_command","value":"/function tac:xxx/upgrade"}},{"text":" for the command to upgrade those that are in loaded chunks, or click ","color":"yellow"},{"text":"here","color":"aqua","clickEvent":{"action":"suggest_command","value":"/function tac:xxx/clear/legacy"}},{"text":" to delete them. ","color":"yellow"}]

# WHEN UPDATING VERSION: Replace all instances of 'v(current version)' in the project with 'v(next version)'


# All items - Looks through recipes folder and creates a give command for all items there. (Python script)
import os

recipes = './src/data/tac/recipe'
materials = ['acacia', 'bamboo', 'birch', 'cherry', 'crimson', 'dark_oak', 'jungle', 'mangrove', 'oak', 'pale_oak', 'spruce', 'warped']

def create_list(recipes):
    models = {}
    for model_name in os.listdir(recipes):
        model_path = os.path.join(recipes, model_name)
        if os.path.isdir(model_path):
            models[model_name] = {'type': [], 'mat': materials}
            for type_name in os.listdir(model_path):
                type_path = os.path.join(model_path, type_name)
                if os.path.isdir(type_path):
                    models[model_name]['type'].append(type_name)
    return models
models = create_list(recipes)

# Give command

def data_component(model, mat, type):
    if model == 'chair':
        return (f"{{strings:[\"\"]}},")
    elif model == 'table':
        return (f"{{floats:[0.0f]}},")
    else:
        return (f"{{strings:[\"\"]}},")

for model, property in models.items():
    for type in property['type']:
        if type == 'throne':
            property['mat'] = materials + ['iron', 'gold', 'diamond', 'netherite', 'copper', 'obsidian', 'quartz', 'stone_brick'] 
        for mat in property['mat']:
            item_components = (
                f"minecraft:item_model=\"tac:{model}/{type}/{mat}_{type}_{model}\","+
                f"minecraft:custom_model_data="+data_component(model, mat, type)+
                f"minecraft:max_stack_size=64,"+
                f"minecraft:entity_data={{id:\"minecraft:armor_stand\",Invisible:1b,Tags:[\"{model}\",\"tac\"],"+
                f"equipment:{{feet:{{id:\"minecraft:armor_stand\",components:{{\"minecraft:custom_data\":{{type:\"{type}\",mat:\"{mat}\",model:\"{model}\",tac:1b}}}}}}}},"+
                f"ArmorItems:[{{id:\"minecraft:armor_stand\",components:{{\"minecraft:custom_data\":{{"+
                f"model:\"{model}\",type:\"{type}\",mat:\"{mat}\",tac:1b}}}}}}]}},"+
                f"minecraft:custom_data={{model:\"{model}\",type:\"{type}\",mat:\"{mat}\",tac:1b}},"+
                f"minecraft:custom_name={{translate:\"tac.{model}.{mat}.{type}\",italic:false}}"
            )
            the_item = 'minecraft:armor_stand['+item_components+']'
            func_id = f"tac:give/{model}_{mat}_{type}"
            function func_id:
                give @s the_item 16