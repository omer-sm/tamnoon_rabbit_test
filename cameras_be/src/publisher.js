import { cameras } from './data.js';
import amqplib from 'amqplib';

export const connectRabbitMQ = async () => {
  try {
    const connection = await amqplib.connect("amqp://localhost");
    const channel = await connection.createChannel();

    const exchange = "camera_alerts";
    await channel.assertExchange(exchange, "topic", { durable: false });

    console.log("✅ Connected to RabbitMQ exchange:", exchange);

    function publishAlert() {
      const camera = cameras[Math.floor(Math.random() * cameras.length)];
      const messages = [
        "Motion detected",
        "Low battery",
        "Loitering detected"
      ];
      const message = messages[Math.floor(Math.random() * messages.length)];

      const alert = {
        cameraId: camera.id,
        category: camera.category,
        message,
        timestamp: new Date().toISOString(),
      };

      const routingKey = camera.category.toLowerCase(); // "home" or "outside"

      channel.publish(exchange, routingKey, Buffer.from(JSON.stringify(alert)));
      console.log(`📤 Published alert (${routingKey}):`, alert);
    }

    setInterval(publishAlert, 10000);
  } catch (err) {
    console.error("❌ RabbitMQ connection error:", err);
  }
};
