const express = require('express');
const crypto = require('crypto');
const router = express.Router();

const mssql = require('../utils/mssql')
const utils = require('../utils/utils')


router.post('/register', async (req, res) => {
	const { userID, email, password } = req.body;

	try {
		const account = await mssql.getAccountByUserID(userID);
		if (account) {
			return res.render('register', { message: 'Username already taken' });
		}

		const salt = utils.generateSalt(12)
		const hashedPassword = crypto.createHash('sha512').update(salt + password).digest('hex');

		await mssql.createUser(userID, email, salt, hashedPassword);

		res.redirect('/');
	} catch (error) {
		console.error(error);
		res.status(500).send('Internal Server Error');
	}
});

router.post('/login', async (req, res) => {
	const { userID, password } = req.body;

	try {
		const user = await mssql.getAccountByUserID(userID)
		if (!user) {
			return res.status(400).send('Invalid username or password');
		}

		const hashedPassword = crypto.createHash('sha512').update(user.Salt + password).digest('hex');
		if (hashedPassword == user.Pw) {
			res.redirect('/');
		} else {
			res.status(400).send('Invalid username or password');
		}
	} catch (error) {
		console.error(error);
		res.status(500).send('Internal Server Error');
	}
});

module.exports = router;