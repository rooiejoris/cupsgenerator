import bpy
import sys
 
argv = sys.argv
argv = argv[argv.index("--") + 1:] # get all args after "--"
 
obj_out = argv[0]
 
bpy.ops.export_scene.obj(filepath=obj_out, use_selection=True, axis_forward='-X', axis_up='Z')
