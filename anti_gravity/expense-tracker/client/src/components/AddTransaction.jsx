import React, { useState, useContext } from 'react';
import { GlobalContext } from '../context/GlobalState';

export const AddTransaction = () => {
    const [text, setText] = useState('');
    const [amount, setAmount] = useState(0);

    const { addTransaction } = useContext(GlobalContext);

    const onSubmit = e => {
        e.preventDefault();

        const newTransaction = {
            id: Math.floor(Math.random() * 100000000), // Temp ID logic, backend will assign real ID
            text,
            amount: +amount,
            type: +amount < 0 ? 'expense' : 'income' // logic for type based on sign
        };

        // My backend expects 'type' but I am inferring it or I should change backend to inferred?
        // My backend schema: text, amount, type ('income' or 'expense').
        // Let's pass 'type' explicitly.
        // Actually, usually expense tracker apps just use sign for amount.
        // Let's adjust backend logic if needed, or send 'type' correctly.
        // For now I'll deduce type from amount sign.

        addTransaction(newTransaction);
        setText('');
        setAmount(0);
    };

    return (
        <div className="mt-8">
            <h3 className="border-b-2 border-gray-200 pb-2 mb-4 font-bold text-lg text-gray-700">Add new transaction</h3>
            <form onSubmit={onSubmit}>
                <div className="mb-4">
                    <label htmlFor="text" className="block text-gray-700 font-bold mb-2">Text</label>
                    <input
                        type="text"
                        value={text}
                        onChange={(e) => setText(e.target.value)}
                        placeholder="Enter text..."
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    />
                </div>
                <div className="mb-4">
                    <label htmlFor="amount" className="block text-gray-700 font-bold mb-2">
                        Amount <br />
                        <span className="text-sm font-normal text-gray-500">(negative - expense, positive - income)</span>
                    </label>
                    <input
                        type="number"
                        value={amount}
                        onChange={(e) => setAmount(e.target.value)}
                        placeholder="Enter amount..."
                        className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                    />
                </div>
                <button className="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 px-4 rounded w-full transition duration-300">
                    Add Transaction
                </button>
            </form>
        </div>
    );
};
