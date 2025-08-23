import express from 'express';
import { cameras } from './data.js';

const app = express();
const port = 3000;

// Route: /cameras -> list cameras
app.get('/cameras', (req, res) => {
  res.json(cameras);
});

// Route: /cameras/:id/video -> stream a video file
app.get('/cameras/:id/video', async (req, res) => {
  const { id } = req.params;

  // You can assign a different video per camera if you want
  // For now, all cameras return the same test video
  const videoPath = 'public/sample_video.mp4';

  // Support video streaming
  const fs = await import('fs');
  const stat = fs.statSync(videoPath);
  const fileSize = stat.size;
  const range = req.headers.range;

  if (range) {
    const parts = range.replace(/bytes=/, '').split('-');
    const start = parseInt(parts[0], 10);
    const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;

    const chunksize = end - start + 1;
    const file = fs.createReadStream(videoPath, { start, end });
    const head = {
      'Content-Range': `bytes ${start}-${end}/${fileSize}`,
      'Accept-Ranges': 'bytes',
      'Content-Length': chunksize,
      'Content-Type': 'video/mp4',
    };

    res.writeHead(206, head);
    file.pipe(res);
  } else {
    const head = {
      'Content-Length': fileSize,
      'Content-Type': 'video/mp4',
    };
    res.writeHead(200, head);
    fs.createReadStream(videoPath).pipe(res);
  }
});

export const startServer = () => {
  app.listen(port, () => {
    console.log(`Security camera server running at http://localhost:${port}`);
  });
};
