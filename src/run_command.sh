client_load_balancer() {
  ./resources/load-balancer/client/run
}

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
             --network load-balancer-network \
             -v $(pwd)/$STATIC_CONTENT_DIR/$NGINX_CONF_FILE:/etc/nginx/nginx.conf \
             -v $(pwd)/$STATIC_CONTENT_DIR/site:/usr/share/nginx/html \
             -p 80:80 \
             -d nginx

  echo
  echo "$container_name" > "$RESOURCE_CONTAINER_FILE"

  echo $EXAMPLE_NAME
}

load_balancer() {
  backend_server_instance_number=3
  EXAMPLE_NAME="Example running 'Load balancer'"
  NGINX_CONF_FILE="nginx.conf"
  PREFIX_CONTAINER_NAME="load-balancer-with-nginx"
  RESOURCE_CONTAINER_FILE=".running_resource"
  LOAD_BALANCER_DIR="resources/load-balancer"

  if [ ! -d "$LOAD_BALANCER_DIR" ]; then
    echo "Error: Directory ${LOAD_BALANCER_DIR} not found" >&2
    return 1
  fi

  if [ ! -f "$LOAD_BALANCER_DIR/$NGINX_CONF_FILE" ]; then
    echo "Error: File ${NGINX_CONF_FILE} not found" >&2
    return 1
  fi

  echo "Containers starting..."
  echo "Container ID list:"

  while [ $backend_server_instance_number != 0 ]; do
    i=$backend_server_instance_number
    container_name="$PREFIX_CONTAINER_NAME-$i"

    docker container run --name $container_name \
                         --network load-balancer-network \
                         -e CONTAINER_ID=$i \
                         -e CONTAINER_NAME=$container_name \
                         -d \
                         -p 600$i:3000 \
                         -d backend-server

    echo "$container_name" >> "$RESOURCE_CONTAINER_FILE"

    backend_server_instance_number=$(( i - 1 ))
  done

  echo
  echo "Container 'nginx' starting..."
  echo "Container ID:"

  container_name="load-balancer-with-nginx-0"

  docker run --name $container_name \
             --network load-balancer-network \
             -v $(pwd)/$LOAD_BALANCER_DIR/$NGINX_CONF_FILE:/etc/nginx/nginx.conf \
             -p 80:80 \
             -d nginx

  echo "$container_name" >> "$RESOURCE_CONTAINER_FILE"

  echo
  echo $EXAMPLE_NAME
}

resource_name=${args[name]}

echo "Trying resource: ${resource_name}..."
echo

case "$resource_name" in
  "client-load-balancer")
    client_load_balancer
    ;;
  "serving-static-content")
    serving_static_content
    ;;
  "load-balancer")
    load_balancer
    ;;
  *)
    echo "Resource not found!"
    echo
    ./nginx-basics -h
    ;;
esac
