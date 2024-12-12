import { Pool } from 'pg';

const pool = new Pool({
	host: 'localhost',
	port: '5432',
	user: 'macuser',
	password: 'lhhl',
	database: 'BetaUFund',
});

export default pool;
