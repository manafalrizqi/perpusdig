import { pool } from './config/database';

async function apply() {
  await pool.execute(`INSERT INTO settings (setting_key, setting_value, description)
    VALUES ('late_fine', '50000', 'Denda keterlambatan (Rp)')
    ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value), description = VALUES(description)`);
  console.log('Denda keterlambatan diatur ke Rp50.000.');
  await pool.end();
}
apply().catch(error => { console.error(error.message); process.exit(1); });
