const mongoose = require('mongoose');

const dbConnection = async () => {
  try {
    console.log('Init DB Config');
    mongoose.connect(
      process.env.DB_CNN,
      {
        useNewUrlParser: true,
        useCreateIndex: true,
        useUnifiedTopology: true
      },
    );
    console.log('DB Online');
  } catch (error) {
    console.log(error);
    throw new Error('DB Error');
  }
}

module.exports = {
  dbConnection,
}