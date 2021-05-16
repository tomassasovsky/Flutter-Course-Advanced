const { authenticateJWT } = require('../helpers/jwt');
const { io } = require('../index');
const { userConnected, userDisconnected, saveMessage } = require('../controllers/socket');

// Socket Messages
io.on('connection', (client) => {
	const [valid, uid] = authenticateJWT(client.handshake.headers['x-token']);

	if (!valid) { return client.disconnect(); }

	userConnected(uid);
	client.join(uid);

	client.on('personal-message', async (payload) => {
		await saveMessage(payload);
		io.to(payload.to).emit('personal-message', payload);
	});

	client.on('disconnect', () => {
		userDisconnected(uid);
	});
});
