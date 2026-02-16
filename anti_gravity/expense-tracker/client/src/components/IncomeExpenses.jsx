import React, { useContext } from 'react';
import { GlobalContext } from '../context/GlobalState';

export const IncomeExpenses = () => {
    const { transactions } = useContext(GlobalContext);

    const amounts = transactions.map(transaction => transaction.amount);

    const income = amounts
        .filter(item => item > 0)
        .reduce((acc, item) => (acc += item), 0)
        .toFixed(2);

    const expense = (
        amounts.filter(item => item < 0).reduce((acc, item) => (acc += item), 0) *
        -1
    ).toFixed(2);

    return (
        <div className="flex justify-between gap-4 mb-8">
            <div className="bg-white p-6 rounded-lg shadow-md w-full text-center border-b-4 border-green-500">
                <h4 className="text-gray-500 uppercase text-sm font-semibold">Income</h4>
                <p className="text-2xl font-bold text-green-600">+${income}</p>
            </div>
            <div className="bg-white p-6 rounded-lg shadow-md w-full text-center border-b-4 border-red-500">
                <h4 className="text-gray-500 uppercase text-sm font-semibold">Expense</h4>
                <p className="text-2xl font-bold text-red-600">-${expense}</p>
            </div>
        </div>
    );
};
