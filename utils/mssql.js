const sql = require('mssql');
require('dotenv').config(); // For local dev purposes only

const dbConfig = {
	user: process.env.MSSQL_USER,
	password: process.env.MSSQL_PASSWORD,
	database: process.env.MSSQL_DB,
	server: process.env.MSSQL_ADDR,
	pool: {
		max: 10,
		min: 0,
		idleTimeoutMillis: 30000
	},
	options: {
		// change to true for local dev / self-signed certs
		trustServerCertificate: true
	}
}

async function createUser(userID, email, salt, hashedPassword) {
	try {
		const pool = await sql.connect(dbConfig);

		const createAccount = await pool.request()
			.input('userID', sql.NVarChar, userID)
			.input('email', sql.NVarChar, email)
			.input('password', sql.NVarChar, hashedPassword)
			.input('joinDate', sql.SmallDateTime, new Date())
			.input('salt', sql.NText, salt)
			.query('INSERT INTO dbo.Users_Master (UserID, Pw, JoinDate, Admin, AdminLevel, UseQueue, Status, Leave, UserType, Point, Email, Salt) \
					VALUES (@userID, @password, @joinDate, 0, 0, 0, 0, 0, \'N\', 0, @email, @salt)');
	} catch (e) {
		console.log(e)
	}
}

async function getAccountByUserID(userID) {
	try {
		const pool = await sql.connect(dbConfig);

		const response = await pool.request()
			.input('UserID', sql.NVarChar, userID)
			.query('SELECT UserID, Pw, Salt FROM dbo.Users_Master WHERE UserID = @UserID');

		if (response.recordset.length != 0)
			return response.recordset[0];
		else
			return null;
	} catch (e) {
		console.log(e)
	}
}

module.exports = { createUser, getAccountByUserID };