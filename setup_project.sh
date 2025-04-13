#!/bin/bash

# Script to automatically create the structure and files for the React/Express Blog project

echo "Starting project structure creation for React/Express Blog..."

# --- Create Directory Structure ---
echo "Creating directories..."
mkdir -p client/src client/public server scripts .devcontainer
echo "-> Directory creation complete."

# --- Create Root Files ---
echo "Creating root files..."

# Root package.json
# (Content remains the same as previously defined - only script comments/output are translated)
cat << 'EOF' > package.json
{
  "name": "react-express-codespaces-blog",
  "version": "1.0.0",
  "description": "Simple Blog with React Frontend and Express Backend for GitHub Codespaces",
  "private": true,
  "scripts": {
    "install:client": "npm install --prefix client",
    "install:server": "npm install --prefix server",
    "install:all": "npm run install:server && npm run install:client && npm install", # Added root npm install
    "dev:client": "npm run dev --prefix client",
    "dev:server": "npm run dev --prefix server",
    "dev": "concurrently \"npm:dev:server\" \"npm:dev:client\"",
    "setup:env": "bash scripts/set-env.sh" # Script to setup env vars
  },
  "keywords": [
    "react",
    "express",
    "codespaces",
    "concurrently",
    "cors"
  ],
  "author": "",
  "license": "ISC",
  "devDependencies": {
    "concurrently": "^7.6.0" # Or latest version
  }
}
EOF
# Note: Added root `npm install` to `install:all` script and `setup:env` script.

# .gitignore (Will be created later with updated content)

echo "-> Root file creation complete."

# --- Create Backend Files (server) ---
echo "Creating Backend files (server)..."

# server/server.js
# (Content remains the same as previously defined)
cat << 'EOF' > server/server.js
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
EOF

# server/package.json
# (Content remains the same as previously defined)
cat << 'EOF' > server/package.json
{
  "name": "blog-backend",
  "version": "1.0.0",
  "description": "Backend API for the simple blog",
  "main": "server.js",
  "type": "module",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "keywords": [
    "express",
    "api",
    "cors",
    "blog"
  ],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "cors": "^2.8.5",
    "dotenv": "^16.0.3",
    "express": "^4.18.2"
  },
  "devDependencies": {
    "nodemon": "^2.0.20"
  }
}
EOF

# server/.env.example
cat << 'EOF' > server/.env.example
# Port for the backend server
PORT=5000

# The exact URL of the frontend application that is allowed to make requests
# In GitHub Codespaces, this will be dynamically generated by scripts/set-env.sh
# or should be set via Codespaces Secrets.
# Example for local development (if frontend runs on 3000): CORS_ORIGIN=http://localhost:3000
CORS_ORIGIN=
EOF

echo "-> Backend file creation complete."

# --- Create Frontend Files (client) ---
echo "Creating Frontend files (client)..."

# client/package.json
# (Content remains the same as previously defined)
cat << 'EOF' > client/package.json
{
  "name": "blog-frontend",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "lint": "eslint . --ext js,jsx --report-unused-disable-directives --max-warnings 0",
    "preview": "vite preview"
  },
  "dependencies": {
    "axios": "^1.4.0",
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.15",
    "@types/react-dom": "^18.2.7",
    "@vitejs/plugin-react": "^4.0.3",
    "eslint": "^8.45.0",
    "eslint-plugin-react": "^7.32.2",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.3",
    "vite": "^4.4.5"
  }
}
EOF

# client/vite.config.js
# (Content remains the same as previously defined)
cat << 'EOF' > client/vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000, // Run frontend on port 3000
    strictPort: true, // Exit if port 3000 is already in use
  }
})
EOF

# client/index.html
# (Content remains the same as previously defined, maybe translate title)
cat << 'EOF' > client/index.html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Simple React Blog</title> </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

# client/src/main.jsx
# (Content remains the same as previously defined)
cat << 'EOF' > client/src/main.jsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './App.css'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
EOF


# client/src/App.jsx
# (Content remains the same, but translating UI text and comments)
cat << 'EOF' > client/src/App.jsx
// client/src/App.jsx
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css'; // Basic styling

