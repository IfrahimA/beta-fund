import { Pool } from 'pg';

const pool = new Pool({
	host: 'localhost',
	port: '5432',
	user: 'postgres',
	password: process.env.PASSWORD,
	database: 'beta_fund',
});

export default pool;
