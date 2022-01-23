# Heroku Buildpack for Godot Engine

Directly host a Godot server on Heroku directly from the source code without exporting.

# Features
- Export Godot server build from source code
- Run Godot server build from .pck file

# Config Vars
- GODOT_VERSION - The version of stable Godot to use (eg. 3.3.4)
- HEROKU_URL - The web URL of the heroku app (eg. https://your-app-name.herokuapp.com)

### Export from source code
- Upload the entire source code of the Godot project to Heroku
- Ensure that the `project.godot` and `export_presets.cfg` files are present
- The `export_presets.cfg` file musht have a preset named `Linux/X11`

### Run from .pck file
- Only two files needed: a `.pck` file and a Godotpack file
- Only host the `.pck` file on Heroku (It must be a `Linux/X11` export)
- Make a `Godotpack` file (no extension) and it in type the name of the pck file
- Eg. If you export the project as `server.pck`, in the `Godotpack` file simply type `server.pck`

Modified hybrid version of [heroku-buildpack-godot](https://github.com/lethiandev/heroku-buildpack-godot) and [godot-server-buildpack](https://github.com/Abdera7mane/godot-server-buildpack)