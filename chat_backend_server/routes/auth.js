// path: api/login

const { Router, response } = require('express');
const { check } = require('express-validator');

const { createUser, login, renewToken } = require('../controllers/auth');
const { validateInput } = require('../middlewares/validate-input');
const { validateJWT } = require('../middlewares/validate-jwt');

const router = Router();

router.post('/new', [
  check('name', 'The variable \'name\' is required.').not().isEmpty(),
  check('email', 'The variable \'email\' is required.').isEmail(),
  check('password', 'The variable \'password\' is required.').not().isEmpty(),
  validateInput
], createUser);

router.post('/', [
  check('email', 'The variable \'email\' is required.').isEmail(),
  check('password', 'The variable \'password\' is required.').not().isEmpty(),
  validateInput
], login);

router.get('/renew', validateJWT, renewToken);

module.exports = router;