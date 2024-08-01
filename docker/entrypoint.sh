#!/bin/sh

# Use the following env vars to configure this script
# Only directories containing files directly (not recursively) are supported by this script
# ENVSUBST_ACTIVE (set true)
# ENVSUBST_SRC_DIR
# ENVSUBST_DEST_DIR
# ENVSUBST_STRIP_SUFFIX=.tpl

ENVSUBST_STRIP_SUFFIX=${ENVSUBST_STRIP_SUFFIX:-'.tpl'}

# Strip trailing /
ENVSUBST_SRC_DIR=${ENVSUBST_SRC_DIR%/}
ENVSUBST_DEST_DIR=${ENVSUBST_DEST_DIR%/}

if [ "$ENVSUBST_ACTIVE" = "true" ]; then
  echo "Ensuring $ENVSUBST_DEST_DIR exists"
  mkdir -p "$ENVSUBST_DEST_DIR"

  PWD_PREV="$PWD"

  cd "$ENVSUBST_SRC_DIR" || (echo "ENVSUBST_SRC_DIR $ENVSUBST_SRC_DIR does not exist!" && exit 1)

  for file in *; do
    echo "Substituting env vars in file $ENVSUBST_SRC_DIR/$file to $ENVSUBST_DEST_DIR/${file%"$ENVSUBST_STRIP_SUFFIX"}";
    envsubst < "$file" > "$ENVSUBST_DEST_DIR/${file%"$ENVSUBST_STRIP_SUFFIX"}"
  done
  cd "$PWD_PREV"
fi

# Now do what was definied by CMD
echo "Invoking $*"
exec "${@}"
