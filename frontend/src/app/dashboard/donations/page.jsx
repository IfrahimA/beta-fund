import React from 'react';
import pool from '../../utils/postgres';

const fetchDonations = async () => {
	try {
		const client = await pool.connect();
		console.log('connected to the db');

		const result = await client.query('SELECT * FROM donor JOIN donation USING(donorid)');
		const data = result.rows;
		console.log('Fetched data:', data);
		client.release();
		return data;
	} catch (error) {
		console.error('Error fetching data:', error);
	}
};

export default async function Page() {
	const data = await fetchDonations(); 

	return (
		<div>
			<div className='text-2xl font-bold text-gray-700 mb-4'>Donations</div>
			<div>
				{data.map((donation) => (
					<div
						key={donation.id}
						className='flex justify-between bg-gray-100 rounded p-4 mt-4'
					>
						<div>
							{donation.firstname} {donation.lastname}
						</div>
						<div>${donation.amount}</div>
					</div>
				))}
			</div>
		</div>
	);
}
