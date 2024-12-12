import { Pool } from 'pg';

const pool = new Pool({
	host: 'localhost',
	port: '5432',
	user: 'postgres',
	password: 'Smsia2004$@DSU20261',
	database: 'beta_fund',
});

export default pool;
