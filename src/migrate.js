import "dotenv/config";
import {
  createUtilFunctions,
  migrateDown,
  migrateUp,
} from "./migration.utils.js";
import { getDatabaseConnection } from "./utils.js";

/**
 * @param {'up'|'down'|'full'} mode
 * @param {'rollback'|'commit'} onSuccess
 */
async function migrate(mode, onSuccess) {
  const pool = await getDatabaseConnection({
    DB_USER: process.env.DB_USER,
    DB_PASSWORD: process.env.DB_PASSWORD,
    DB_HOST: process.env.DB_HOST,
    DB_NAME: process.env.DB_NAME,
    DB_PORT: process.env.DB_PORT,
  });

  await createUtilFunctions(pool);

  const tran = pool.transaction();

  try {
    await tran.begin();

    if (mode === "full") {
      await migrateDown(tran);
      await migrateUp(tran);
    } else if (mode === "up") {
      await migrateUp(tran);
    } else if (mode === "down") {
      await migrateDown(tran);
    }

    if (onSuccess === "commit") {
      await tran.commit();
    } else if (onSuccess === "rollback") {
      await tran.rollback();
    }
  } catch (error) {
    console.error(JSON.stringify(error, null, 2));
    await tran.rollback();
    throw error;
  }
  await pool.close();
  console.info("OK");
}

const mode = process.argv[3];
if (mode !== "up" && mode !== "down" && mode !== "full") {
  throw new Error(`Invalid mode '${mode}'`);
}
const onSuccess = process.argv[4];
if (onSuccess !== "commit" && onSuccess !== "rollback") {
  throw new Error(`Invalid on success hook '${onSuccess}'`);
}

migrate(mode, onSuccess);
