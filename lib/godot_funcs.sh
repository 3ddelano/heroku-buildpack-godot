function download_godot_headless() {
  local VERSION=$1
  GODOT_HEADLESS_URL=https://downloads.tuxfamily.org/godotengine/${VERSION}/Godot_v${VERSION}-stable_linux_headless.64.zip

  if [ ! -f $CACHE_DIR/godot_headless.64 ]; then
    output_section "Downloading Godot Headless v$VERSION"
    curl -s $GODOT_HEADLESS_URL -o godot-headless.zip || exit 1
    unzip -o godot-headless.zip
    cp Godot_v${VERSION}-stable_linux_headless.64 $CACHE_DIR/godot_headless.64
    touch "$CACHE_DIR/._sc_"
  else
    output_section "Using cached Godot v$VERSION Headless executable"
  fi
  cp $CACHE_DIR/godot_headless.64 $BUILD_DIR/godot_headless.64
  # Godot headless is stored at $CACHE_DIR/godot_headless.64
  output_section "Godot Headless setup done"
}

function download_godot_server() {
  local VERSION=$1
  GODOT_SERVER_URL=https://downloads.tuxfamily.org/godotengine/${VERSION}/Godot_v${VERSION}-stable_linux_server.64.zip

  if [ ! -f $CACHE_DIR/godot_server.64 ]; then
    output_section "Downloading Godot Server Executable..."
    curl -s $GODOT_SERVER_URL -o godot-server.zip || exit 1
    unzip -o godot-server.zip
    cp Godot_v${VERSION}-stable_linux_server.64 $CACHE_DIR/godot_server.64
    touch "$CACHE_DIR/._sc_"
  else
    output_section "Using cached Godot v$VERSION Server executable"
  fi
  cp $CACHE_DIR/godot_server.64 $BUILD_DIR/godot_server.64
  # Godot server is stored at $CACHE_DIR/godot_server.64
  output_section "Godot Headless setup done"
}

function download_godot_templates() {
  local VERSION=$1
  GODOT_TEMPLATES_URL=https://downloads.tuxfamily.org/godotengine/${VERSION}/Godot_v${VERSION}-stable_export_templates.tpz
  TEMPLATES_DEST="$CACHE_DIR/editor_data/templates/${VERSION}.stable"

  if [ ! -f $TEMPLATES_DEST/linux_x11_64_release ]; then
    output_section "Downloading Godot Templates..."
    curl -s $GODOT_TEMPLATES_URL -o godot-templates.zip || exit 1
    unzip -o godot-templates.zip
    mkdir -p $TEMPLATES_DEST
    cp templates/linux_x11_64_debug $TEMPLATES_DEST
    cp templates/linux_x11_64_release $TEMPLATES_DEST
  else
    output_section "Using cached Godot Linux/X11 x64 Templates"
  fi

  # Godot export templates are stored at $CACHE_DIR/editor_data/templates/${VERSION}.stable
  output_section "Godot Templates setup done"
}

function export_godot_project() {
  OUTPUT_DEST="$BUILD_DIR/dist"
  OUTPUT_FILE="$OUTPUT_DEST/linux.pck" 

  output_section "Exporting Godot Project..."
  output_line "Target: '$OUTPUT_FILE'"

  mkdir -p $OUTPUT_DEST

  # Export the project to Linux/X11
  # (The project must have a Linux/X11 export template setup)
  # source: $BUILD_DIR
  # destination: $OUTPUT_FILE
  $CACHE_DIR/godot_headless.64 --path "$BUILD_DIR" --export-pack "Linux/X11" "$OUTPUT_FILE" || exit 1
}

function make_simple_webpage() {
  output_section "Making simple webpage..."
  mkdir -p $BUILD_DIR/__site
  touch $BUILD_DIR/__site/index.html
  echo "<!DOCTYPE html><html><head><title>Godot Server</title></head><body><h1>Godot Server running...</h1><p><a href=\"https://github.com/3ddelano/heroku-buildpack-godot\">Make your own</a></p></body></html>" > $BUILD_DIR/__site/index.html
}