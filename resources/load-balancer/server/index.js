import express from 'express';

const app = express();
const serverPort = process.env.PORT | 3000;

app.use(express.json());

app.get('/', (req, res) => {
  let containerID = process.env.CONTAINER_ID;
  let containerName = process.env.CONTAINER_NAME;

  if (!containerID)
    containerID = "Unknown ID"

  if (!containerName)
    containerName = "Unknown name"

  return res.json({
    message: "Root",
    from: {
      id: containerID,
      name: containerName
    }
  });
});

app.listen(serverPort, () => {
  console.log(`Server running on port ${serverPort}.`);
});
