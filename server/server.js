// server/server.js
import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';

// Load environment variables from .env file
dotenv.config();

const app = express();
// Use the PORT from environment variables or default to 5000
const port = process.env.PORT || 5000;
// Get the allowed origin for CORS from environment variables
const corsOrigin = process.env.CORS_ORIGIN;

// --- CORS Configuration ---
if (!corsOrigin) {
  // Log an error if CORS_ORIGIN is not set, but continue (allow all origins might be desired in some dev scenarios)
  // In production, you should enforce this or have a stricter default.
  console.warn("Warning: CORS_ORIGIN environment variable not set. CORS might not function as expected.");
}

const corsOptions = {
  // Use the origin defined in the environment variable
  // If corsOrigin is undefined, cors middleware might behave differently based on its version
  // (e.g., allow all origins, or fail). Explicitly handle if needed.
  origin: corsOrigin,
  optionsSuccessStatus: 200 // For legacy browser support
};

// Enable CORS using the configured options
app.use(cors(corsOptions));

// --- API Endpoint ---
// A simple API endpoint to return mock blog posts
app.get('/api/posts', (req, res) => {
  // In a real application, you would fetch this data from a database
  const posts = [
    { id: 1, title: 'Welcome to the Blog!', content: 'This is the first post.' },
    { id: 2, title: 'React and Express', content: 'Building a full-stack web app.' },
    { id: 3, title: 'GitHub Codespaces', content: 'Developing in the cloud.' }
  ];
  res.json(posts);
});

// --- Server Start ---
app.listen(port, () => {
  console.log(`Backend server running at http://localhost:${port}`);
  console.log(`Allowing requests from origin: ${corsOrigin || '(Not configured!)'}`);
});
