import React from 'react';
import pool from '../../utils/postgres';
import Link from 'next/link';

const fetchDataFromDB = async () => {
	try {
		const client = await pool.connect();
		console.log('connected to the db');

		const result = await client.query(
			'SELECT * FROM DONOR ORDER BY lastname, firstname'
		);
		const data = result.rows;
		console.log('Fetched data:', data);
		client.release();
		return data;
	} catch (error) {
		console.error('Error fetching data:', error);
		return [];
	}
};

export default async function MembersPage() {
	const data = await fetchDataFromDB();

	return (
		<div className='flex justify-center items-center min-h-screen bg-gray-50 p-4'>
			<div className='bg-white rounded-lg p-6 shadow-lg w-full max-w-xl'>
				<div className='flex justify-between items-center mb-6'>
					<h3 className='text-2xl font-semibold text-gray-800'>Members</h3>
					<Link
						href='/form'
						className='bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 px-4 rounded-md transition duration-300 ease-in-out'
					>
						Become a Member
					</Link>
				</div>

				<div>
					{data.length > 0 ? (
						data.map((member, index) => (
							<div
								key={member.donorid || index}
								className='flex justify-between items-center py-3 border-b last:border-none'
							>
								<div className='text-lg text-gray-700'>
									{member.firstname} {member.lastname}
								</div>
							</div>
						))
					) : (
						<p className='text-center text-gray-500'>No members found</p>
					)}
				</div>
			</div>
		</div>
	);
}
