RESOURCE_CONTAINER_FILE=".running_resource"

check_if_resource_file_exists $RESOURCE_CONTAINER_FILE

container_name=$(<"$RESOURCE_CONTAINER_FILE")

echo "Stopping container:"

docker container stop $container_name

echo
echo "Removing container:"

docker container rm $container_name

> "$RESOURCE_CONTAINER_FILE"

echo
echo "Finishing resource example"
echo "See you space cowboy..."
