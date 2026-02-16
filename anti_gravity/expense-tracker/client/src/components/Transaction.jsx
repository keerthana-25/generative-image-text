import React, { useContext } from 'react';
import { GlobalContext } from '../context/GlobalState';
import { Trash2 } from 'lucide-react';

export const Transaction = ({ transaction }) => {
    const { deleteTransaction } = useContext(GlobalContext);

    const sign = transaction.amount < 0 ? '-' : '+';
    const borderClass = transaction.amount < 0 ? 'border-r-4 border-red-500' : 'border-r-4 border-green-500';

    return (
        <li className={`bg-white shadow-md p-3 my-2 rounded flex justify-between items-center relative group ${borderClass}`}>
            <span className="font-medium text-gray-700">{transaction.text}</span>
            <span className="font-bold text-gray-800 mr-8">
                {sign}${Math.abs(transaction.amount)}
            </span>
            <button
                onClick={() => deleteTransaction(transaction.id)}
                className="absolute right-0 top-1/2 transform -translate-y-1/2 bg-red-500 text-white p-2 rounded-l opacity-0 group-hover:opacity-100 transition-opacity duration-300"
            >
                <Trash2 size={16} />
            </button>
        </li>
    );
};
