const http = require('http');
const port = process.env.PORT || 3000;
const started = new Date().toISOString();
http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    service: 'stirrup-deploy-smoke',
    startedAt: started,
    path: req.url,
    ok: true,
  }));
}).listen(port, () => console.log('listening on ' + port));
