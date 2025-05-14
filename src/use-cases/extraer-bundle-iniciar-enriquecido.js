import {
  obtenerIdentidadGeneroDadoCodigoDEIS,
  obtenerPaisDadoCodigoDEIS,
  obtenerSexoBiologicoDadoCodigoFHIR,
  obtenerTipoIdentificadorPersonaDadoCodigoFHIR,
  obtenerUsoIdentificadorPersonaDadoCodigoFHIR,
} from "./db";

/**
 * @param {{ entry: object[]}} bundle
 * @param {string} perfil
 * @returns {object[]}
 */
function extraerSlicesDesdeBundle(bundle, perfil) {
  return bundle.entry.filter(
    (e) => e.resource.meta.profile[0].split("/").pop() === perfil
  );
}

/**
 * @param {object[]} extension
 * @param {string} url
 * @returns {object}
 */
function extraerSliceDesdeExtension(extension, url) {
  return extension.find((e) => e.url.split("/").pop() === url);
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {{ resource: { name: object, identifier: object[], extension: object[], birthDate: string, gender: string }}} slice
 * @returns {Promise<object>}
 */
async function extraerPacienteDesdeSlice(tran, slice) {
  const { name, identifier, extension, birthDate, gender } = slice.resource;

  const codigoIdentidadGenero = extraerSliceDesdeExtension(
    extension,
    "IdentidadDeGenero"
  ).valueCodeableConcept.coding[0].code;

  const codigoNacionalidad = extraerSliceDesdeExtension(
    extension,
    "CodigoPaises"
  ).valueCodeableConcept.coding[0].code;

  const codigoPaisOrigen = extraerSliceDesdeExtension(
    extension,
    "PaisOrigenMPI"
  ).valueCodeableConcept.coding[0].code;

  const pertenecientePuebloOriginario = extraerSliceDesdeExtension(
    extension,
    "PueblosOriginariosPerteneciente"
  ).valueBoolean;

  const pertenecientePuebloAfrodescendiente = extraerSliceDesdeExtension(
    extension,
    "PueblosAfrodescendiente"
  ).valueBoolean;

  /** @type {PacienteExtraido["identificadores"]} */
  const identificadores = [];
  for (const _identificador of identifier) {
    const codigoTipoIdentificador = _identificador.type.coding.find(
      (c) => c.system.split("/").pop() === "CSTipoIdentificador"
    ).code;

    const codigoPaisEmisorDocumento = extraerSliceDesdeExtension(
      _identificador.type.extension,
      "CodigoPaises"
    ).valueCodeableConcept.coding.find(
      (c) => c.system.split("/").pop() === "CodPais"
    ).code;

    const identificador = {
      id_pais_emisor_documento: (
        await obtenerPaisDadoCodigoDEIS(tran, codigoPaisEmisorDocumento)
      ).id,
      id_tipo_identificador: (
        await obtenerTipoIdentificadorPersonaDadoCodigoFHIR(
          tran,
          codigoTipoIdentificador
        )
      ).id,
      id_uso: (
        await obtenerUsoIdentificadorPersonaDadoCodigoFHIR(
          tran,
          _identificador.use
        )
      ).id,
      valor: _identificador.value,
    };

    identificadores.push(identificador);
  }

  const officialName = name.find((n) => n.use === "official");
  const usualName = name.find((n) => n.use === "usual");

  return {
    nombre: officialName?.given.join(" ") ?? null,
    apellido_paterno: officialName?.family ?? null,
    apellido_materno: officialName?._family
      ? extraerSliceDesdeExtension(
          officialName?._family.extension,
          "SegundoApellido"
        ).valueString
      : null,

    nombre_social: usualName?.given.join(" ") ?? null,

    identificadores: identificadores,

    fecha_nacimiento: birthDate,

    id_sexo_biologico: (await obtenerSexoBiologicoDadoCodigoFHIR(tran, gender))
      .id,
    id_identidad_genero: (
      await obtenerIdentidadGeneroDadoCodigoDEIS(tran, codigoIdentidadGenero)
    ).id,
    id_religion: null,
    id_nacionalidad: (await obtenerPaisDadoCodigoDEIS(tran, codigoPaisOrigen))
      .id,
    id_pais_origen: (await obtenerPaisDadoCodigoDEIS(tran, codigoNacionalidad))
      .id,
    pertenece_a_pueblo_originario: pertenecientePuebloOriginario,
    pertenece_a_pueblo_afrodescendiente: pertenecientePuebloAfrodescendiente,
    id_pueblo_originario: null,
  };
}

/**
 * @param {TransactionOrConnectionPool} tran
 * @param {object} bundle
 * @returns {Promise<{ paciente: PacienteExtraido }>}
 */
export async function extraerBundleIniciarEnriquecido(tran, bundle) {
  const slicePaciente = extraerSlicesDesdeBundle(bundle, "PatientLE")[0];
  // const sliceAtencionInicial = extraerSlicesDesdeBundle(
  //   bundle,
  //   "EncounterIniciarLE"
  // )[0];
  // const sliceDiagnosticoInicial = extraerSlicesDesdeBundle(
  //   bundle,
  //   "ConditionDiagnosticoLE"
  // )[0];
  // const sliceObservacionDiscapacidad = extraerSlicesDesdeBundle(
  //   bundle,
  //   "ObservationDiscapacidadLE"
  // )[0];
  // const sliceObservacionCuidador = extraerSlicesDesdeBundle(
  //   bundle,
  //   "ObservationIniciarCuidadorLE"
  // )[0];

  // slicesObservacionResultadoExamen, slicesAlergiaOIntolerancia, slicesSolicitudExamen
  return {
    paciente: await extraerPacienteDesdeSlice(tran, slicePaciente),
  };
}
