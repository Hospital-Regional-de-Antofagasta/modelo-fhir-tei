import { obtenerIdentidadesGenero } from "./obtener-identidades-genero";
import { obtenerPaises } from "./obtener-paises";
import { obtenerPueblosOriginarios } from "./obtener-pueblos-originarios";
import { obtenerSexosBiologicos } from "./obtener-sexos-biologicos";
import { obtenerTiposIdentificadorPersona } from "./obtener-tipos-identificador-persona";
import { obtenerUsosIdentificadorPersona } from "./obtener-usos-identificador-persona";

/** @type{Map<string, { codigo_fhir: string, texto: string, id: string }[]>} */
const cache = new Map();

function obtenerIdentidadGeneroDadoCodigoFHIR(codigoFhir) {
  const found = cache
    .get("identidadesGenero")
    ?.find((identidad) => identidad.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerSexoBiologicoDadoCodigoFHIR(codigoFhir) {
  const found = cache
    .get("sexosBiologicos")
    ?.find((sexo) => sexo.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerPaisDadoCodigoFHIR(codigoFhir) {
  const found = cache
    .get("paises")
    ?.find((pais) => pais.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerPuebloOriginarioDadoCodigoFHIR(codigoFhir) {
  const found = cache
    .get("pueblosOriginarios")
    ?.find((pueblo) => pueblo.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerTipoIdentificadorPersonaDadoCodigoFHIR(codigoFhir) {
  const found = cache
    .get("tiposIdentificadorPersona")
    ?.find((tipo) => tipo.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

function obtenerUsoIdentificadorPersonaDadoCodigoFHIR(codigoFhir) {
  const found = cache
    .get("usosIdentificadorPersona")
    ?.find((uso) => uso.codigo_fhir === codigoFhir);
  if (found === undefined) throw new Error();
  return found;
}

const functions = {
  obtenerIdentidadGeneroDadoCodigoFHIR,
  obtenerSexoBiologicoDadoCodigoFHIR,
  obtenerPaisDadoCodigoFHIR,
  obtenerPuebloOriginarioDadoCodigoFHIR,
  obtenerTipoIdentificadorPersonaDadoCodigoFHIR,
  obtenerUsoIdentificadorPersonaDadoCodigoFHIR,
};

/**
 * @param {TransactionOrConnectionPool} pool
 */
export async function createDBCache(pool) {
  if (cache.size === 0) {
    cache.set("sexosBiologicos", await obtenerSexosBiologicos(pool));
    cache.set("identidadesGenero", await obtenerIdentidadesGenero(pool));
    cache.set("paises", await obtenerPaises(pool));
    cache.set("pueblosOriginarios", await obtenerPueblosOriginarios(pool));
    cache.set(
      "tiposIdentificadorPersona",
      await obtenerTiposIdentificadorPersona(pool)
    );
    cache.set(
      "usosIdentificadorPersona",
      await obtenerUsosIdentificadorPersona(pool)
    );
  }

  return functions;
}
