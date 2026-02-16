import React, { useContext } from 'react';
import { GlobalContext } from '../context/GlobalState';

export const Balance = () => {
    const { transactions } = useContext(GlobalContext);

    const amounts = transactions.map(transaction => transaction.amount);
    const total = amounts.reduce((acc, item) => (acc += item), 0).toFixed(2);
    const sign = total < 0 ? '-' : '';

    return (
        <div className="bg-white p-6 rounded-lg shadow-md mb-6">
            <h4 className="text-gray-500 uppercase text-sm font-semibold">Your Balance</h4>
            <h1 className={`text-4xl font-bold mt-2 ${total < 0 ? 'text-red-600' : 'text-green-600'}`}>
                {sign}${Math.abs(total)}
            </h1>
        </div>
    );
};
