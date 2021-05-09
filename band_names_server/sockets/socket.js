const { io } = require('../index');

io.on('connection', client => {
  console.log('Client is now connected');
  client.on('disconnect', () => {
    console.log('Client is now gone');
  });
  client.on('message', (payload) => {
    console.log('message: ', payload);
    io.emit('message', { admin: 'New Message' });
  });
});