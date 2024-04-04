const express = require('express');
const router = express.Router();

router.get('/CONFIG.ini', (req, res) => {
	const filename = 'CONFIG.ini';
	const filePath = path.join(__dirname, 'ressources', filename);

	fs.stat(filePath, (err, stats) => {
		if (err) {
			return res.status(404).send('File not found');
		}

		if (stats.isFile()) {
			res.download(filePath, filename, (err) => {
				if (err) {
					res.status(500).send('Error downloading file');
				}
			});
		} else {
			res.status(400).send('Not a file');
		}
	});
});

router.get('/shaiya/:filename', (req, res) => {
	const filename = req.params.filename;
	const filePath = path.join(__dirname, 'ressources/update_files', filename);

	fs.stat(filePath, (err, stats) => {
		if (err) {
			return res.status(404).send('File not found');
		}

		if (stats.isFile()) {
			res.download(filePath, filename, (err) => {
				if (err) {
					res.status(500).send('Error downloading file');
				}
			});
		} else {
			res.status(400).send('Not a file');
		}
	});
});

module.exports = router;