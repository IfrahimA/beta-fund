import React from 'react';
import pool from '../../utils/postgres';
import Link from 'next/link';

const fetchDataFromDB = async () => {
	try {
		const client = await pool.connect();
		console.log('connected to the db');

		const result = await client.query('SELECT * FROM DONOR');
		const data = result.rows;
		console.log('Fetched data:', data);
		client.release();
		return data;
	} catch (error) {
		console.error('Error fetching data:', error);
	}
};

export default async function Page() {
	const data = await fetchDataFromDB();
	console.log(data);

	return (
		<div>
			<div className='text-4xl font-bold text-gray-900 mb-4'>Members</div>
			<Link
				href='/form'
				className='bg-orange-500 hover:bg-orange-800 text-white font-bold py-2 px-4 rounded'
			>
				Become a Member
			</Link>
			<div>
				{data.map((donation) => (
					<div
						key={donation.id}
						className='flex justify-between bg-gray-100 rounded p-4 mt-4'
					>
						<div>
							{donation.firstname} {donation.lastname}
						</div>
						<div>{donation.amount}</div>
					</div>
				))}
			</div>
		</div>
	);
}
