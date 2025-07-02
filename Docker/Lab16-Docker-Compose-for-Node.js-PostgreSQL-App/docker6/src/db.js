const { Pool } = require('pg');

const pool = new Pool({
  user: 'postgres',
  host: 'db',
  database: 'postgres',
  password: 'postgres',
  port: 5432,
  connectionTimeoutMillis: 5000,
  retryDelay: 1000,
  retryAttempts: 5
});

const testConnection = async () => {
  let attempts = 0;
  while (attempts < 5) {
    try {
      const client = await pool.connect();
      console.log('Successfully connected to PostgreSQL database');
      client.release();
      return true;
    } catch (err) {
      attempts++;
      console.error(`Connection attempt ${attempts} failed: ${err.message}`);
      if (attempts >= 5) {
        console.error('Giving up after 5 attempts');
        return false;
      }
      await new Promise(resolve => setTimeout(resolve, 1000));
    }
  }
};

module.exports = { testConnection };
