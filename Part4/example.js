var fs = require('fs')


 var output = fs.readFileSync('data.txt', 'utf8')
 .trim()
 .split('\n')
 .map(line => line.split('\t'))
 
 console.log('output',output)
 
 
  