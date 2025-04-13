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
