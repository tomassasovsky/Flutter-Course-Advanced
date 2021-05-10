const { io } = require('../index');
const Bands = require('../models/bands');
const Band = require('../models/band');

const bands = new Bands();

bands.addBand(new Band('Queen'));
bands.addBand(new Band('Bon Jovi'));
bands.addBand(new Band('U2'));
bands.addBand(new Band('Metallica'));

io.on('connection', client => {
  console.log('Client is now connected');
  io.emit('active-bands', bands.getBands());

  client.on('disconnect', () => {
    console.log('Client is now gone');
  });

  client.on('message', (payload) => {
    console.log('message: ', payload);
    io.emit('message', { admin: 'New Message' });
  });

  client.on('new-message', (payload) => {
    client.broadcast.emit('new-message', payload);
  });

  client.on('vote-band', (payload) => {
    bands.voteBand(payload.id);
    io.emit('active-bands', bands.getBands());
  });

  client.on('add-band', (payload) => {
    bands.addBand(new Band(payload.name));
    io.emit('active-bands', bands.getBands());
  });

  client.on('delete-band', (payload) => {
    bands.deleteBand(payload.id);
    io.emit('active-bands', bands.getBands());
  });
});