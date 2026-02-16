const express = require('express');
const cors = require('cors');
const sqlite3 = require('sqlite3').verbose();
const { open } = require('sqlite');

const app = express();
const port = 5001;

app.use(cors()); // Allow all CORS for now
app.use(express.json());

// Database setup
let db;
(async () => {
    try {
        db = await open({
            filename: 'expenses.db',
            driver: sqlite3.Database
        });

        // Initialize table
        await db.exec(`
            CREATE TABLE IF NOT EXISTS transactions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                text TEXT NOT NULL,
                amount REAL NOT NULL,
                type TEXT CHECK(type IN ('income', 'expense')) NOT NULL,
                date TEXT DEFAULT CURRENT_TIMESTAMP
            )
        `);
        console.log('Connected to SQLite database.');
    } catch (err) {
        console.error('Error opening database:', err);
    }
})();

// Routes

// Get all transactions
app.get('/api/transactions', async (req, res) => {
    try {
        const transactions = await db.all('SELECT * FROM transactions ORDER BY date DESC');
        res.json(transactions);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Add transaction
app.post('/api/transactions', async (req, res) => {
    const { text, amount, type } = req.body;
    if (!text || !amount || !type) {
        return res.status(400).json({ error: 'Please provide text, amount, and type' });
    }
    try {
        const result = await db.run(
            'INSERT INTO transactions (text, amount, type) VALUES (?, ?, ?)',
            [text, amount, type]
        );
        const newTransaction = await db.get('SELECT * FROM transactions WHERE id = ?', result.lastID);
        res.status(201).json(newTransaction);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

// Delete transaction
app.delete('/api/transactions/:id', async (req, res) => {
    try {
        const result = await db.run('DELETE FROM transactions WHERE id = ?', req.params.id);
        if (result.changes === 0) {
            return res.status(404).json({ error: 'Transaction not found' });
        }
        res.json({ message: 'Transaction deleted' });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
