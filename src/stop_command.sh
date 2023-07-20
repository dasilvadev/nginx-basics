RESOURCE_CONTAINER_FILE=".running_resource"

check_if_resource_file_exists $RESOURCE_CONTAINER_FILE

echo "Stopping containers:"

while read line
do
  container_name=$line

  docker container stop $container_name
done < "$RESOURCE_CONTAINER_FILE"

echo
echo "Removing containers:"

while read line
do
  container_name=$line

  docker container rm $container_name
done < "$RESOURCE_CONTAINER_FILE"

> "$RESOURCE_CONTAINER_FILE"

echo
echo "Finishing resource example"
echo "See you space cowboy..."
