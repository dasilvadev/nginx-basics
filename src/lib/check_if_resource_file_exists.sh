check_if_resource_file_exists() {
  RESOURCE_CONTAINER_FILE=$1

  if [ ! -f "$RESOURCE_CONTAINER_FILE" ]; then
    echo "Error: File '${RESOURCE_CONTAINER_FILE}' not found" >&2
    return 1
  fi

  if [ ! -s "$RESOURCE_CONTAINER_FILE"  ]; then
    echo "Error: Container name not found" >&2
    return 1
  fi
}
