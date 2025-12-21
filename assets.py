from beet import Context, Function, Language, JsonFile, Text #< ??

def generate(ctx: Context):                                           # [1]
    
    wood_types = ctx.meta["wood_types"]
    mineral_types = ctx.meta["mineral_types"]

    list_models = ctx.assets.models.match("matkey*")
    list_items = ctx.assets.item_models.match("matkey*")
    list_recipes = ctx.data.recipes.match("matkey*")
    list_advancements = ctx.data.advancements.match("matkey*")

    for model in list_models:
        for type in wood_types:
                
            # Get the source model in namespace
            src_model = ctx.assets.models[model]
            # Get the source model in system path
            handle = JsonFile(source_path= src_model.source_path)

            # Replace instances of 'matkey' in handle with material
            handle.text = handle.text.replace('matkey', type)
            if type == 'crimson' or type == 'warped':
                handle.text = handle.text.replace('log', 'stem')
            if type == 'bamboo':
                handle.text = handle.text.replace('log', 'block')
            # Generate new model file
            newfile_location = model.replace('matkey', type)
            try:
                ctx.assets.models[newfile_location]
            except:
                ctx.assets.models[newfile_location] = handle
            else:
                print(f"{newfile_location} already exists, skipping.") 
        
        del ctx.assets.models[model]

    for item in list_items:
        for type in wood_types:

            # Get the source model in namespace
            src_model = ctx.assets.item_models[item]
            # Get the source model in system path
            handle = JsonFile(source_path= src_model.source_path)

            # Replace instances of 'matkey' in handle with material
            handle.text = handle.text.replace('matkey', type)
            if type == 'crimson' or type == 'warped':
                handle.text = handle.text.replace('log', 'stem')
            if type == 'bamboo':
                handle.text = handle.text.replace('log', 'block')
            # Generate new model file
            newfile_location = item.replace('matkey', type)
            try:
                ctx.assets.item_models[newfile_location]
            except:
                ctx.assets.item_models[newfile_location] = handle
            else:
                print(f"{newfile_location} already exists, skipping.")
        
        del ctx.assets.item_models[item]

    for recipe in list_recipes:
        for type in wood_types:
            
            # Get the source recipe in namespace
            src_recipe = ctx.data.recipes[recipe]
            # Get the source recipe in system path
            handle = JsonFile(source_path= src_recipe.source_path)

            # Replace instances of 'matkey' in handle with material
            handle.text = handle.text.replace('matkey', type)
            if type == 'crimson' or type == 'warped':
                handle.text = handle.text.replace('log', 'stem')
            if type == 'bamboo':
                handle.text = handle.text.replace('log', 'block')
            # Generate new model file
            newfile_location = recipe.replace('matkey', type)
            try:
                ctx.data.recipes[newfile_location]
            except:
                ctx.data.recipes[newfile_location] = handle
            else:
                print(f"{newfile_location} already exists, skipping.")
        
        del ctx.data.recipes[recipe]

    for advancement in list_advancements:
        for type in wood_types:
            
            # Get the source advancement in namespace
            src_advancement = ctx.data.advancements[advancement]
            # Get the source advancement in system path
            handle = JsonFile(source_path= src_advancement.source_path)

            # Replace instances of 'matkey' in handle with material
            handle.text = handle.text.replace('matkey', type)
            if type == 'crimson' or type == 'warped':
                handle.text = handle.text.replace('xlog', 'stem')
            if type == 'bamboo':
                handle.text = handle.text.replace('xlog', 'block')
            handle.text = handle.text.replace('xlog', 'log')
            # Generate new model file
            newfile_location = advancement.replace('matkey', type)
            try:
                ctx.data.advancements[newfile_location]
            except:
                ctx.data.advancements[newfile_location] = handle
            else:
                print(f"{newfile_location} already exists, skipping.")  
                      
        del ctx.data.advancements[advancement]