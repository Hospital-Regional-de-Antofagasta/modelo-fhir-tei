import "dotenv/config";
import { expect, beforeAll, afterAll, it } from "@jest/globals";
import {
  getDatabaseConnection,
  cargarBundleIniciarEnriquecido,
} from "../utils.js";
import { extraerBundleIniciarEnriquecido } from "./extraer-bundle-iniciar-enriquecido.js";
import {
  obtenerIdentidadGeneroDadoCodigoDEIS,
  obtenerPaisDadoCodigoDEIS,
  obtenerSexoBiologicoDadoCodigoFHIR,
  obtenerTipoIdentificadorPersonaDadoCodigoFHIR,
} from "./db.js";

const bundleIniciarEnriquecido = cargarBundleIniciarEnriquecido();

/** @type {import("mssql").ConnectionPool | undefined} */
let pool = undefined;

beforeAll(async () => {
  pool = await getDatabaseConnection({
    DB_USER: process.env.DB_USER,
    DB_PASSWORD: process.env.DB_PASSWORD,
    DB_HOST: process.env.DB_HOST,
    DB_NAME: process.env.DB_NAME,
    DB_PORT: process.env.DB_PORT,
  });
});

afterAll(async () => {
  if (pool) {
    pool.close();
    pool = undefined;
  }
});

it("Debe extraer los datos del paciente desde el bundle iniciar enriquecido", async () => {
  expect.hasAssertions();

  if (!pool) {
    throw new Error("No hay conexión a la base de datos");
  }

  const { paciente } = await extraerBundleIniciarEnriquecido(
    pool,
    bundleIniciarEnriquecido
  );

  const { id: idIdentidadGeneroNoRevelada } =
    await obtenerIdentidadGeneroDadoCodigoDEIS(pool, "7");

  const { id: idSexoBiologicoMujer } = await obtenerSexoBiologicoDadoCodigoFHIR(
    pool,
    "female"
  );

  const { id: idPaisChile } = await obtenerPaisDadoCodigoDEIS(pool, "152");

  const { id: idTipoIdentificadorRut } =
    await obtenerTipoIdentificadorPersonaDadoCodigoFHIR(pool, "01");

  expect(paciente).toBeDefined();
  expect(paciente.nombre).toBe("Marisol");
  expect(paciente.nombre_social).toBeNull();
  expect(paciente.apellido_paterno).toBe("Pardo");
  expect(paciente.apellido_materno).toBe("Cabrera");
  expect(paciente.fecha_nacimiento).toBe("1961-05-25");
  expect(paciente.id_identidad_genero).toBe(idIdentidadGeneroNoRevelada);
  expect(paciente.id_sexo_biologico).toBe(idSexoBiologicoMujer);
  expect(paciente.id_nacionalidad).toBe(idPaisChile);
  expect(paciente.id_pais_origen).toBe(idPaisChile);
  expect(paciente.pertenece_a_pueblo_afrodescendiente).toBe(false);
  expect(paciente.pertenece_a_pueblo_originario).toBe(false);
  expect(paciente.id_religion).toBeNull();
  expect(paciente.id_pueblo_originario).toBeNull();

  expect(paciente.identificadores).toHaveLength(1);
  expect(paciente.identificadores[0].id_pais_emisor_documento).toBe(
    idPaisChile
  );
  expect(paciente.identificadores[0].id_tipo_identificador).toBe(
    idTipoIdentificadorRut
  );
  expect(paciente.identificadores[0].valor).toBe("9640474-3");
});
