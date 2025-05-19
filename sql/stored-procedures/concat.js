import fs from "fs";
import path from "path";

const files = fs
  .readdirSync(path.join(".", "sql", "stored-procedures"), {
    withFileTypes: true,
  })
  .filter((f) => f.name.endsWith(".sql") && f.name.startsWith("API_TEIM"))
  .map((f) => path.join(".", "sql", "stored-procedures", f.name));

const concatenated = files
  .map((f) => fs.readFileSync(f, "utf-8"))
  .join("\n\nGO\n\n");

fs.writeFileSync(
  path.join(".", "sql", "stored-procedures", "concat.sql"),
  concatenated
);
