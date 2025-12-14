from beet import Context, Function, Language, JsonFile, Text #< ??

def generate(ctx: Context):                                           # [1]
    
    wood_types = ctx.meta["wood_types"]
    mineral_types = ctx.meta["mineral_types"]

    list_models = ctx.assets.models.match("matkey*")
    list_items = ctx.assets.item_models.match("matkey*")

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
            ctx.assets.models[newfile_location] = handle

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
            ctx.assets.item_models[newfile_location] = handle