const { testConnection } = require('./db');

(async () => {
  await testConnection();
  
  const http = require('http');
  const server = http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('PostgreSQL Connection Test App\n');
  });
  
  const PORT = 3000;
  server.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
  });
})();
