serving_static_content() {
  EXAMPLE_NAME="Example running 'Serving static content with nginx'"
  INDEX_FILE="site/index.html"
  NGINX_CONF_FILE="nginx.conf"
  RESOURCE_CONTAINER_FILE=".running_resource"
  STATIC_CONTENT_DIR="resources/serving-static-content"

  if [ ! -d "$STATIC_CONTENT_DIR" ]; then
    echo "Error: Directory ${STATIC_CONTENT_DIR} not found" >&2
    return 1
  fi

  if [ ! -f "$STATIC_CONTENT_DIR/$INDEX_FILE" ]; then
    echo "Error: File ${INDEX_FILE} not found" >&2
    return 1
  fi

  if [ ! -f "$STATIC_CONTENT_DIR/$NGINX_CONF_FILE" ]; then
    echo "Error: File ${NGINX_CONF_FILE} not found" >&2
    return 1
  fi

  container_name=serving-static-content-with-nginx

  echo "Container starting..."
  echo "Container ID:"

  docker run --name $container_name \
             -v $(pwd)/$STATIC_CONTENT_DIR/$NGINX_CONF_FILE:/etc/nginx/nginx.conf \
             -v $(pwd)/$STATIC_CONTENT_DIR/site:/usr/share/nginx/html \
             -p 80:80 \
             -d nginx

  echo
  echo "$container_name" > "$RESOURCE_CONTAINER_FILE"

  echo $EXAMPLE_NAME
}

resource_name=${args[name]}

echo "Trying resource: ${resource_name}..."
echo

case "$resource_name" in
  "serving-static-content")
    serving_static_content
    ;;
  *)
    echo "Resource not found!"
    echo
    ./nginx-basics -h
    ;;
esac