function App() {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Get the backend API URL from environment variables (Vite convention)
  const apiUrl = import.meta.env.VITE_API_URL;

  useEffect(() => {
    if (!apiUrl) {
      setError("Error: VITE_API_URL environment variable is not configured in the frontend.");
      setLoading(false);
      return;
    }

    console.log(`Connecting to backend API at: ${apiUrl}`); // Log API URL being used

    // Function to fetch posts
    const fetchPosts = async () => {
      try {
        setLoading(true);
        // Make GET request to the backend endpoint
        const response = await axios.get(`${apiUrl}/api/posts`);
        setPosts(response.data); // Set the fetched posts in state
        setError(null); // Clear any previous errors
      } catch (err) {
        console.error("Error fetching posts:", err);
        // Provide more specific error messages based on the error type
        if (err.response) {
          // The request was made and the server responded with a status code
          // that falls out of the range of 2xx
          setError(`Server Error: ${err.response.status} - ${err.response.statusText}. Check CORS Origin or Backend URL.`);
        } else if (err.request) {
          // The request was made but no response was received
          setError("No response received from server. Is the backend running?");
        } else {
          // Something happened in setting up the request that triggered an Error
          setError(`Error setting up request: ${err.message}`);
        }
        setPosts([]); // Clear posts on error
      } finally {
        setLoading(false); // Set loading to false regardless of success or error
      }
    };

    fetchPosts(); // Call the fetch function
  }, [apiUrl]); // Re-run effect if apiUrl changes (though it shouldn't normally)

  return (
    <div className="App">
      <header className="App-header">
        <h1>Simple Blog</h1> {/* Translated */}
        <p>Connecting to API: <code>{apiUrl || "Not Configured"}</code></p> {/* Translated */}
      </header>
      <main>
        {loading && <p>Loading posts...</p>} {/* Translated */}
        {error && <p style={{ color: 'red' }}>{error}</p>}
        {!loading && !error && (
          <div className="posts-list">
            {posts.length > 0 ? (
              posts.map(post => (
                <article key={post.id} className="post-item">
                  <h2>{post.title}</h2>
                  <p>{post.content}</p>
                </article>
              ))
            ) : (
              <p>No posts to display.</p> // Translated
            )}
          </div>
        )}
      </main>
    </div>
  );
}

export default App;
EOF

# client/src/App.css
# (Content remains the same as previously defined)
cat << 'EOF' > client/src/App.css
/* client/src/App.css */
.App {
  font-family: sans-serif;
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
}

.App-header {
  background-color: #282c34;
  padding: 20px;
  color: white;
  border-radius: 8px;
  margin-bottom: 30px;
  text-align: center;
}

.App-header h1 {
  margin: 0;
}

.App-header code {
  background-color: #444;
  padding: 2px 6px;
  border-radius: 4px;
  font-size: 0.9em;
}

main {
  padding: 10px;
}

.posts-list {
  display: grid;
  gap: 20px;
}

.post-item {
  border: 1px solid #ddd;
  padding: 15px;
  border-radius: 8px;
  background-color: #f9f9f9;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.post-item h2 {
  margin-top: 0;
  color: #333;
}

.post-item p {
  color: #555;
}

p[style*="color: red"] {
  background-color: #ffebee;
  border: 1px solid #e57373;
  padding: 10px;
  border-radius: 4px;
}
EOF

# client/.env.example
cat << 'EOF' > client/.env.example
# The full URL of the backend API server
# In GitHub Codespaces, this will be dynamically generated by scripts/set-env.sh
# or should be set via Codespaces Secrets.
# Example for local development (if backend runs on 5000): VITE_API_URL=http://localhost:5000
VITE_API_URL=
EOF

# client/public/vite.svg (Create empty file or replace with actual SVG)
touch client/public/vite.svg

echo "-> Frontend file creation complete."

# --- Create Codespaces Config Files ---
echo "Creating Codespaces config files (.devcontainer)..."

# .devcontainer/devcontainer.json
# (Content remains the same as previously defined)
cat << 'EOF' > .devcontainer/devcontainer.json
// .devcontainer/devcontainer.json
{
  "name": "React Express Blog",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:0-18", // Or a newer Node version

  "forwardPorts": [
    3000, // Frontend (React/Vite)
    5000  // Backend (Express)
  ],

  // Run after the container is created (first time or rebuild)
  "postCreateCommand": "npm run install:all",

  // Run every time the Codespace starts or reconnects
  // This script automatically creates/updates .env files
  "postStartCommand": "bash scripts/set-env.sh",

  "customizations": {
    "vscode": {
      "extensions": [
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ]
    }
  }
  // Note: .env files should still be added to .gitignore
}
EOF

echo "-> Codespaces config file creation complete."

# --- Create Env Setup Script ---
echo "Creating environment setup script (scripts/set-env.sh)..."
# (Content will be created by the next immersive block)
# Create the directory first
mkdir -p scripts
# Create the file (content will be added in the next step)
touch scripts/set-env.sh
chmod +x scripts/set-env.sh

echo "-> Environment setup script placeholder created."


# --- Final Instructions ---
echo ""
echo "-----------------------------------------------------"
echo " PROJECT CREATION COMPLETE! "
echo "-----------------------------------------------------"
echo ""
echo "Next steps:"
echo "1.  **Review Files:** Check the created files, especially package.json and .devcontainer/devcontainer.json."
echo "2.  **Dependencies:** Dependencies should be installed automatically via 'postCreateCommand' when the Codespace builds."
echo "    If needed, run 'npm run install:all' manually in the root terminal."
echo "3.  **Environment Variables:** The 'postStartCommand' should automatically configure .env files using 'scripts/set-env.sh'."
echo "    Verify client/.env and server/.env contain the correct forwarded URLs after the Codespace starts."
echo "    Alternatively, configure VITE_API_URL and CORS_ORIGIN as Codespaces Secrets in Repository Settings."
echo "4.  **Run Project:** Run 'npm run dev' in the root terminal to start both frontend and backend."
echo "5.  **Access:** Open the forwarded URL for port 3000 in your browser."
echo ""

exit 0
