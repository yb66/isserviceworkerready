import message from './es6-module.js';
// function message(){
// 	return "Yes";
// }

self.addEventListener('message', function(e) {
	console.log("Before message");
	postMessage(message());
	console.log("After message");
  self.close(); // Terminates the worker.
}, false);

