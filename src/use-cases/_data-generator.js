/**
 * @param {Awaited<ReturnType<typeof import("./_db-cache.js").createDBCache>>} dbCache
 * @returns {PacienteExtraido}
 */
export function generarPacientePruebaJuanManuelLopezPerez(dbCache) {
  const idIdentidadGeneroMasculina =
    dbCache.obtenerIdentidadGeneroDadoCodigoFHIR("1").id;
  const idSexoBiologicoHombre =
    dbCache.obtenerSexoBiologicoDadoCodigoFHIR("male").id;
  const idPaisChile = dbCache.obtenerPaisDadoCodigoFHIR("152").id;
  const idPuebloOriginarioChango =
    dbCache.obtenerPuebloOriginarioDadoCodigoFHIR("11").id;

  const idTipoIdentificadorRUT =
    dbCache.obtenerTipoIdentificadorPersonaDadoCodigoFHIR("01").id;

  const idTipoIdentificadorRUTProvisorio =
    dbCache.obtenerTipoIdentificadorPersonaDadoCodigoFHIR("02").id;

  const idUsoIdentificadorOficial =
    dbCache.obtenerUsoIdentificadorPersonaDadoCodigoFHIR("official").id;

  const idUsoIdentificadorAntiguo =
    dbCache.obtenerUsoIdentificadorPersonaDadoCodigoFHIR("old").id;

  return {
    nombre: "Juan Manuel",
    apellido_paterno: "Lopez",
    apellido_materno: "Perez",
    fecha_nacimiento: "2001-01-05",
    id_sexo_biologico: idSexoBiologicoHombre,
    id_identidad_genero: idIdentidadGeneroMasculina,
    id_nacionalidad: idPaisChile,
    id_pais_origen: idPaisChile,
    pertenece_a_pueblo_originario: true,
    id_pueblo_originario: idPuebloOriginarioChango,
    identificadores: [
      {
        id_pais_emisor_documento: idPaisChile,
        id_tipo_identificador: idTipoIdentificadorRUT,
        valor: "9640474-3",
        id_uso: idUsoIdentificadorOficial,
      },
      {
        id_pais_emisor_documento: idPaisChile,
        id_tipo_identificador: idTipoIdentificadorRUTProvisorio,
        valor: "36407047-0",
        id_uso: idUsoIdentificadorAntiguo,
      },
    ],
  };
}

/**
 * @param {Awaited<ReturnType<typeof import("./_db-cache.js").createDBCache>>} dbCache
 * @returns {PacienteExtraido}
 */
export function generarPacientePruebaMaria(dbCache) {
  const idIdentidadGeneroNoRevelada =
    dbCache.obtenerIdentidadGeneroDadoCodigoFHIR("7").id;
  const idSexoBiologicoMujer =
    dbCache.obtenerSexoBiologicoDadoCodigoFHIR("female").id;
  const idPaisChile = dbCache.obtenerPaisDadoCodigoFHIR("152").id;
  const idPaisArgentina = dbCache.obtenerPaisDadoCodigoFHIR("032").id;
  const idTipoIdentificadorPasaporte =
    dbCache.obtenerTipoIdentificadorPersonaDadoCodigoFHIR("05").id;

  return {
    nombre: "María",
    fecha_nacimiento: "1997-12-30",
    id_sexo_biologico: idSexoBiologicoMujer,
    id_identidad_genero: idIdentidadGeneroNoRevelada,
    id_nacionalidad: idPaisChile,
    id_pais_origen: idPaisArgentina,
    pertenece_a_pueblo_originario: false,
    identificadores: [
      {
        // No tiene campo 'uso'.
        id_pais_emisor_documento: idPaisArgentina,
        id_tipo_identificador: idTipoIdentificadorPasaporte,
        valor: "ARG20123456789",
      },
    ],
  };
}
