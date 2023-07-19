RESOURCE_CONTAINER_FILE=".running_resource"

check_if_resource_file_exists $RESOURCE_CONTAINER_FILE

container_name=$(<"$RESOURCE_CONTAINER_FILE")

echo "Restarting container:"

docker container restart $container_name

echo
echo "Done"
echo "Container restarted"
