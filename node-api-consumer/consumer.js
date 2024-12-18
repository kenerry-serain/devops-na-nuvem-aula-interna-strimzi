const express = require("express");
const { Kafka } = require("kafkajs");

const app = express();

const kafka = new Kafka({ brokers: ["172.20.54.180:9092"] });
const consumer = kafka.consumer({ groupId: "my-group" });

app.get("/consume", async (req, res) => {
  try {
    const { topic } = req.query;

    if (!topic) {
      return res.status(400).send("Topic is required.");
    }

    await consumer.connect();
    await consumer.subscribe({ topic, fromBeginning: true });

    let messages = [];
    await consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        messages.push({ topic, partition, value: message.value.toString() });
      },
    });
  } catch (error) {
    console.log(error);
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log("Consumer API listening on port ${PORT}"));
