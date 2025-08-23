import { connectRabbitMQ } from './src/publisher.js';
import { startServer } from './src/server.js';

startServer();
connectRabbitMQ();
