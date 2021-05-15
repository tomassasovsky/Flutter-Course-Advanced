const { io } = require('../index');

// Socket Messages
io.on('connection', client => {
	console.log('Client is now connected');

	client.on('disconnect', () => {
		console.log('Client is now disconnected');
	});

	// client.on('message', (payload) => {
	// 	console.log('Message', payload);
	// 	io.emit('message', { admin: 'New message' });
	// });
});
