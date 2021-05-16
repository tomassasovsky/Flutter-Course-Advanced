const { response } = require('express');
const Message = require('../models/message');

const getChat = async (req, res = response) => {
  const personalId = req.uid;
  const messagesFrom = req.params.from;

  const last30 = await Message
    .find({ $or: [{ from: personalId, to: messagesFrom }, { from: messagesFrom, to: personalId, }] })
    .sort({ createdAt: 'desc' })
    .limit(30);

  res.json({
    ok: true,
    messages: last30
  });
}

module.exports = {
  getChat
}