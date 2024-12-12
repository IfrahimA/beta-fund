import React from 'react';
import pool from '../utils/postgres';

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

	return (
		<div>
			Dashboard
		</div>
	);
}
