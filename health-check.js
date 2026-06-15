#!/usr/bin/env node
const http = require('http');

const checkServer = (port, name) => {
  return new Promise((resolve) => {
    const req = http.get(`http://localhost:${port}/health`, (res) => {
      if (res.statusCode === 200) {
        console.log(`✅ ${name} server is running on port ${port}`);
        resolve(true);
      } else {
        console.log(`❌ ${name} server returned status ${res.statusCode}`);
        resolve(false);
      }
    });
    
    req.on('error', () => {
      console.log(`❌ ${name} server is not running on port ${port}`);
      resolve(false);
    });
    
    req.setTimeout(5000, () => {
      console.log(`❌ ${name} server timeout on port ${port}`);
      req.destroy();
      resolve(false);
    });
  });
};

const checkServers = async () => {
  console.log('🔍 Checking server status...');
  
  const backendRunning = await checkServer(5000, 'Backend');
  const frontendRunning = await checkServer(3000, 'Frontend');
  
  if (backendRunning && frontendRunning) {
    console.log('\n🎉 All servers are running!');
    console.log('   Frontend: http://localhost:3000');
    console.log('   Backend:  http://localhost:5000');
  } else {
    console.log('\n⚠️  Some servers are not running. Try: npm run dev');
  }
};

checkServers();
