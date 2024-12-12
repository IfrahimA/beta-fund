import { Pool } from 'pg';

const pool = new Pool({
	host: 'localhost',
	port: '5432',
<<<<<<< HEAD
	user: 'macuser',
	password: 'lhhl',
	database: 'BetaUFund',
=======
	user: 'postgres',
	password: process.env.PASSWORD,
	database: 'beta_fund',
>>>>>>> cb034283b4a3f4bb2ee441d1c9a5d93a8f7252d1
});

export default pool;
