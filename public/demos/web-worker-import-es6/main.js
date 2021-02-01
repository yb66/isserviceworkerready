window.addEventListener('load', () => {
	const worker = new Worker('web-worker.js', { type: "module" });
	worker.postMessage("Begin"); // Start the worker.
	worker.addEventListener('message', function(e) {
		console.log(`Received message from worker: ${e.data}`);
		const elem = document.getElementById('the-answer');
		elem.textContent = `Worker says ${e.data}`;
	}, false);
});